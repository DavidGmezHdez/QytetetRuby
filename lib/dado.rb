# encoding: utf-8
require "singleton"

class Dado
  include Singleton
  def initialize
    @dado
    @valor=0
  end
  
  attr_reader :valor
  
  protected
  def tirar
    
    
  end
  
end
