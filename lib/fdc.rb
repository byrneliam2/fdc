# Liam Byrne (byrneliam2)
# fdc

BEGIN {
    puts("Initializing FDC...")
}

#$global_var = something

class FDCApp

    #CONSTANT = something

    def initialize(args)
        #@instance_var = something
        #@@class_var = somethingelse
        puts(args)
    end

end

END {
    puts("Closing FDC...")
}

if __FILE__ == $0
    FDCApp.new(ARGV)
end

=begin

RUBY NOTES
- Use &&/|| over and/or

=end