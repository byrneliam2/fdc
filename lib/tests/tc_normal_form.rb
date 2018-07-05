# Liam Byrne (byrneliam2)
# fdc

require "test/unit"

require_relative "../gen/normal_form"

class NormalFormTests < Test::Unit::TestCase

  def test01_Max1NF
    n = NormalForm.new("R(A,B,C,D)", "{A/B;C/D}")
    assert_true(n.compute == "1NF")
  end

  def test02_Max1NF
    n = NormalForm.new("R(A,B,C,D)", "{A,B/C,D;B/C}")
    assert_true(n.compute == "1NF")
  end

  def test03_Max2NF
    n = NormalForm.new("R(A,B,C,D)", "{A/B,C,D;B/D}")
    assert_true(n.compute == "2NF")
  end

  def test04_Max2NF
    n = NormalForm.new("R(StudentId,StudentName,Major,Grade,DegreeLength)",
      "{StudentId,Major/StudentName,Grade,DegreeLength;DegreeLength/Grade}")
    assert_true(n.compute == "2NF")
  end

  def test05_Max3NF
    n = NormalForm.new("R(StudentId,StudentName,Major,DegreeLength)",
      "{StudentId,StudentName,Major/DegreeLength;DegreeLength/Major}")
    assert_true(n.compute == "3NF")
  end

end