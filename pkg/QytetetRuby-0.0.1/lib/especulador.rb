module ModeloQytetet
  class Especulador < Jugador
    attr_accessor :fianza
    def self.copia(unJugador, fianza)
      @fianza
      especulador = super(unJugador)
      especulador.fianza = fianza
      
      return especulador
    end
    
    
    def pagar_impuesto
      modificar_saldo(-casilla_actual.precioC/2)
    end
    
    def convertirme(fianza)
      return self
    end
    
    def debo_ir_a_carcel
      resultado = false
      
      if super && !pagar_fianza
        resultado = true
      end
      
      return resultado
    end
    
    
    def pagar_fianza
      puede_pagar = false
      
      if tengo_saldo(@fianza)
        modificar_saldo(-@fianza)
        puede_pagar = true
      end
      
      return puede_pagar
    end
    
    
    def puedo_edificar_casa(titulo)
      tengo_saldo = false
      
      if tengo_saldo(titulo.precioE)
        tengo_saldo=true
      end

      return titulo.numCasas < 8 && tengo_saldo && !titulo.hipotecada
    end
    
    def puedo_edificar_hotel(titulo)
      tengo_saldo=false
      
      if tengo_saldo(titulo.precioE)
        tengo_saldo=true
      end
 
      return titulo.numHoteles < 8 && tengo_saldo && !titulo.hipotecada
    end
    
    def to_s
      return super + "\n Especulador, fianza: #{@fianza}"
    end
    
    private:pagar_fianza
  end
end