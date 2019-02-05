# encoding: utf-8
require_relative "controlador_qytetet"
module VistaTextualQytetet
  class Vista_textual_qytetet
#    extend ControladorQytetet
    @@controlador=ControladorQytetet::ControladorQytetet.instance
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
      auxiliar = Array.new
      casillas=@@controlador.obtener_casillas_validas(opcion_menu)
      if casillas.empty?
        return -1
      else
        puts "Casillas validas: "
        for i in casillas.each
          puts i
          auxiliar << i.to_s
        end
        return leer_valor_correcto(auxiliar,false).to_i
      end
    end
    
    
    def leer_valor_correcto(valores_correctos,opcion)
      pertenece=false
      valor_correcto=""
      
      puts "Introduce una de las siguientes opciones: "
      
      if opcion
        for i in valores_correctos.each
          puts "Opcion: " + i.to_s + " - " + ControladorQytetet::OpcionMenu[i.to_i].to_s
        end
      else
        for i in valores_correctos.each
          puts "Casilla: " + i.to_s
        end
      end
      
      loop do
        valor = gets.chomp.to_i
        for i in valores_correctos.each
          if valor.to_i == i.to_i
            pertenece=true
            valor_correcto=valor
          end
        end
        break if pertenece
      end
     
      
      return valor_correcto
     
end
    
#    
#    
#    def leer_valor_correcto(valores_correctos)
#      pertenece=false
#      valor_correcto=""
#      
#      puts "Introduce una de las siguientes opciones: "
#      
#      for i in valores_correctos.each
#        puts "Opcion: " + i + " - " + ControladorQytetet::OpcionMenu[i.to_i].to_s
#      end
#      
#      loop do
#        valor = gets.chomp.to_i
#        for i in valores_correctos.each
#          if valor.to_i == i.to_i
#            pertenece=true
#            valor_correcto=valor
#          end
#        end
#        break if pertenece
#      end
#     
#      return valor_correcto
#     
#    end
    def elegir_operacion()
      lista=@@controlador.obtener_operaciones_juego_validas
      convertidos = Array.new
      
      for i in lista.each
        convertidos << i.to_s
      end
      
      return leer_valor_correcto(convertidos,true).to_i
    end
    
    def self.main
      ui = Vista_textual_qytetet.new
      @@controlador.nombre_jugadores = ui.obtener_nombre_jugadores
      operacion_elegida=0
      casilla_elegida=0
      
      loop do
        operacion_elegida=ui.elegir_operacion
        necesita_elegir_casilla=@@controlador.necesita_elegir_casilla(operacion_elegida)
        if necesita_elegir_casilla
          casilla_elegida=ui.elegir_casilla(operacion_elegida)
        end
        
        if !necesita_elegir_casilla || casilla_elegida>=0
          puts @@controlador.realizar_operacion(operacion_elegida, casilla_elegida)
        end
        break if 1!=1
      end
    end
  end
  Vista_textual_qytetet.main
end
