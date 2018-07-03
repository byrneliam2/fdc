# Liam Byrne (byrneliam2)
# fdc

require 'set'

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
        g = Set[]
        @fds.each do |f|
            g << f && next if f.rhs.size == 1
            f.rhs.each do |fx|
                g << FuncDependency.new(f.lhs, Set[fx])
            end
        end
        return g
    end

    def left_reduce
        g = Set[]
        @fds.each do |f|
            g << f && next if f.lhs.size == 1
            f.lhs.each do |fx|
                d = FuncDependency.new(f.lhs - [fx], f.rhs)
                rests = (f.lhs - [fx]).to_a
                # p Closure.new(@schema, @fds | [d], Set[rests]).compute
                if f.rhs.subset?(Closure.new(@schema, @fds | [d], Set[rests]).compute[rests])
                    # g << d # TODO
                end
            end
        end
        return g
    end

    def no_redundant
        g = Set[]
        @fds.each do |f|
            x = @fds - [f]
            next if f.rhs.subset?(Closure.new(@schema, x, Set[f.lhs.to_a]).compute[f.lhs.to_a])
            g << f
        end
        return g
    end

end