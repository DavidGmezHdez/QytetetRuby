# encoding: utf-8

class Casilla
  def initialize(n_casilla,p_compra,tip,tit)
   @numero_casilla=n_casilla
   @precio_compra=p_compra
   @tipo=tip
   @titulo=tit
    
  end
  def tipocalle(tip,n_casilla,tit)
    @numero_casilla=n_casilla
    if tip==tipo_casilla.Calle
      @titulo=tit
      @tipo=tip
      @precio_compra=tit.precio_compra
    end
  end
   
  def notipocalle(tip,n_casilla)
    @numero_casilla=n_casilla
    if tip!=tipo_casilla.Calle
      @titulo=tip
      @precio_compra=0      
    end
  end
  
  attr_reader :numero_casilla, :precio_compra, :tipo, :titulo
  
  def to_s
    
    if (@tipo==tipo_casilla.Calle)
    "Numero Casilla: #{@numero_casilla} \n Precio Compra: #{@precio_compra} \n Tipo: #{@tipo} \n Titulo: #{@titulo}"
    end
    if (@tipo!=tipo_casilla.Calle)
    "Numero Casilla: #{@numero_casilla} \n Precio Compra: #{@precio_compra} \n Tipo: #{@tipo}"
    end
  
  end
  
  
  
  
end
