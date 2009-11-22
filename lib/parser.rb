class Parser
  attr_accessor :delimeter, :layout

  def initialize(delimeter, *args)
    @delimeter, @layout = delimeter, args.select{|element| element.is_a?(Symbol) }
  end

  def parse(io)
    io.each_line do |line|
      vals = line.strip.split delimeter
      pair = @layout.zip(vals)
      attributes =pair.inject({}) do |record, attr_pair|
        record.merge attr_pair.first => attr_pair.last
      end
      yield attributes
    end
  end
end