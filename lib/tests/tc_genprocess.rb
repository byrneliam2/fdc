# Liam Byrne (byrneliam2)
# fdc

require "test/unit"

require_relative "../gen/generator_process"
require_relative "../gen/closure"

class GeneratorProcessTests < Test::Unit::TestCase

  def test01_SchemaFormatting
    g = GeneratorProcess.new(nil, nil, nil)
    assert_true(g.format_schema("R(A,B,C,D)") == ["A", "B", "C", "D"])
  end

  def test02_SchemaFormatting
    g = GeneratorProcess.new(nil, nil, nil)
    assert_true(g.format_schema(
      "R(StudentId,StudentName,Grade)") == ["StudentId", "StudentName", "Grade"])
  end

  def test03_FDFormatting
    g = GeneratorProcess.new(nil, nil, nil)
    x = [FuncDependency.new("A", "B"), FuncDependency.new("C", "D")]
    y = g.format_fds("{A/B;C/D}").to_a 
    for i in 0..x.length # use for loop to compare dependencies directly
      assert_true(x[i] == y[i])
    end
  end

  def test11_FuncDependencies
    f = FuncDependency.new("A", "B")
    assert_true(f.lhs == Set["A"])
    assert_true(f.rhs == Set["B"])
  end

  def test12_FuncDependencies
    f = FuncDependency.new("A,B", "C,D")
    assert_true(f.lhs == Set["A", "B"])
    assert_true(f.rhs == Set["C", "D"])
  end

  def test13_FuncDependencies
    f1 = FuncDependency.new("A,B", "C,D")
    f2 = FuncDependency.new("A,B", "C,D")
    assert_true(f1 == f2)
  end

  def test14_FuncDependencies
    f1 = FuncDependency.new("A,B", "C,D")
    f2 = FuncDependency.new("AB", "C,D")
    assert_false(f1 == f2)
  end

end