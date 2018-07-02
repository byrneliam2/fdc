# Liam Byrne (byrneliam2)
# fdc

require_relative "../gen/closure"
require_relative "../gen/minimal_cover"
require_relative "../gen/normal_form"

class FDCParser

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
            return nil
        else
            puts help
            return nil
        end
    end

    def parse_closure(cmps)
        if cmps.length == 0
            error("schema and dependency set missing")
            return nil
        end
        if cmps.length == 1
            error("dependency set missing")
            return nil
        end
        if parse_schema(cmps[0]) && parse_fds(cmps[1])
            return cmps[2] == nil ? 
                Closure.new(cmps[0], cmps[1], []) : # no restrictions, pass empty array
                (Closure.new(cmps[0], cmps[1], cmps[2]) if parse_rests(cmps[2]))
        end
        return nil
    end 
    
    def parse_mincover(cmps)
        if cmps.length == 0
            error("schema and dependency set missing")
            return nil
        end
        if cmps.length == 1
            error("dependency set missing")
            return nil
        end
        if parse_schema(cmps[0]) && parse_fds(cmps[1])
            return MinimalCover.new(cmps[0], cmps[1])
        end
        return nil
    end

    def parse_normalform(cmps)
    end

    def parse_schema(schema)
        if schema[0] != 'R' or schema[1] != '(' || schema[schema.length - 1] != ')'
            error("incorrectly formed schema: see help (-h)")
            return false
        end
        schema[2...schema.length - 1].split(',').each do |s|
            return false if not assert_atrbs(s)
        end
        return true
    end

    def parse_fds(fds)
        if fds[0] != '{' || fds[fds.length - 1] != '}'
            error("incorrectly formed dependency set: see help (-h)")
            return false
        end
        fds[1...fds.length - 1].split(';').each do |f|
            if not f.match?("^[A-z,]+/[A-z,]+$")
                error("incorrectly formed functional dependencies: see help (-h)")
                return false
            end
            f.split('/').each do |fx|
                fx.split(',').each do |fxx|
                    return false if not assert_atrbs(fxx)
                end
            end
        end
        return true
    end

    def parse_rests(rests)
        if rests[0] != '[' || rests[rests.length - 1] != ']'
            error("incorrectly formed restriction set: see help (-h)")
            return false
        end
        rests[1...rests.length - 1].split(';').each do |r|
            if not r.match?("^[A-z,]+$")
                error("incorrectly formed restrictions: see help (-h)")
                return false
            end
            r.split(',').each do |rx|
                return false if not assert_atrbs(rx)
            end
        end
    end

    def assert_atrbs(atrb)
        if not atrb.match?("^[A-z]+$")
            error("incorrectly formed attributes: see help (-h)")
            return false
        end
        return true
    end

    def error(msg)
        puts "ERROR: #{msg}"
    end

    def help
        <<~HEREDOC

        Usage:
            fdc -c/--closure <schema> <fds> [<rests>]
            fdc -m/--mincover <schema> <fds>
            fdc -n/--normalform <schema> <fds>
            fdc -h/--help
        Definitions:
            <schema> = Relation schema in form R(A,B,CD)
            <fds> = Functional dependency set in form {A/B;A/CD;A,B/CD}
            <rests> = Optional attribute restrictions as specified in schema in form [A;A,B;CD]

        HEREDOC
    end

end