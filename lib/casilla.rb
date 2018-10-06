# encoding: utf-8

module ModeloQytetet
  class Casilla
    
    def initialize(tipo, numCas, titulo)
      @numCas = numCas
      @tipo = tipo
      
      if titulo == nil
        @precioCompra = 0
      else
        @precioCompra = titulo.precioC
        @titulo = titulo
      end
    end
    
    def self.new2(tipo, numCas)
      self.new(tipo, numCas, nil)
    end
    
    attr_reader :numCas, :tipo, :precioCompra
    attr_accessor :titulo
    private :titulo
    
    def to_s
      if @tipo == TipoCasilla::CALLE
        "Casilla: numeroCasilla: #{@numCas} \n precioCompra: #{@precioCompra} \n tipo: #{@tipo} \n titulo: #{@titulo}"
      else
        "Casilla: numeroCasilla: #{@numCas} \n precioCompra: #{@precioCompra} \n tipo: #{@tipo}"
      end
    end
  
    protected
    def signar_propietario(jugador)
    
    
    end
    protected
    def pagar_alquiler
    
    
    end
    protected
    def propietario_encarcelado
    
    
    end
    protected
    def soy_edificable
    
    
    end
    protected
    def tengo_propietario
    
    
    end
    
  end
end
