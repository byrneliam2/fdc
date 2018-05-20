# Liam Byrne (byrneliam2)
# fdc

require "test/unit"

require_relative "../io/parser"

class FDCTests < Test::Unit::TestCase

    def test01_parseSchemas
        p = FDCParser.new
        assert_true(p.parse_schema("R(A)"))
    end

    def test02_parseSchemas
        p = FDCParser.new
        assert_true(p.parse_schema("R(Student, Lecturer, LecId)"))
    end

    def test03_parseSchemas
        p = FDCParser.new
        assert_true(p.parse_schema("R(A, B,CD)"))
    end

    def test05_parseFDs
        p = FDCParser.new
        assert_true(p.parse_fds("{A -> B; A -> C; AB-> A,D}"))
    end

    ###

    def test10_parseSchemas
        p = FDCParser.new
        assert_false(p.parse_schema("(A)"))
    end

    def test11_parseSchemas
        p = FDCParser.new
        assert_false(p.parse_schema("R(A B C D)"))
    end

    def test12_parseSchemas
        p = FDCParser.new
        assert_false(p.parse_schema("R(Lecturer1, Course2)"))
    end

    def test13_parseSchemas
        p = FDCParser.new
        assert_false(p.parse_schema("R(A,,B)"))
    end

    def test14_parseSchemas
        p = FDCParser.new
        assert_false(p.parse_schema("R(A->B)"))
    end

    def test15_parseFDs
        p = FDCParser.new
        assert_false(p.parse_fds("{AB}"))
    end

    def test16_parseFDs
        p = FDCParser.new
        assert_false(p.parse_fds("{A->B,C->D}"))
    end

    def test17_parseFDs
        p = FDCParser.new
        assert_false(p.parse_fds("{A B -> C; C -> D}"))
    end

end

