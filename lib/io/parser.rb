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
        when "-h", "--help"
            puts help
        else
            puts help
        end
    end

    def parse_closure(cmps)
        atrb = cmps.length == 3 ? ast_atrbs : true
        if not assert_schema(cmps[0]) && assert_fds(cmps[1]) && atrb
            return 'stop'
        end

        ast_atrbs {
        }
    end   

    def assert_schema(schema)
        tokens = schema.split('')
        if tokens[0] != 'R'
            return false
        end
        if tokens[1] != '(' || tokens[tokens.length - 1] != ')'
            return false
        end
    end

    def help
        <<~HEREDOC

        Usage:
            fdc -c/--closure <schema> <fds> [<attrs>]
            fdc -h/--help
        Definitions:
            <schema> = Relation schema in form R(A, B, CD)
            <fds> = Functional dependency set in form {A -> B; A -> CD; A,B -> CD}
            <attrs> = Attributes as specified in schema

        HEREDOC
    end

end