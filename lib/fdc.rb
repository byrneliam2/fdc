# Liam Byrne (byrneliam2)
# fdc

require_relative "io/parser"

class FDC

    def initialize(args)
        @parser = FDCParser.new
        run(args)
    end

    def run(args)
        opt = @parser.parse(args)
        if opt != 'stop'
            select(opt)
        end
    end

    def select(opt)
    end

end

if __FILE__ == $0
    FDC.new(ARGV)
end