# encoding: utf-8

require "singleton"

module ModeloQytetet
  class Qytetet
    include Singleton
      @@max_jugadores=4
      @@num_sorpresas = 10
      @@num_casillas=20
      @@precio_libertad=200
      @@saldo_salida=1000
    
    def initialize
      @mazo = Array.new
      @carta_actual
      @jugador_actual
      @jugadores=Array.new
      @dado=Dado.instance
      @estado=nil
      inicializar_tablero
    end
    

    protected
    attr_reader :mazo, :tablero,:jugador_actual,:jugadores,:dado
    attr_accessor :carta_actual, :estado
    public :mazo,:jugadores
    
    private
    def inicializar_cartas_sorpresa
      @mazo << Sorpresa.new("Te han pillado saqueando las arcas públicas del estado, vas a la cárcel.", @tablero.carcel.numCas, TipoSorpresa::IRACASILLA)
      @mazo << Sorpresa.new("No sabemos si estabas cerca de la casilla inicial o no, pero ahora lo vas a estar.", 1, TipoSorpresa::IRACASILLA)
      @mazo << Sorpresa.new("¿Eres supersticioso?", 13, TipoSorpresa::IRACASILLA)
      @mazo << Sorpresa.new("Resulta que un funcionario de la cárcel es amigo tuyo. De casualidades está hecha la vida. Sales de la cárcel.", 0, TipoSorpresa::SALIRCARCEL)
      @mazo << Sorpresa.new("Tus rivales te odian tanto que les obligamos a que te den lo que lleven suelto en la cartera.", 200, TipoSorpresa::PORJUGADOR)
      @mazo << Sorpresa.new("Parece que te está gustando el juego, por eso tendrás que recompensar a tus rivales.", -300, TipoSorpresa::PORJUGADOR)
      @mazo << Sorpresa.new("¡Enhorabuena! Te ha tocado la lotería, pero la agencia tributaria se va a quedar casi todo.", 250, TipoSorpresa::PAGARCOBRAR)
      @mazo << Sorpresa.new("Vamos a jugar a algo, tú me das algo de dinero y yo no te doy nada. ¿Qué te parece?", -250, TipoSorpresa::PAGARCOBRAR)
      @mazo << Sorpresa.new("Vaya, esta sorpresa parece que te va a quitar algo de dinero por los hoteles y casas de tus rivales, siempre y cuando tú estés de acuerdo... o no.", -150, TipoSorpresa::PORCASAHOTEL)
      @mazo << Sorpresa.new("Estás de suerte. Tus propiedades acaban de evadir impuestos y te dan algo más de dinero extra.", 200, TipoSorpresa::PORCASAHOTEL)
    end
    protected
    def actuar_si_en_casilla_edificable
      debo_pagar= @jugador_actual.debo_pagar_alquiler
      casilla=@jugador_actual.casillaActual
      tengo_propietario=casilla.tengo_propietario
      
      if(debo_pagar)
        @jugador_actual.pagar_alquiler
        if @jugador_actual.saldo<0
          @estado=EstadoJuego::ALGUNJUGADORENBANCARROTA
        end
      end
      if @estado!=EstadoJuego::ALGUNJUGADORENBANCARROTA
        if tengo_propietario
          @estado=EstadoJuego::JA_PUEDEGESTIONAR
        end
      else
        @estado=EstadoJuego::JA_PUEDECOMPRAROGESTIONAR
      end
    end   
    protected
    def actuar_si_en_casilla_no_edificable
      @estado=EstadoJuego::JA_PUEDEGESTIONAR
      casilla=@jugador_actual.casillaActual
      if casilla.tipo == TipoCasilla::IMPUESTO
        @jugador_actual.pagar_impuesto
      else
        if casilla.tipo==TipoCasilla::JUEZ
          encarcelar_jugador
        else
          if casilla.tipo==TipoCasilla::SORPRESA
            mazo.delete(@carta_actual) { |unusedlocal2|  }
            @estado=EstadoJuego::JA_CONSORPRESA
          end
        end
      end
    end
    public
    def aplicar_sorpresa
     @estado=EstadoJuego::PUEDOGESTIONAR
      
      if @cartaActual.tipo == TipoSorpresa::SALIRCARCEL
        @jugadorActual.set_carta_libertad(@cartaActual)
        
      else
        @mazo.push(@cartaActual)
        
        case @cartaActual.tipo
        when PAGARCOBRAR
          @jugadorActual.modificar_saldo(@cartaActual.valor)
          if
            @jugadorActual.saldo < 0
            @estado=EstadoJuego::ALGUNJUGADORENBANCARROTA
          end
        when IRACASILLA
          valor = @cartaActual.valor
          casilla_carcel = @tablero.es_casilla_carcel(valor)
          
          if casilla_carcel
            encarcelar_jugador
          else
            mover(valor)
          end
        when PORCASAHOTEL
          cantidad = @cartaActual.valor
          numero_total = @jugadorActual.cuantas_casas_hoteles_tengo
          @jugadorActual.modificar_saldo(cantidad*numero_total)
          
          if @jugadorActual.saldo < 0
            @estado=EstadoJuego::ALGUNJUGADORENBANCARROTA
          end
        when PORJUGADOR
          for i in @@MAX_JUGADORES-1
            jugador = siguiente_jugador
            
            if jugador != @jugadorActual
              jugador.modificar_saldo(@cartaActual.valor)
            end
            
            if jugador.saldo < 0
              @estado=EstadoJuego::ALGUNJUGADORENBANCARROTA
            end
            
            @jugadorActual.modificar_saldo(-@cartaActual.valor)
            
            if @jugadorActual.saldo < 0
              @estado=EstadoJuego::ALGUNJUGADORENBANCARROTA
            end
          end
        end
      end
    end


    def cancelar_hipoteca(numero_casilla)
      casilla=@jugador_actual.casillaActual
      titulo=casilla.titulo
      puede_cancelar=@jugador_acutal.cancelar_hipoteca(titulo)
      @estado=EstadoJuego::JA_PUEDEGESTIONAR
      return puede_cancelar
    end


    def comprar_titulo_propiedad
      comprado=@jugador_actual.comprar_titulo_propiedad
      if comprado
        @estado=EstadoJuego::JA_PUEDEGESTIONAR
      end
      return comprado
    end


    def edificar_casa(numero_casilla)
      casilla=@tablero.obtener_casilla_numero(numero_casilla)
      titulo=casilla.titulo
      edificada=@jugador_actual.edificar_casa(titulo)
      num_casas=titulo.numCasas
      
      
      if num_casas<4
        coste_edificar_casa=titulo.precioE
        tengo_saldo=@jugador_actual.tengo_saldo(coste_edificar_casa)
      end
      if tengo_saldo
        titulo.edificar_casa
        num_casas=num_casas+1
        @jugador_actual.modificar_saldo(-coste_edificar_casa)
        edificada=true
      end
      if edificada
        @estado=EstadoJuego::JA_PUEDEGESTIONAR
      end
      return edificada


    end

    def edificar_hotel(numero_casilla)
      casilla=@tablero.obtener_casilla_numero(numero_casilla)
      titulo=casilla.titulo
      edificada=@jugador_actual.edificar_hotel(titulo)
      num_hoteles=titulo.numHoteles
      
      
      if num_hoteles<4
        coste_edificar_hotel=titulo.precioE
        tengo_saldo=@jugador_actual.tengo_saldo(coste_edificar_hotel)
      end
      if tengo_saldo
        titulo.edificar_hotel
        num_hoteles=num_hoteles+1
        @jugador_actual.modificar_saldo(-coste_edificar_hotel)
        edificada=true
      end
      if edificada
        @estado=EstadoJuego::JA_PUEDEGESTIONAR
      end
      return edificada
    end


    private
    def encarcelar_jugador
      casilla_carcel=nil
      carta=nil
      if !@jugador_actual.tengo_carta_libertad
        casilla_carcel=@tablero.carcel
        @jugador_actual.ir_a_carcel(casilla_carcel)
        @jugador_actual.casillaActual=casilla_carcel
        @jugador_actual.encarcelado=true
        @estado=EstadoJuego::JA_ENCARCELADO
      else
        carta=@jugador_actual.devolver_carta_actual
        @mazo.push(carta)
        @estado=EstadoJuego::JA_PUEDEGESTIONAR
      end
    end

    protected
    def get_valor_dado
      return @dado.valor
    end
    public
    def hipotecar_propiedad(numero_casilla)
      casilla=@tablero.obtener_casilla_numero(casilla)
      titulo=casilla.titulo
      @jugador_actual.hipotecar_propiedad(titulo)
      @estado=EstadoJuego::JA_PUEDEGESTIONAR
    end  

    public
    def inicializar_juego(nombres)

    inicializar_tablero
    inicializar_cartas_sorpresa
    inicializar_jugadores(nombres)
    salida_jugadores
    end 
    
    private
    def inicializar_jugadores(nombres)
    nombres.each{ |nombre|
    @jugadores << Jugador.new(nombre)
    }
    end
    public
    def inicializar_tablero
      @tablero = Tablero.new
    end

    def intentar_salir_carcel(metodo)
      if metodo==MetodoSalirCarcel::TIRANDODADO
        resultado=tirar_dado
        if resultado>=5
          @jugador_actual.encarcelado=false
        end
      else
        if metodo==MetodoSalirCarcel::PAGANDOLIBERTAD
          cantidad=@@precio_libertad
          @jugador_actual.pagar_libertad(cantidad)
          tengo_saldo=@jugador_actual.tengo_saldo(cantidad)
          if tengo_saldo
            @jugador_actual.encarcelado=false
            @jugador_actual.modificar_saldo(-cantidad)
          end
        end
      end
      
      encarcelado=@jugador_actual.encarcelado
      if encarcelado
        @estado=EstadoJuego::JA_ENCARCELADO
      else
        @estado=EstadoJuego::JA_PREPARADO
      end
      return encarcelado
    end
    public
    def jugar()
      tirar_dado
      casilla=@tablero.obtener_casilla_final(@jugador_actual.casillaActual,@dado.valor)
      mover(casilla)
    end
    
    protected
    def mover(num_casilla_destino)
      casilla_inicial=@jugador_actual.casillaActual
      casilla_final=tablero.obtener_casilla_final(casilla_inicial,num_casilla_destino)
      if num_casilla_destino<casilla_inicial.numeroCasilla
        @jugador_actual.modificar_saldo(@@saldo_salida)
      end
      if casilla_final.soy_edificable
        actuar_si_en_casilla_edificable
      else
        actuar_si_en_casilla_no_edificable
      end
    end

    public
    def obtener_casilla_jugador_actual
      return @jugador_actual.casillaActual
    end

    def obtener_casillas_tablero
      return @tablero.casillas
    end

    def obtener_propiedades_jugador
      casillas=Array.new
      nombre=nil
      for i in @jugador_actual.propiedades
        nombre=@jugador_actual[i].nombre
        casillas << @tablero.casillas.index(nombre) { |item| }
      end
      return casillas
    end

    def obtener_propiedades_jugador_segun_estado_hipoteca(estado_hipoteca)
    casillas=Array.new
    nombre=nil
    for i in @jugador_actual.propiedades
      if @jugador_actual.propiedades[i].hipotecada=estado_hipoteca
        nombre=@jugador_actual[i].nombre
        casillas << @tablero.casillas.index(nombre) { |item| }
      end
    end

    end


    def obtener_ranking
      @jugadores=@jugadores.sort
    end 


    def obtener_saldo_jugador_actual
      return @jugador_actual.saldo
    end

    private
    def salida_jugadores
      for i in @jugadores.size
        @jugadores[i].casillaActual=0
      end
    end
    private
    def set_carta_actual(carta_actual)

    
    end

    
    public
    def siguiente_jugador
      numero = @jugadores.index(@jugador_actual) { |item|  }
      @jugador_actual=@jugadores[(numero+1)%4]
      if (@jugador_actual.encarcelado)
        @estado=EstadoJuego::JA_ENCARCELADOCONOPCIONDELIBERTAD
      else
        @estado=EstadoJuego::JA_PREPARADO
      end
    end

    protected
    def tirar_dado
      return @dado.tirar
    end

    public
    def vender_propiedad(numero_casilla)
      casilla=@jugador_actual.casillaActual
      @jugador_actual.vender_propiedad(casilla)
      @estado=EstadoJuego::JA_PUEDEGESTIONAR
    end
  end
end