# encoding: utf-8
class TituloPropiedad
  def initialize(nombr,p_compra,a_base,f_revalorizacion,h_base,p_edificar)
    @nombre = nombr
    @precio_compra = p_compra
    @alquiler_base = a_base
    @factor_revalorizacion = f_revalorizacion
    @hipoteca_base = h_base
    @precio_edificar = p_edificar
    @hipotecada = false
    @numero_hoteles = 0
    @numero_casas = 0
  end
  
   attr_reader :nombre, :precio_compra, :alquiler_base, :factor_revalorizacion, :hipoteca_base, :precio_edificar, :hipotecada, :numero_hoteles, :numero_casas 
  
  def to_s
    "Nombre: #{@nombre} \n Precio Compra: #{@precio_compra} \n Alquiler Base: #{@alquiler_base} \n Factor Revalorizacion: #{@factor_revalorizacion} 
    \n Hipoteca Base: #{@hipoteca_base} \n Precio Edificar: #{@precio_edificar} \n Hipotecada: #{@hipotecada} \n Numero Hoteles: #{@numero_hoteles}
    \n Numero Casas: #{@numero_casas}"
  end
  
end
