# encoding: utf-8

require "singleton"
require_relative 'qytetet'

module ControladorQytetet
  class ControladorQytetet
    @@modelo=Qytetet.instance
    def initialize
    @nombre_jugadores = Array.new
    instance = ControladorQytetet.new 
    end
    
    public
    
    attr_accessor :nombre_jugadores
    
    def obtener_operaciones_juego_validas()
      lista= Array.new
      
      if @@modelo.jugadores.size == 0
        lista<<OpcionMenu.index(:INICIARJUEGO)
      else
      case @@modelo.estado
        when EstadoJuego::JA_PREPARADO
          lista<<OpcionMenu.index(:JUGAR)
          lista<<OpcionMenu.index(:OBTENERRANKING)
          lista<<OpcionMenu.index(:MOSTRARJUGADORACTUAL)
          lista<<OpcionMenu.index(:MOSTRARJUGADORES)
          lista<<OpcionMenu.index(:MOSTRARTABLERO)
          lista<<OpcionMenu.index(:TERMINARJUEGO)
      when EstadoJuego::JA_PUEDEGESTIONAR
          lista<<OpcionMenu.index(:VENDERPROPIEDAD)
          lista<<OpcionMenu.index(:HIPOTECARPROPIEDAD)
          lista<<OpcionMenu.index(:CANCELARHIPOTECA)
          lista<<OpcionMenu.index(:EDIFICARCASA)
          lista<<OpcionMenu.index(:EDIFICARHOTEL)
          lista<<OpcionMenu.index(:SIGUIENTEJUGADOR)
          lista<<OpcionMenu.index(:PASARTURNO)
          lista<<OpcionMenu.index(:JUGAR)
          lista<<OpcionMenu.index(:OBTENERRANKING)
          lista<<OpcionMenu.index(:MOSTRARJUGADORACTUAL)
          lista<<OpcionMenu.index(:MOSTRARJUGADORES)
          lista<<OpcionMenu.index(:MOSTRARTABLERO)
          lista<<OpcionMenu.index(:TERMINARJUEGO)
      when EstadoJuego::JA_PUEDECOMPRAROGESTIONAR
          lista<<OpcionMenu.index(:VENDERPROPIEDAD)
          lista<<OpcionMenu.index(:HIPOTECARPROPIEDAD)
          lista<<OpcionMenu.index(:CANCELARHIPOTECA)
          lista<<OpcionMenu.index(:EDIFICARCASA)
          lista<<OpcionMenu.index(:EDIFICARHOTEL)
          lista<<OpcionMenu.index(:SIGUIENTEJUGADOR)
          lista<<OpcionMenu.index(:PASARTURNO)
          lista<<OpcionMenu.index(:JUGAR)
          lista<<OpcionMenu.index(:OBTENERRANKING)
          lista<<OpcionMenu.index(:MOSTRARJUGADORACTUAL)
          lista<<OpcionMenu.index(:MOSTRARJUGADORES)
          lista<<OpcionMenu.index(:MOSTRARTABLERO)
          lista<<OpcionMenu.index(:COMPRARTITULOPROPIEDAD)
          lista<<OpcionMenu.index(:TERMINARJUEGO)
      when EstadoJuego::JA_ENCARCELADOCONOPCIONDELIBERTAD
          lista<<OpcionMenu.index(:INTENTARSALIRCARCELTIRANDODADO)
          lista<<OpcionMenu.index(:INTENTARSALIRCARCELPAGANDOLIBERTAD)
          lista<<OpcionMenu.index(:OBTENERRANKING)
          lista<<OpcionMenu.index(:MOSTRARJUGADORACTUAL)
          lista<<OpcionMenu.index(:MOSTRARJUGADORES)
          lista<<OpcionMenu.index(:MOSTRARTABLERO)
      when EstadoJuego::JA_ENCARCELADO
          lista<<OpcionMenu.index(:SIGUIENTEJUGADOR)
          lista<<OpcionMenu.index(:PASARTURNO)
          lista<<OpcionMenu.index(:OBTENERRANKING)
          lista<<OpcionMenu.index(:MOSTRARJUGADORACTUAL)
          lista<<OpcionMenu.index(:MOSTRARJUGADORES)
          lista<<OpcionMenu.index(:MOSTRARTABLERO)
      when EstadoJuego::JA_CONSORPRESA
          lista<<OpcionMenu.index(:APLICARSORPRESA)
      when EstadoJuego::ALGUNJUGADORENBANCARROTA
          lista<<OpcionMenu.index(:OBTENERRANKING)
          lista<<OpcionMenu.index(:TERMINARJUEGO)
          lista<<OpcionMenu.index(:MOSTRARJUGADORACTUAL)
          lista<<OpcionMenu.index(:MOSTRARJUGADORES)
          lista<<OpcionMenu.index(:MOSTRARTABLERO)
      end
      end
      
      return lista
    end

    def necesita_elegir_casilla(opcion_menu)
      necesita_elegir = false
      if opcion_menu == OpcionMenu.index(:HIPOTECARPROPIEDAD)
        necesita_elegir=true
      end
      if opcion_menu == OpcionMenu.index(:VENDERPROPIEDAD)
        necesita_elegir=true
      end
      if opcion_menu == OpcionMenu.index(:CANCELARHIPOTECA)
        necesita_elegir=true
      end
      if opcion_menu == OpcionMenu.index(:EDIFICARCASA)
        necesita_elegir=true
      end
      if opcion_menu == OpcionMenu.index(:EDIFICARHOTEL)
        necesita_elegir=true
      end
      return necesita_elegir
    end
    
    def obtener_casillas_validas(opcion_menu)
      casillas_validas=Array.new
      if opcion_menu == OpcionMenu.index(:HIPOTECARPROPIEDAD)
        casillas_validas=@@modelo.obtener_propiedades_jugador
      else
        if opcion_menu == OpcionMenu.index(:VENDERPROPIEDAD)
          casillas_validas=@@modelo.obtener_propiedades_jugador
        else
          if opcion_menu == OpcionMenu.index(:CANCELARHIPOTECA)
            casillas_validas=@@modelo.obtener_propiedades_jugador_segun_estado_hipoteca(true)
          else
            if opcion_menu == OpcionMenu.index(:EDIFICARCASA)
              casillas_validas=@@modelo.obtener_propiedades_jugador
            else
              if opcion_menu == OpcionMenu.index(:EDIFICARHOTEL)
                casillas_validas=@@modelo.obtener_propiedades_jugador
              end
            end
          end
        end
      end
      return casillas_validas
    end
    
    def realizar_operacion(opcion_elegida, casilla_elegida)
      case opcion_elegida
      when 0 #INICIAR JUEGO
        @@modelo.inicializar_juego(@nombreJugadores)
        resultado = "Inicializando juego"
      when 1 #JUGAR
        @@modelo.jugar
        resultado="Valor dado " + @@modelo.dado + ". Casilla actual " + @@modelo.casillaActual 
      when 2 #APLICAR SORPRESA
        resultado="La sorpresa es " + @@modelo.carta_actual
        @@modelo.aplicar_sorpresa
      when 3 #INTENTAR SALIR CARCEL PAGANDO LIBERTAD
        salido=@@metodo.intentar_salir_carcel(MetodoSalirCarcel::PAGANDOLIBERTAD)
        if salido
          resultado = "¡Has salido de soto del real"
        else
          resultado = "Te has caido con las prisas y no has conseguido escapar"
        end
      when 4 #INTENTAR SALIR CARCEL TIRANDO DADO  
        salido = @@modelo.intentar_salir_carcel(MetodoSalirCarcel::TIRANDODADO)
        if salido
          resultado = "¡Has salido de soto del real"
        else
          resultado = "Te has caido con las prisas y no has conseguido escapar"
        end
      when 5 #COMPRAR TITULO PROPIEDAD
        comprado=@@modelo.comprar_titulo_propiedad
        if comprado
          resultado = "Enhorabuena ahora tienes una propiedad más"
        else
          resultado = "Lo sentimos pero no tiene usted suficiente cash"
        end
      when 6 #HIPOTECAR PROPIEDAD
        @@modelo.hipotecar_propiedad(casilla_elegida)
        resultado = "Ha hipotecado usted su propiedad"
      when 7 #CANCELAR HIPOTECA
        cancelada = @@modelo.cancelar_hipoteca(casilla_elegida)
        if cancelada
          resultado = "Ha logrado deshacerse de esa birria"
        else
          resultado = "Mala suerte, tendrá que seguir pagando a Hacienda"
        end
      when 8 #EDIFICAR CASA
        edificada=@@modelo.edificar_casa(casilla_elegida)
        if edificada
          resultado = "Ha construido usted una preciosa casita"
        else
          resultado = "Tendrás que seguir acostumbrado a la tienda de campaña"
        end
      when 9 #EDIFICAR HOTEL
        edificada = @@modelo.edificar_hotel(casilla_elegida)
        if edificada
          resultado = "Hotel construido, ¡se ve desde la estacion espacial!"
        else
          resultado = "Hotel no construido, el arquitecto te ha devuelto los papeles"
        end
      when 10 #VENDER PROPIEDAD
        resultado = "Has vendido la propiedad. Espero que te acordaras de coger al gato"
        @@modelo.vender_propiedad(casilla_elegida)
      when 11 #PASAR TURNO
        resultado = "Cambio de jugador"
        @@modelo.siguiente_jugador
      when 12 #OBTENER RANKING
        resultado = "Imprimiendo el ranking de los jugadores"
        @@modelo.obtener_ranking
      when 13 #MOSTRAR JUGADOR ACTUAL
        resultado = "Imrpimiendo el jugador actual"
        @@modelo.jugador_actual
      when 14 #MOSTRAR JUGADORES
        resultado = "Imprimiendo los jugadores"
        @@modelo.jugadores
      when 15 #MOSTRAR TABLERO
        resultado = "Imprimiendo tablero"
        @@modelo.tablero.to_s
      when 16 #TERMINAR JUEGO
        resultado = "Cerrando juego"
        exit(0)
      end
    end
end
  end

