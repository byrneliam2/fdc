# Liam Byrne (byrneliam2)
# fdc

require_relative "../gen/closure"
require_relative "../gen/minimal_cover"
require_relative "../gen/normal_form"

class FDCParser

    # PARSER FORMATS
    # Closures: -c R(attrs in form A,B,CD) {FDs in form A,B->C,D;...} [optional restriction]
    # Minimal cover: -m R(attrs) {FDs}
    # Normal forms: -n R(attrs) {FDs}

    def parse(args)
        case args[0]
        when "-c", "--closure"
            return parse_closure(args[1..args.length])
        when "-m", "--mincover"
            return parse_mincover(args[1..args.length])
        when "-n", "--normalform"
            return parse_normalform(args[1..args.length])
        when "-h", "--help"
            puts help
            return 'stop'
        else
            puts help
            return 'stop'
        end
    end

    def parse_closure(cmps)
        if cmps.length == 0
            error("schema and dependency set missing")
            return 'stop'
        end
        if cmps.length == 1
            error("dependency set missing")
            return 'stop'
        end
        if not assert_schema(cmps[0]) && assert_fds(cmps[1])
            return Closure.new(cmps[0], cmps[1])
        end
    end   

    def assert_schema(schema)
        if schema[0] != 'R' or schema[1] != '(' || schema[schema.length - 1] != ')'
            error("schema must follow direct form R(<attrs>)")
            return false
        end
        schema[2...schema.length - 1].split(',').each do |s|
            s.strip!
            if not s.match?("[A-Za-z]+")
                error("incorrectly formed attributes: see help (-h)")
                return false
            end
            true
        end
        true
    end

    def assert_fds(fds)
        if fds[0] != '{' || fds[fds.length - 1] != '}'
            error("schema must follow direct form R(<attrs>)")
            return false
        end
        fds[1...fds.length - 1].split(';').each do |f|
            f = f.delete(' ')
            if not f.match?("[A-Za-z]+->[A-Za-z]+")
                error("incorrectly formed functional dependencies: see help (-h)")
                return false
            end
            f.split(',').each do |fx|
                if not fx.match?("[A-Za-z]+")
                    error("incorrectly formed functional dependencies: see help (-h)")
                    return false
                end
            end
        end
        true
    end

    def error(msg)
        puts "ERROR: #{msg}"
    end

    def help
        <<~HEREDOC

        Usage:
            fdc -c/--closure <schema> <fds> [<attrs>]
            fdc -m/--mincover <schema> <fds>
            fdc -n/--normalform <schema> <fds>
            fdc -h/--help
        Definitions:
            <schema> = Relation schema in form R(A, B, CD)
            <fds> = Functional dependency set in form {A -> B; A -> CD; A,B -> CD}
            <attrs> = Attributes as specified in schema

        HEREDOC
    end

end