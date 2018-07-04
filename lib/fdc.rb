# Liam Byrne (byrneliam2)
# fdc

require_relative "io/parser"
require_relative "io/printer"

class FDC

  def initialize(args)
    @parser = FDCParser.new
    run(args)
  end

  def run(args)
    opt = @parser.parse(args)
    opt&.printer&.print(opt&.compute)
  end

end

if __FILE__ == $0
  FDC.new(ARGV)
end