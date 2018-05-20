# Liam Byrne (byrneliam2)
# fdc

class GeneratorProcess

    def initialize(schema, fds)
        @schema = format_schema(schema)
        @fds = format_fds(fds)
    end

    def format_schema(schema)
        _schema = []
        atrbs = schema[2...schema.length - 1]
        atrbs.split(',').each do |a|
            _schema.push(a)
        end
        _schema
    end

    def format_fds(fds)
        _fds = {}
        deps = fds[1...fds.length - 1]
        deps.split('/').each do |d|
            # TODO
        end
        _fds
    end

end