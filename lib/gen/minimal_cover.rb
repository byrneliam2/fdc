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
        g = []
        @fds.each do |f|
            g << f && next if f.rhs.size == 1
            f.rhs.each do |fx|
                g << FuncDependency.new(f.lhs, Set[fx])
            end
        end
    end

    def left_reduce
        g = []
        @fds.each do |f|
            g << f && next if f.lhs.size == 1
            f.lhs.each do |fx|
                lhsx = f.lhs - [fx]
                d = FuncDependency.new(lhsx, f.rhs)
                p Closure.new(@schema, @fds + [d], lhsx).compute
                if Closure.new(@schema, @fds + [d], lhsx).compute.include?(f.rhs)
                    puts "Woohoo!"
                end
            end
        end
    end

    def no_redundant
    end

end