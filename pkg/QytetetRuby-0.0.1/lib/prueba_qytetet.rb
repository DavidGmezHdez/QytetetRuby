# encoding: utf-8
# author: Francisco Domínguez.

require_relative "sorpresa"
require_relative "qytetet"

module ModeloQytetet
  class PruebaQytetet
    @@juego = Qytetet.new
    
    def self.mayor_que_cero
      mayor_cero = Array.new
#      mayor_cero << 3
#      puts "entra"
#      puts @@juego.mazo.inspect
      @@juego.mazo.each { |carta|
#        puts carta.inspect
        if carta.valor > 0
          mayor_cero << carta
        end
      }
#      puts mayor_cero.inspect
      return mayor_cero.to_s
    end
    
#    def self.tipo_casilla
#      @tipo_casilla = Array.new
#      @@juego.mazo.each do |carta|
#        if @@juego.mazo.tipo == TipoSorpresa::IRACASILLA
#          @tipo_casilla << carta
#        end
#      end
#      return @tipo_casilla.to_s
#    end
#    
#    def self.tipo_sorpresa(sorpresa)
#      @tipo_sorpresa = Array.new
#      @@juego.mazo.each do |carta|
#        if @@juego.mazo.tipo == sorpresa
#          @tipo_sorpresa << carta
#        end
#      end
#      return @tipo_sorpresa.to_s
#    end
    
    def self.main
      @@juego.inicializar_cartas_sorpresa
      
      puts "Cartas con valor mayor a cero: "
      puts mayor_que_cero << "\n"
      
#      puts "Cartas del tipo ir a casilla: "
#      puts tipo_casilla << "\n"
#      
#      TipoSorpresa::constants.each do |const_get|
#        puts "Cartas del tipo #{const_get}: "
#        puts tipo_sorpresa(const_get)
#      end
    end
  end
  
  PruebaQytetet.main
end