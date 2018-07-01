# Liam Byrne (byrneliam2)
# fdc

class NormalForm < GeneratorProcess

    def initialize(schema, fds)
        super(schema, fds, NormalFormPrinter.new)
    end

    def compute
    end

    def first_nf?
    end

    def second_nf?
    end

    def third_nf?
    end

    def bc_nf?
    end

end