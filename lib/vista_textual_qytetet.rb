# encoding: utf-8

require_relative 'controlador_qytetet'
module VistaTextualQytetet
  class Vista_textual_qytetet
    @@controlador=ControladorQytetet.instance
    public
    def obtener_nombre_jugadores
      nombres=Array.new
      i=0
      
      puts "Introduce el numero de jugadores: "
      numero_jugadores=gets.chomp.to_i
      
      while i < numero_jugadores
        puts "Introduce los nombres de los jugadores"
        nombres[i] = gets
        i+=1
      end
      
      return nombres
      
    end
    def elegir_casilla(opcion_menu)
      casillas=Array.new
      casillas=@@controlador.obtener_casillas_validas(opcion_menu)
      if casillas.null
        return -1
      else
        puts casillas
        return leer_valor_correcto(casillas)
      end
      
      
    end
    def leer_valor_correcto(valores_correctos)
      pertenece=false
      
      puts "Introduce una de las siguientes opciones: "
      for i in valores_correctos.size
        puts valores_correctos.get(i) 
      end
      
      introducido=gets.chomp.to_i
      
      for i in valores_correctos.size
        if introducido.to_i == valores_correctos.get(i).to_i
          pertenece = true
          valor_correcto = valores_correctos.get(i)
          break
        end
      end
      
      if !pertenece
        valor_correcto="El valor introducido no coincide con el de las opciones"
      end
      
      return valor_correcto
      
    end
    def elegir_operacion()
      lista=Array.new
      lista=@@controlador.obtener_operaciones_juego_validas
      return leer_valor_correcto(lista)
    end
    
    def self.main
      ui = VistaTextualQytetet.new
      @@controlador.nombre_jugadores = ui.obtener_nombre_jugadores
      operacion_elegida=0
      casilla_elegida=0
      
      loop do
        operacion_elegida=ui.elegir_operacion
        necesita_elegir_casilla=@@controlador.necesita_elegir_casilla(operacion_elegida)
        if necesita_elegir_casilla
          casilla_elegida=ui.elegir_casilla
        end
        if !necesita_elegir_casilla || casilla_elegida>0
          puts @@controlador.realizar_operacion(operacion_elegida, casilla_elegida)
        end
        break if 1!=1
      end
    end
  end
  VistaTextualQytetet.main
end
