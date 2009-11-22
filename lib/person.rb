class Person < Struct.new(:last_name, :first_name, :gender, :dob, :favorite_color)

  def initialize(hash)
    self.members.each do |attr_name|
      self.send("#{attr_name}=", hash[attr_name.to_sym])
    end
  end
  
  def to_s
    [self.last_name, self.first_name, self.gender, self.dob.strftime('%m/%d/%Y'), self.favorite_color].join(" ")
  end

  def compare(other, sort = [:gender, :last_name])
    significant_attr = sort.detect{|attr| self.send(attr) != other.send(attr)}
    significant_attr ? self.send(significant_attr) <=> other.send(significant_attr) : 0
  end

  def gender= value
    self[:gender] = case(value)
    when "M"
      "Male"
    when "F"
      "Female"
    else
      value
    end
  end

  def dob=(value)
    self[:dob] = Date.parse(value)
  end
end