require File.dirname(__FILE__) + '/test_helper'
class ParserTest < Test::Unit::TestCase

  def setup
  end

  def teardown
  end

  def test_instantiation_as_space_parser
    assert Parser.new(' ', :last_name, :first_name, :middle_initial, :gender, :dob, :favorite_color)
  end

  def test_instantiation_as_pipe_parser
    assert Parser.new(' | ', :last_name, :first_name, :middle_initial, :gender, :favorite_color, :dob)
  end

  def test_instantiation_as_comma_parser
    assert Parser.new(', ', :last_name, :first_name, :gender, :favorite_color, :dob)
  end

  def test_space_parsing
    @data = Populator.new()
    parser_test_for :space, ' ', :last_name, :first_name, :middle_initial, :gender, :dob, :favorite_color
    assert_equal parsed_space_data, @data.records.collect{|person| person.to_s}
  end

  def test_pipe_parsing
    @data = Populator.new()
    parser_test_for :pipe, ' | ', :last_name, :first_name, :middle_initial, :gender, :favorite_color, :dob
    assert_equal parsed_pipe_data, @data.records.collect{|person| person.to_s}
  end

  def test_comma_parsing
    @data = Populator.new()
    parser_test_for :comma, ', ', :last_name, :first_name, :gender, :favorite_color, :dob
    assert_equal parsed_comma_data, @data.records.collect{|person| person.to_s}
  end

  private

  def parsed_space_data
    ['Kournikova Anna Female 06/03/1975 Red',
    'Hingis Martina Female 04/02/1979 Green',
    'Seles Monica Female 12/02/1973 Black']
  end

  def parsed_pipe_data
    ['Smith Steve Male 03/03/1985 Red',
    'Bonk Radek Male 06/03/1975 Green',
    'Bouillon Francis Male 06/03/1975 Blue']
  end

  def parsed_comma_data
    ['Abercrombie Neil Male 02/13/1943 Tan',
    'Bishop Timothy Male 04/23/1967 Yellow',
    'Kelly Sue Female 07/12/1959 Pink']
  end
end