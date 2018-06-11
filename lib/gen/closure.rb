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
        i = 0

        loop do
            g.each do |f| # TODO extend loop (count number of successes in loop)
                if f.lhs.subset?(x) && 
                    x = x | f.rhs
                    # i += 1
                end 
            end
            # break if i == 0
            # i = 0
        end
        return x
    end

end