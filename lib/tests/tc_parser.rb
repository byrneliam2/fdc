# Liam Byrne (byrneliam2)
# fdc

require "test/unit"

require_relative "../io/parser"

class ParserTests < Test::Unit::TestCase

  def test01_parseGoodSchemas
    p = FDCParser.new
    assert_true(p.parse_schema("R(A)"))
  end

  def test02_parseGoodSchemas
    p = FDCParser.new
    assert_true(p.parse_schema("R(Student,Lecturer,LecId)"))
  end

  def test03_parseGoodSchemas
    p = FDCParser.new
    assert_true(p.parse_schema("R(A,B,CD)"))
  end

  def test04_parseGoodFDs
    p = FDCParser.new
    assert_true(p.parse_fds("{A/B}"))
  end

  def test05_parseGoodFDs
    p = FDCParser.new
    assert_true(p.parse_fds("{A/B;A/C;AB/A,D}"))
  end

  def test06_parseGoodRestrictions
    p = FDCParser.new
    assert_true(p.parse_rests("[A]"))
  end

  def test07_parseGoodRestrictions
    p = FDCParser.new
    assert_true(p.parse_rests("[A,B;A,C;A,D]"))
  end

  def test08_parseBadSchemas
    p = FDCParser.new
    assert_false(p.parse_schema("(A)"))
  end

  def test09_parseBadSchemas
    p = FDCParser.new
    assert_false(p.parse_schema("R(Lecturer1, Course2)"))
  end

  def test10_parseBadSchemas
    p = FDCParser.new
    assert_false(p.parse_schema("R(A,,B)"))
  end

  def test11_parseBadSchemas
    p = FDCParser.new
    assert_false(p.parse_schema("R(A/B)"))
  end

  def test12_parseBadFDs
    p = FDCParser.new
    assert_false(p.parse_fds("{AB}"))
  end

  def test13_parseBadFDs
    p = FDCParser.new
    assert_false(p.parse_fds("{A/B,C/D}"))
  end

  def test14_parseBadRestrictions
    p = FDCParser.new
    assert_false(p.parse_rests("(A)"))
  end

  def test15_parseBadRestrictions
    p = FDCParser.new
    assert_false(p.parse_rests("[A/B;A/C;AB/A,D]"))
  end

end