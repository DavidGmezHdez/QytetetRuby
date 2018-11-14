# encoding: utf-8
require "singleton"
module ModeloQytetet
class Dado
  include Singleton
  def initialize
    @dado
    @valor=0
  end
  
  attr_reader :valor
  
  protected
  def tirar
    r = rand(1..6)
    @valor=r
    return r
  end
 end
end