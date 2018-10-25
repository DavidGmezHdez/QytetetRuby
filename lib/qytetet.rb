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
      
      inicializar_tablero
    end
    

    protected
    attr_reader :mazo, :tablero,:jugador_actual,:jugadores,:dado
    attr_accessor :carta_actual
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

      raise NotImplementedError
    
    end   
    protected
    def actuar_si_en_casilla_no_edificable

      raise NotImplementedError

    end
    public
    def aplicar_sorpresa
     
      raise NotImplementedError
    
    end


    def cancelar_hipoteca(numero_casilla)

    
    end


    def comprar_tiitulo_propiedad



    end


    def edificar_casa(numero_casilla)



    end

    def edificar_hotel(numero_casilla)



    end


    private
    def encarcelar_jugador

      

    end

    protected
    def get_valor_dado



    end
    public
    def hipotecar_propiedad(numero_casilla)

    

    end  

    public
    def inicializar_juego(nombres)

    inicializar_tablero
    inicializar_cartas_sorpresa
    inicializar_jugadores(nombres)

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

    end
    public
    def jugar()

    end
    
    protected
    def mover(num_casilla_destino)

    

    end

    public
    def obtener_casilla_jugador_actual


    end

    def obtener_casillas_tablero
    

    end

    def obtenerPropiedadesJugador
    
    
    end


    def obtener_propiedades_jugador_segun_estado_hipoteca(estado_hipoteca)
    

    end


    def obtener_ranking

    
    end 


    def obtener_saldo_jugador_actual


    end

    private
    def salida_jugadores

    end
    private
    def set_carta_actual(carta_actual)

    
    end

    
    public
    def siguiente_jugador

    end

    protected
    def tirar_dado

    end

    public
    def vender_propiedad(numero_casilla)

    end
  end
end