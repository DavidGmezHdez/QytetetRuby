# encoding: utf-8

module ModeloQytetet
  class TituloPropiedad
    
    def initialize(nombre, precioC, alquilerB, factorR, hipotecaB, precioE)
      @nombre = nombre
      @precioC = precioC
      @alquilerB = alquilerB
      @factorR = factorR
      @hipotecaB = hipotecaB
      @precioE = precioE
      @hipotecada = false
      @numHoteles = 0
      @numCasas = 0
      @propietario
    end
    
    attr_reader :nombre, :precioC, :alquilerB, :factorB,
      :hipotecaB, :precioE, :numHoteles, :numCasas
    
    attr_accessor :hipotecada,:propietario
    
    def to_s
      "nombre: #{@nombre} \n precioCompra: #{@precioC} \n alquilerBase: #{@alquierB} \n
      factorRevalorización: #{@factorR} \n hipotecaBase: #{@hipotecaB} \n precioEdificar: #{@precioE} \n
      hipotecada: #{@hipotecada} \n numHoteles: #{@numHoteles} \n numCasas: #{@numCasas}"
    end
    
    protected
    def calcular_Coste_cancelar
      
      
    end
    
    def calcular_coste_hipotecar
      
      
      
    end
    
    def calcular_importe_alquiler
      
      
      
    end
    
    def calcular_precio_venta
      
      
      
    end
    
    def cancelar_hipoteca
      
      
      
    end
    
    def cobrar_alquiler(coste)
      
      
    end
    
    def edificar_casa
      
      
      
    end
    
    def edificar_hotel
      
      
      
    end
    
    def hipotecar
      
      
      
    end
    
    def pagar_alquiler
      
      
      
    end
    
    def propietario_encarcelado
      
      
      
    end
    
    def tengo_propietario
      
      
      
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  end
end
