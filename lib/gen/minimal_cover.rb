# Liam Byrne (byrneliam2)
# fdc

class MinimalCover < GeneratorProcess

    def initialize(schema, fds)
        super
    end

    def compute
        g = Set.new(@fds)
        right_reduce!(g)
    end

    def right_reduce!(g)
        g.each do |f|
            if f.rhs.size > 1
                f.rhs.each do |ff|
                    g.add(FuncDependency.new(:lhs => f.lhs, :rhs => Set.new(ff)))
                end
                g.delete(f)
            end
        end
        p g
    end

    def left_reduce!(g)
        g.each do |f|
            if f.lhs.size > 1
            end
        end
    end

    def no_redundant!(g)
    end

end