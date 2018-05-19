# Liam Byrne (byrneliam2)
# fdc

Dir[File.join(__dir__, '..', 'gen', '*.rb')].each { |file| require file }

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
        true
    end

    def assert_fds(fds)
        if fds[0] != '{' || fds[fds.length - 1] != '}'
            error("schema must follow direct form R(<attrs>)")
            return false
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