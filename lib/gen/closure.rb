# Liam Byrne (byrneliam2)
# fdc

require_relative "generator_process"

class Closure < GeneratorProcess

    def initialize(schema, fds)
        super
    end

    def compute
        out = []
        @schema.each do |atrb|
            out.push compute_closure(atrb)
        end
        # p out
        return out
    end

    def compute_closure(atrb)
        g = @fds
        x = Set[atrb]
        g.each do |f| # TODO extend loop
            if f.lhs.subset?(x)
                x = x | f.rhs
            end 
        end
        return x
    end

end