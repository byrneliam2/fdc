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
        return out
    end

    def compute_closure(atrb)
        g = @fds
        x = Set[atrb]
        g.each do |f|
            if f.lhs.subset?(x)
                puts "#{atrb} = Woohoo!"
                x.add(f)
            end 
        end
    end

end