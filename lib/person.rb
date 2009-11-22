class Person < Struct.new(:last_name, :first_name, :gender, :dob, :favorite_color)

  def initialize(hash)
    self.members.each do |attr_name|
      self.send("#{attr_name}=", hash[attr_name.to_sym])
    end
  end
  
  def to_s
    [self.last_name, self.first_name, self.gender, self.dob_s, self.favorite_color].join(" ")
  end

  def compare(other, sort = [:gender, :last_name])
    significant_attr = sort.detect{|attr| self.send(attr) != other.send(attr)}
    significant_attr ||= sort.first
    self.send(significant_attr) <=> other.send(significant_attr)
  end

  def gender= value
    @gender = case value
    when "M"
      "Male"
    when "F"
      "Female"
    else
      value
    end
  end

  def gender
    @gender
  end

  def dob= value
    @dob = Date.parse value
  end

  def dob
    @dob
  end

  def dob_s
    self.dob.strftime '%m/%d/%Y'
  end
end