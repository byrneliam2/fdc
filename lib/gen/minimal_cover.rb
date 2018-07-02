# Liam Byrne (byrneliam2)
# fdc

class MinimalCover < GeneratorProcess

    def initialize(schema, fds)
        super(schema, fds, MinimalCoverPrinter.new)
    end

    def compute
        p right_reduce
    end

    def right_reduce
        g = Set.new(@fds)
        @fds.each do |f|
            if f.rhs.size > 1
                f.rhs.each do |ff|
                    g << FuncDependency.new(f.lhs, Set.new([ff]))
                end
            end
        end
        g.reject { |x| @fds.include?(x) }
    end

    def left_reduce
        g.each do |f|
            if f.lhs.size > 1
            end
        end
    end

    def no_redundant
    end

end