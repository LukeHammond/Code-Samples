require File.dirname(__FILE__) + '/test_helper'
class PersonTest < Test::Unit::TestCase

  def setup
  end

  def teardown
  end

  def test_instantiation
    assert_raise(ArgumentError) do
      Person.new()
    end
    assert_raise(ArgumentError) do
      Person.new("Fred")
    end
    assert Person.new({})
  end

  def test_to_s
    assert_equal 'Smith Steve Male 03/03/1985 red', me.to_s
  end

  def test_compare
    assert_equal 0, me.compare(you, [:last_name])
    assert_equal 1,  me.compare(you, [:gender, :last_name])
    assert_equal 0, me.compare(you, [:dob, :last_name])
    assert_equal -1, me.compare(you, [:dob, :last_name, :favorite_color])
    assert_equal -1, me.compare(you, [:dob, :favorite_color, :last_name,])
  end

  def test_dob_is_a_date
    person = Person.new({:dob=>'12-31-1999'})
    assert person.dob.is_a?(Date)
    assert_equal Date.parse('12/31/1999'), person.dob
    person.dob = '01-01-2000'
    assert_equal Date.parse('01/01/2000'), person.dob
    person.dob = Date.parse('01/01/2000')
    assert_equal Date.parse('01/01/2000'), person.dob
  end

  def test_gender_mapping
    person = Person.new({:gender=>'F'})
    assert_equal 'Female', person.gender
    person = Person.new({:gender=>'M'})
    assert_equal 'Male', person.gender
    person = Person.new({:gender=>'Female'})
    assert_equal 'Female', person.gender
    person = Person.new({:gender=>'Male'})
    assert_equal 'Male', person.gender
  end

  private
  def me
    Person.new({:last_name => 'Smith', :first_name => 'Steve', :gender => 'M', :dob=>'03/03/1985', :favorite_color => 'red'})
  end

  def you
    Person.new({:last_name => 'Smith', :first_name => 'Betty', :gender => 'Female', :dob=>'03/03/1985', :favorite_color => 'tan'})
  end
end