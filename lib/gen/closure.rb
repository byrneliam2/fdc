# Liam Byrne (byrneliam2)
# fdc

require 'set'

require_relative "generator_process"

class Closure < GeneratorProcess

  # ======================== REPRESENTATIONS =========================
  # RESTRICTIONS are represented as a SET of ARRAYS (to compare with
  # combination lists as stored in closure hash)
  # OUTPUT CLOSURE COMPUTATION is represented as a HASH of COMBINATION
  # LISTS to ATTRIBUTE SETS

  def initialize(schema, fds, rests)
    super(schema, fds, p = ClosurePrinter.new)
    p.schema = @schema # set schema after superclass processing
    @rests = rests.is_a?(String) ? format_rests(rests) : rests
  end

  def format_rests(rests)
    _rests = Set[]
    rests[1...rests.length - 1].split(';').each do |r|
      _rests << r.split(',')
    end
    return _rests
  end

  def compute
    out = {}
    for i in 1..@schema.length do
      @schema.to_a.combination(i).each do |comb|
        out.store(comb, compute_closure(Set.new(comb)))
      end
    end
    # filter generations if needed
    return @rests.empty? ? out : out.select { |k, _| @rests.include?(k) }
  end

  def compute_closure(x)
    i = 0
    loop do
      @fds.each do |f|
        if f.lhs.subset?(x) # && 
          x = x | f.rhs
          # i += 1
        end 
      end
      break if i == 0
      # i = 0
    end
    return x
  end

  def compute_minimal_keys
    schema_set = Set.new(@schema)
    min = Set[]
    _super = compute.select { |_, v| schema_set.subset?(v) }
    _super.keys.each do |k| # convert to sets for subset functionality
      min << k if (_super.keys - [k]).none? { |x| Set.new(x).subset?(Set.new(k)) }
    end
    return min
  end

end