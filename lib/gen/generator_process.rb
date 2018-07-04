# Liam Byrne (byrneliam2)
# fdc

require 'set'

class GeneratorProcess

  # ======================== REPRESENTATIONS =========================
  # SCHEMA is represented as an ordered ARRAY
  # FUNCTIONAL DEPENDENCIES are stored in SETS
  # - ATTRIBUTE SETS within functional dependencies are stored in SETS

  attr_accessor :printer

  def initialize(schema, fds, printer)
    # Accept properly formatted strings (which will be turned into an array)
    # or an array itself (assumed to be)
    @schema = schema.is_a?(String) ? format_schema(schema) : schema
    @fds = fds.is_a?(String) ? format_fds(fds) : fds
    @printer = printer
  end

  def format_schema(schema)
    schema[2...schema.length - 1].split(',')
  end

  def format_fds(fds)
    _fds = Set[]
    fds[1...fds.length - 1].split(';').each do |d|
      ds = d.split('/')
      _fds << FuncDependency.new(ds[0], ds[1])
    end
    return _fds
  end

end

class FuncDependency

  attr_accessor :lhs, :rhs

  def initialize(lhs, rhs)
    @lhs = lhs.is_a?(String) ? Set.new(lhs.split(',')) : lhs
    @rhs = rhs.is_a?(String) ? Set.new(rhs.split(',')) : rhs
  end

  def ==(obj) # force equality to be on set components
    obj.is_a?(FuncDependency) && @lhs == obj.lhs && @rhs == obj.rhs
  end

end