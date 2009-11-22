class Person < Struct.new(:last_name, :first_name, :gender, :dob, :favorite_color)

  def initialize(hash)
    raise ArgumentError, "#{self.class.name} requires that a hash be provided" unless hash.is_a? Hash
    self.members.each do |attr_name|
      self.send("#{attr_name}=", hash[attr_name.to_sym]) if hash.has_key?(attr_name.to_sym)
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
    self[:gender] =
      case(value)
        when "M" then "Male"
        when "F" then "Female"
        else value
      end
  end

  def dob=(value)
    self[:dob] = 
      case value
        when Date then value
        when String then value.gsub!('-', '/'); self[:dob] = Date.parse(value)
        else Date.parse(value)
      end
  end
end