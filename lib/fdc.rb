# Liam Byrne (byrneliam2)
# fdc

require_relative "io/parser"

class FDC

    #CONSTANT = something

    def initialize(args)
        @parser = FDCParser.new
        #@@class_var = somethingelse

        opt = @parser.parse(args)
        if opt != 'stop'
            select(opt)
        end
    end

end

if __FILE__ == $0
    FDC.new(ARGV)
end