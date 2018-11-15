# encoding: utf-8

module ModeloQytetet
  class Casilla
    
    def initialize(tipo, numCas, titulo, coste)
      @numCas = numCas
      @tipo = tipo
      @titulo = titulo
      @precioCompra = coste
    end
    
    def self.calle(numCas, titulo)
      new(TipoCasilla::CALLE, numCas, titulo, titulo.precioC)
    end
    
    def self.casilla(tipo, numCas, coste)
      new(tipo, numCas, nil, coste)
    end
    
    attr_reader  :tipo, :precioCompra
    attr_accessor :titulo, :numCas

    
    def to_s
      if @tipo == TipoCasilla::CALLE
        "Casilla: numeroCasilla: #{@numCas} \n precioCompra: #{@precioCompra} \n tipo: #{@tipo} \n titulo: #{@titulo}"
      else
        "Casilla: numeroCasilla: #{@numCas} \n precioCompra: #{@precioCompra} \n tipo: #{@tipo}"
      end
    end
  

    def asignar_propietario(jugador)
        @titulo.propietario=jugador
      return @titulo
    end

    def pagar_alquiler
      return @titulo.debo_pagar_alquiler
    end

    def propietario_encarcelado
      return @titulo.propietario_encarcelado
    end

    def soy_edificable
      resultado=false
      if @tipo == TipoCasilla::CALLE
        resultado=true
      end
      return resultado
    end

    def tengo_propietario
      return @titulo.tengo_propietario
    end
    
  end
end
