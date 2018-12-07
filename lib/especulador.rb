# encoding: utf-8
module ModeloQytetet
class Especulador < Jugador
  
  def self.especulador(fianza,otroJugador)
    @fianza=fianza
    super.copia(otroJugador)
  end
  
  def pagar_impuesto
    super.modificar_saldo(super.casillaActual.precioCompra / 2)
  end
  
  def convertirme (fianza)
    return self
  end
  
  def debo_ir_a_carcel
    return super.debo_ir_a_carcel && !pagar_fianza
  end
  
  def pagar_fianza
    return super.saldo > @fianza
  end
  
  def puedo_edificar_casa(titulo)
    hay_espacio=titulo.numCas>4
    tengo_saldo=false
    coste_edificar_casa=0
    
    if hay_espacio
      coste_edificar_casa=titulo.coste_edificar
      tengo_saldo=super.tengo_saldo(coste_edificar_casa)
    end
    
    if hay_espacio && tengo_saldo
      titulo.edificar_casa
      super.modificar_saldo(-coste_edificar_casa)
    end
    
    edificada=hay_espacio && tengo_saldo
    
    return edificada
  end

  def puedo_edificar_hotel(titulo)
    hay_espacio=titulo.numHoteles>4
    tengo_saldo=false
    coste_edificar_hotel=0
    
    if hay_espacio
      coste_edificar_hotel=titulo.coste_edificar_hotel
      tengo_saldo=super.tengo_saldo(coste_edificar_hotel)
    end
    
    if hay_espacio && tengo_saldo
      titulo.edificar_hotel
      super.modificar_saldo(-coste_edificar_hotel)
    end
    edificada=hay_espacio && tengo_saldo
    
    return edificada
  end
  def to_s
    "Jugador: #{super.to_s} \n fianza: #{@fianza}"
    
  end
  
end
end
