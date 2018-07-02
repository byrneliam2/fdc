# Liam Byrne (byrneliam2)
# fdc

require 'set'

class GeneratorProcess

    attr_accessor :printer

    def initialize(schema, fds, printer)
        @schema = format_schema(schema)
        @fds = format_fds(fds)
        @printer = printer
    end

    def format_schema(schema)
        # Format the schema as an ordered list.
        # This is so when we work on it, results are produced in the input order.
        _schema = []
        atrbs = schema[2...schema.length - 1]
        atrbs.split(',').each do |a|
            _schema << a
        end
        return _schema
    end

    def format_fds(fds)
        _fds = []
        deps = fds[1...fds.length - 1]
        deps.split(';').each do |d|
            ds = d.split('/')
            _fds << FuncDependency.newFromString(ds[0], ds[1])
        end
        return _fds
    end

end

class FuncDependency

    attr_accessor :lhs, :rhs

    def initialize(lhs, rhs)
        @lhs = lhs
        @rhs = rhs
    end

    def self.newFromString(lhs, rhs)
        _lhs = setify lhs
        _rhs = setify rhs
        return FuncDependency.new(_lhs, _rhs)
    end

    # Turn a comma-separated string into a set
    def self.setify(str)
        s = Set[]
        str.split(',').each do |t|
            s << t
        end
        return s
    end

    def ==(obj)
        return obj.is_a?(FuncDependency) && @lhs == obj.lhs && @rhs == obj.rhs
    end

end