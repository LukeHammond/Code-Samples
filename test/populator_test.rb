require File.dirname(__FILE__) + '/test_helper'
class PopulatorTest < Test::Unit::TestCase

  def setup
  end

  def teardown
  end

  def test_instantiation
    assert Populator.new()
  end

  def test_populate
    @data = Populator.new()
    parser_test_for :pipe, ' | ', :last_name, :first_name, :middle_initial, :gender, :favorite_color, :dob
    assert_nil @data.records.detect{|record| !record.is_a? Person }
  end

  def test_sort_by
    @data = Populator.new()
    parser_test_for :space, ' ', :last_name, :first_name, :middle_initial, :gender, :dob, :favorite_color
    parser_test_for :pipe, ' | ', :last_name, :first_name, :middle_initial, :gender, :favorite_color, :dob
    parser_test_for :comma, ', ', :last_name, :first_name, :gender, :favorite_color, :dob
    @data.sort_by @data.sort_by(:gender, :last_name)
    assert_equal sorted_by_gender_and_last_name, @data.records.collect{|person| person.to_s}
    @data.sort_by @data.sort_by(:dob, :last_name)
    assert_equal date_of_birth_and_last_name, @data.records.collect{|person| person.to_s}
    @data.sort_by @data.sort_by(:last_name)
    assert_equal sorted_by_last_name_descending, @data.records.collect{|person| person.to_s}.reverse
  end

  def test_reset
    test_populate
    @data.reset
    assert @data.records.empty?
  end

  private
  def sorted_by_gender_and_last_name
    ['Hingis Martina Female 04/02/1979 Green',
    'Kelly Sue Female 07/12/1959 Pink',
    'Kournikova Anna Female 06/03/1975 Red',
    'Seles Monica Female 12/02/1973 Black',
    'Abercrombie Neil Male 02/13/1943 Tan',
    'Bishop Timothy Male 04/23/1967 Yellow',
    'Bonk Radek Male 06/03/1975 Green',
    'Bouillon Francis Male 06/03/1975 Blue',
    'Smith Steve Male 03/03/1985 Red']
  end

  def date_of_birth_and_last_name
    ['Abercrombie Neil Male 02/13/1943 Tan',
    'Kelly Sue Female 07/12/1959 Pink',
    'Bishop Timothy Male 04/23/1967 Yellow',
    'Seles Monica Female 12/02/1973 Black',
    'Bonk Radek Male 06/03/1975 Green',
    'Bouillon Francis Male 06/03/1975 Blue',
    'Kournikova Anna Female 06/03/1975 Red',
    'Hingis Martina Female 04/02/1979 Green',
    'Smith Steve Male 03/03/1985 Red']
  end

  def sorted_by_last_name_descending
    ['Smith Steve Male 03/03/1985 Red',
    'Seles Monica Female 12/02/1973 Black',
    'Kournikova Anna Female 06/03/1975 Red',
    'Kelly Sue Female 07/12/1959 Pink',
    'Hingis Martina Female 04/02/1979 Green',
    'Bouillon Francis Male 06/03/1975 Blue',
    'Bonk Radek Male 06/03/1975 Green',
    'Bishop Timothy Male 04/23/1967 Yellow',
    'Abercrombie Neil Male 02/13/1943 Tan']
  end

end