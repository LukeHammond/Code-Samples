class Populator
  attr_reader :records

  def initialize
    @records = [ ]
  end

  def reset
    @records.clear
  end

  def populate(parser, io)
    parser.parse(io) do |attributes|
      @records.push Person.new(attributes)
    end
  end

  def sort_by(*args)
    sort_keys = args.select{|element| element.is_a?(Symbol) }
    @records = @records.sort{|a, b| a.compare(b, sort_keys) }
  end
end