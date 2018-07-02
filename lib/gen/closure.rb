# Liam Byrne (byrneliam2)
# fdc

require 'set'

require_relative "generator_process"

class Closure < GeneratorProcess

    def initialize(schema, fds, rests)
        super(schema, fds, ClosurePrinter.new)
        @rests = rests.is_a?(String) ? format_rests(rests) : rests
    end

    def format_rests(rests)
        _rests = []
        rests[1...rests.length - 1].split(';').each do |r|
            # _rests << Set.new(r.to_a)
        end
        return _rests
    end

    def compute
        out = {}
        for i in 1..@schema.length do
            @schema.to_a.combination(i).each do |comb|
                out.store(comb, compute_closure(SortedSet.new(comb)))
            end
        end
        return @rests == [] ? out : out.select { |x| }
    end

    def compute_closure(x)
        i = 0
        loop do
            @fds.each do |f|
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