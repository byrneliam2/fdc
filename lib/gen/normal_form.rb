# Liam Byrne (byrneliam2)
# fdc

class NormalForm < GeneratorProcess

    def initialize(schema, fds)
        super(schema, fds, NormalFormPrinter.new)
    end

    def compute
        x = "1NF" if first_nf?
        x = "2NF" if x == "1NF" && second_nf?
        x = "3NF" if x == "2NF" && third_nf?
        x = "BCNF" if x == "3NF" && bc_nf?
        return x
    end

    def first_nf?
        # This calculator doesn't really have support for schemas that aren't
        # fully atomic, hence the check we run here is simply string type checking
        @schema.all? { |x| x.is_a?(String) }
    end

    def second_nf?
        keys = Closure.new(@schema, @fds, []).compute_minimal_keys
        return true if keys.all? { |k| k.length == 1 }
        @fds.each do |f|
            if !(prime?(f.rhs, keys)) && 
                keys.any? { |k| f.lhs.subset?(Set.new(k)) && f.lhs.length != k.length }
                return false
            end
        end
        return true
    end

    def third_nf?
        keys = Closure.new(@schema, @fds, []).compute_minimal_keys
        @fds.each do |f|
            next if trivial?(f)
            if !(keys.any? { |k| f.lhs.subset?(Set.new(k)) } || prime?(f.rhs, keys))
                return false
            end
        end
        return true
    end

    def bc_nf?
        keys = Closure.new(@schema, @fds, []).compute_minimal_keys
        @fds.each do |f|
            next if trivial?(f)
            if !(keys.any? { |k| f.lhs.subset?(Set.new(k)) })
                return false
            end
        end
        return true
    end

    def prime?(atrb, keys)
        keys.any? { |k| Set.new(k).subset?(atrb) }
    end

    def trivial?(f)
        f.rhs.subset?(f.lhs)
    end

end