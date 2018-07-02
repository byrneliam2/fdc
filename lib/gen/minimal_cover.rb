# Liam Byrne (byrneliam2)
# fdc

class MinimalCover < GeneratorProcess

    def initialize(schema, fds)
        super(schema, fds, MinimalCoverPrinter.new)
    end

    def compute
        @fds = right_reduce
        @fds = left_reduce
        @fds = no_redundant
    end

    def right_reduce
        g = Array.new(@fds)
        @fds.each do |f|
            if f.rhs.size > 1
                f.rhs.each do |fx|
                    g << FuncDependency.new(f.lhs, Set[fx])
                end
            end
        end
        g.reject { |x| @fds.include?(x) }
    end

    def left_reduce
        g = Array.new(@fds)
        g.each do |f|
            if f.lhs.size > 1
                f.lhs.each do |fx|
                    d = FuncDependency.new(f.lhs - [fx], f.rhs)
                    if Closure.new(@schema, Set[d]).compute.include?(f.rhs)
                        puts "ye boi"
                    end
                end
            end
        end
    end

    def no_redundant
    end

end