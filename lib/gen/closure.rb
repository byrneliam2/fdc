# Liam Byrne (byrneliam2)
# fdc

require_relative "generator_process"

class Closure < GeneratorProcess

    def compute
    end

    def compute_closure(atrb)
        g = @fds
        x = Set[atrb]
        g.each do |f|
            if f.lhs.subset?(x)
            end
                
        end
    end

end