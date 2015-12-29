require 'wsdl/file'

begin
  require 'pry'
rescue LoadError
end


module Wsdl2swift
  def self.root
    File.expand_path '../..', __FILE__
  end
end
