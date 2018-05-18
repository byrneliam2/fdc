# Liam Byrne (byrneliam2)
# fdc

class FDCParser

    # PARSER FORMATS
    # Closures: -c R(attrs in form A,B,CD) {FDs in form A,B->C,D;...} [optional restriction]
    # Minimal cover: -m R(attrs) {FDs}
    # Normal forms: -n R(attrs) {FDs}

    def self.parse(args=["-h"])
        banner = "Usage: fdc [options]"
        case args[0]
        when "-c", "--closure"
            puts "Closure!"
        end
    end

end