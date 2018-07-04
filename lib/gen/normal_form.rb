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
    end

    def third_nf?
    end

    def bc_nf?
    end

end