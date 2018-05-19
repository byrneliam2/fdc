# Liam Byrne (byrneliam2)
# fdc

class FDCParser

    # PARSER FORMATS
    # Closures: -c R(attrs in form A,B,CD) {FDs in form A,B->C,D;...} [optional restriction]
    # Minimal cover: -m R(attrs) {FDs}
    # Normal forms: -n R(attrs) {FDs}

    def parse(args)
        case args[0]
        when "-c", "--closure"
            return parse_closure(args.slice!(0))
        when "-m", "--mincover"
        when "-n", "--normalform"
        when "-h", "--help"
            puts help
            'stop'
        else
            puts help
            'stop'
        end
    end

    def parse_closure(cmps)
        if cmps.length == 1
            error("closure", "schema and dependency set missing")
            'stop'
        end
        if cmps.length == 2
            error("closure", "dependency set missing")
            'stop'
        end
        atrb = cmps.length == 3
        if not assert_schema(cmps[0]) && assert_fds(cmps[1])
            return Closure.new(cmps[0], cmps[1])
        end
    end   

    def assert_schema(schema)
        tokens = schema.split('')
        if tokens[0] != 'R'
            false
        end
        if tokens[1] != '(' || tokens[tokens.length - 1] != ')'
            false
        end
        true
    end

    def assert_fds(fds)
    end

    def error(gen, msg)
        puts "ERROR: cannot compute #{gen}, #{msg}"
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