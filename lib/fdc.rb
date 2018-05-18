# Liam Byrne (byrneliam2)
# fdc

require_relative "parser"

class FDCApp

    #CONSTANT = something

    def initialize(args)
        #@instance_var = something
        #@@class_var = somethingelse
        FDCParser.parse(args)
    end

end

if __FILE__ == $0
    FDCApp.new(ARGV)
end