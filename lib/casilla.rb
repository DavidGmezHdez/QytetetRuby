# encoding: utf-8

module ModeloQytetet
  class Casilla
    
    def initialize(tipo, numCas, titulo, coste)
      @numeroCasilla = numCas
      @tipo = tipo
      @titulo = titulo
      @coste = coste
    end
    
    def self.calle(numCas, titulo)
      new(TipoCasilla::CALLE, numCas, titulo, titulo.precioC)
    end
    
    def self.casilla(tipo, numCas, coste)
      new(tipo, numCas, nil, coste)
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
