# fdc -c R(A,B,C,D) {A/B;C/D}
# fdc -c R(A,B,C,D,E) {A,B/C;C,D/E;D,E/B}

# Liam Byrne (byrneliam2)
# fdc

require "test/unit"

require_relative "../gen/closure"
require_relative "../io/printer"

class ClosureTests < Test::Unit::TestCase

  def test01_ClosureRestrictionFormatting
    c = Closure.new(nil, nil, nil)
    assert_true(c.format_rests("[A]") == Set[["A"]])
  end

  def test02_ClosureRestrictionFormatting
    c = Closure.new(nil, nil, nil)
    assert_true(c.format_rests("[A,B;C,D]") == Set[["A", "B"], ["C", "D"]])
  end

  def test03_ClosureComputation
    c = Closure.new("R(A,B,C}", "{A,B/C}", [])
    x = {["A"] => Set["A"], ["B"] => Set["B"], ["C"] => Set["C"], 
      ["A", "B"] => Set["A", "B", "C"], ["A", "C"] => Set["A", "C"], ["B", "C"] => Set["B", "C"], 
      ["A", "B", "C"] => Set["A", "B", "C"]}
    y = c.compute
    assert_true(x.size == y.size) # ensure all cases covered
    (x.keys & y.keys).each { |k| assert_true(x[k] == y[k]) }
  end

  def test04_ClosureComputation
    c = Closure.new("R(A,B,C,D}", "{A/B,C;B/D}", [])
    x = {["A"] => Set["A", "B", "C", "D"], ["B"] => Set["B", "D"], ["C"] => Set["C"], ["D"] => Set["D"],
      ["A", "B"] => Set["A", "B", "C", "D"], ["A", "C"] => Set["A", "B", "C", "D"], 
      ["A", "D"] => Set["A", "B", "C", "D"], ["B", "C"] => Set["B", "C", "D"], ["B", "D"] => Set["B", "D"], 
      ["C", "D"] => Set["C", "D"],  ["A", "B", "C"] => Set["A", "B", "C", "D"], ["B", "C", "D"] => Set["B", "C", "D"],
      ["A", "B", "D"] => Set["A", "B", "C", "D"], ["A", "C", "D"] => Set["A", "B", "C", "D"], 
      ["A", "B", "C", "D"] => Set["A", "B", "C", "D"]}
    y = c.compute
    assert_true(x.size == y.size) # ensure all cases covered
    (x.keys & y.keys).each { |k| assert_true(x[k] == y[k]) }
  end

  def test05_ClosuresWithRestrictions
    c = Closure.new("R(A,B,C}", "{A,B/C}", "[A;B;C]")
    x = {["A"] => Set["A"], ["B"] => Set["B"], ["C"] => Set["C"]}
    y = c.compute
    assert_true(x.size == y.size) # ensure all cases covered
    (x.keys & y.keys).each { |k| assert_true(x[k] == y[k]) }
  end

  def test06_ClosuresWithRestrictions
    c = Closure.new("R(ItemID,ItemName,Count}", "{ItemID/ItemName}", "[ItemName]")
    x = {["ItemName"] => Set["ItemName"]}
    y = c.compute
    assert_true(x.size == y.size) # ensure all cases covered
    (x.keys & y.keys).each { |k| assert_true(x[k] == y[k]) }
  end

  def test07_MinimalKeys
    c = Closure.new("R(A,B,C,D,E}", "{A,B/D,E;B,C/D,E}", [])
    assert_true(Set[["A", "B", "C"]] == c.compute_minimal_keys)
  end

  def test08_MinimalKeys
    c = Closure.new("R(A,B,C,D}", "{A/B;C/D}", [])
    assert_true(Set[["A", "C"]] == c.compute_minimal_keys)
  end

  def test09_MinimalKeys
    c = Closure.new("R(A,B,C,D}", "{A/B,C,D;C/A,B,D}", [])
    assert_true(Set[["A"], ["C"]] == c.compute_minimal_keys)
  end

end