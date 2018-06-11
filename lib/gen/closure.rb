# Liam Byrne (byrneliam2)
# fdc

require_relative "generator_process"

class Closure < GeneratorProcess

    def initialize(schema, fds)
        super
    end

    def compute
        out = []
        for i in 1..@schema.length do
            @schema.to_a.combination(i).each do |atrb|
                atrb = atrb.join
                out.push compute_closure(atrb)
            end
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
            break if i == 0
            # i = 0
        end
        return x
    end

end