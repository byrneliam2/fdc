# Liam Byrne (byrneliam2)
# fdc

require 'set'

class GeneratorProcess

    def initialize(schema, fds)
        @schema = format_schema(schema)
        @fds = format_fds(fds)
    end

    def format_schema(schema)
        # Format the schema as an ordered list.
        # This is so when we work on it, results are produced in the input order.
        _schema = []
        atrbs = schema[2...schema.length - 1]
        atrbs.split(',').each do |a|
            _schema.push(a)
        end
        _schema
    end

    def format_fds(fds)
        _fds = []
        deps = fds[1...fds.length - 1]
        deps.split(';').each do |d|
            ds = d.split('/')
            _fds.push(FuncDependency.new(ds[0], ds[1]))
        end
        _fds
    end

end

class FuncDependency

    attr_accessor :lhs, :rhs

    def initialize(lhs, rhs)
        @lhs = setify lhs
        @rhs = setify rhs
    end

    def setify(str)
        s = Set[]
        str.split(',').each do |t|
            s.add(t)
        end
        return s
    end

end