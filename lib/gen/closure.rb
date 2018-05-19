# Liam Byrne (byrneliam2)
# fdc

class Closure < GeneratorProcess

    def compute(atrbs)
    end

    def compute_closure(atrb)
        g = @fds
        x = [atrb]
        g.each do |f|
            if f.lhs.subset?(x)
                
        end
    end

end