$:.unshift(File.dirname(__FILE__) + '/../lib')
RAILS_ROOT = File.dirname(__FILE__)

require 'rubygems'
require 'test/unit'
require 'lib/person.rb'
require 'lib/parser.rb'
require 'lib/populator.rb'

class Test::Unit::TestCase #:nodoc:
  # Add more helper methods to be used by all tests here...
  
  def parser_test_for(type, delimeter, *args)
    parser = Parser.new delimeter, *args
    File.open("data_files/#{type}.txt") do |f|
      @data.populate parser, f
    end
  end
end