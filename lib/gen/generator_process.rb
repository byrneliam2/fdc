# Liam Byrne (byrneliam2)
# fdc

class GeneratorProcess

    def initialize(schema, fds)
        @schema = format_schema(schema)
        @fds = format_fds(fds)

    def compute
        raise NotImplementedError
    end

    def format_schema
    end

    def format_fds
    end

end