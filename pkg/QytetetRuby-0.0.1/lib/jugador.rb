# encoding: utf-8
module ModeloQytetet
class Jugador
  def initialize(nombre)
      @encarcelado = false
      @nombre = nombre
      @saldo = 7500
      @cartaLibertad = nil
      @casillaActual=0
      @propiedades = Array.new
      
    end
    
    attr_reader :nombre, :saldo
    attr_accessor :encarcelado, :cartaLibertad, :casillaActual, :propiedades

  protected
    def to_s
        capital=obtener_capital
            "Jugador: #{@nombre} \n encarcelado: #{@encarcelado} \n 
      propiedades: #{@propiedades} \n saldo: #{@saldo} \n capital: #{capital} \n casillaActual: #{@casillaActual}"
    end
public
  def cancelar_hipoteca(titulo)
    puede_cancelar=false
    coste_cancelar=titulo.calcular_coste_cancelar
    if @saldo>coste_cancelar
      titulo.cancelar_hipoteca
      puede_cancelar=true
    end
    return puede_cancelar
  end
  
 
  def comprar_titulo_propiedad
      coste_compra = @casillaActual.precioCompra
      comprado = false
      
      if coste_compra < @saldo
        titulo = @casillaActual.asignar_propietario(self)
        @propiedades.push(titulo)
        modificar_saldo(-coste_compra)
        comprado = true
      end
    return comprado
  end

  def cuantas_casas_hoteles_tengo
    contador=0
    for i in @propiedades.size
      contador=contador + @propiedades[i].numCasas + @propiedades[i].numHoteles
    end
    return contador
  end  
  

  def debo_pagar_alquiler
    titulo = @casillaActual.titulo
    esdemipropiedad = es_de_mi_propiedad(titulo)
      
      if !esdemipropiedad
        tiene_propietario = titulo.tengo_propietario
      end
      
      if !esdemipropiedad && tiene_propietario
        encarc = titulo.propietario_encarcelado
      end
      
      if !esdemipropiedad && tiene_propietario && !encarc
        esta_hipotecada = titulo.hipotecada
      end
      
      debo_pagar = !esdemipropiedad && tiene_propietario && !encarc && !esta_hipotecada
      
  return debo_pagar
  end

  def devolver_carta_libertad
    inter=Sorpresa.new(@carta_libertad.texto,@carta_libertad.tipo,@carta_libertad.sorpresa)
    @carta_libertad=nil
    return inter
  end
  

  def edificar_casa(titulo)
    hay_espacio=titulo.numCasas<4
    tengo_saldo=false
    coste_edificar_casa=0
    if hay_espacio
      coste_edificar_casa=titulo.precioE
      tengo_saldo=tengo_saldo(coste_edificar_casa)
    end
    if hay_espacio && tengo_saldo
        @casillaActual.titulo.edificar_casa
        modificar_saldo(-coste_edificar_casa)
    end
    edificada=hay_espacio && tengo_saldo
    return edificada
  end
  

  def edificar_hotel(titulo)
    edificada=false
    num_hoteles=titulo.numHoteles
    if num_hoteles<4
      coste_edificar_hotel=titulo.precioE
      tengo_saldo=tengo_saldo(coste_edificar_hotel)
      if tengo_saldo
        @casillaActual.titulo.edificar_hotel
        modificar_saldo(-coste_edificar_hotel)
        edificada=true
      end
    end
    return edificada
  end


  def eliminar_de_mis_propiedades(titulo)
    @propiedades.delete(titulo)
    titulo.propietario=nil
  end

 
  def es_de_mi_propiedad(titulo)
    tiene = false
      
      for i in @propiedades
        if i == titulo
          tiene = true
        end
      end    
  return tiene
  end

  
  def estoy_en_calle_libre
    calle_libre=false
    if @casillaActual.titulo.propietario !=nil
      calle_libre=true
    end
    return calle_libre
  end


  def hipotecar_propiedad(titulo)
    coste=titulo.hipotecar
    modificar_saldo(coste)
  end
  

  def ir_a_carcel(casilla)
    if casilla.tipo == TipoCasilla::CARCEL
      @casillaActual=casilla
    end
  end


  def modificar_saldo(cantidad)
    @saldo+=cantidad
    return @saldo
  end


  def obtener_capital
    resultado=@saldo
    for i in @propiedades
      resultado=resultado + i.precioC + (i.precioE*i.numHoteles) 
      + (i.precioE + i.numCasas)
      if i.hipotecada
        resultado=resultado - i.hipotecaB
      end
    end
    return resultado
  end


  def obtener_propiedades(hipotecada)
    propieadeshipo=Array.new
    for i in @propiedades
      if i.hipotecada==hipotecada
        propieadeshipo << i
      end
    end
    return propieadeshipo
  end

 
  def pagar_alquiler
    coste_alquiler=@casillaActual.titulo.calcular_importe_alquiler
    @casillaActual.titulo.propietario.modificar_saldo(coste_alquiler)
    modificar_saldo(-coste_alquiler)
  end
  

  def pagar_impuesto
    @saldo=@saldo-@casillaActual.coste
  end

 
  def pagar_libertad(cantidad)
    tengo_saldo=tengo_saldo(cantidad)
    
    if tengo_saldo
      @encarcelado=false
      modificar_saldo(-cantidad)
    end
  end
  

  def tengo_carta_libertad
    return @carta_libertad!=nil
  end
  
  
  def tengo_saldo(cantidad)
    resultado=false
    if @saldo>cantidad
      resultado=true
    end
    return resultado
  end
  
  
  def vender_propiedad(casilla)
    titulo=casilla.titulo
    eliminar_de_mis_propiedades(titulo)
    precio_venta=titulo.calcular_precio_venta
    modificar_saldo(precio_venta)
  end
  
  def <=>(otroJugador)
    otroCapital= otroJugador.obtenerCapital
    miCapital=obtenerCapital
    
    if (otroCapital>miCapital)
      return 1 
    end
   
    if (otroCapital<miCapital)
      return -1 
    end
    
    return 0
  end
  private :es_de_mi_propiedad, :eliminar_de_mis_propiedades
 end
end