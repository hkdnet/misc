require_relative './main.rb'

class Tester
  def initialize
    @no = 1
  end

  def test(input, expected)
    s = Solver.new(input)
    actual = s.solve
    puts "  #{@no} #{expected == actual}"
    unless expected == actual
      puts expected
      puts actual
      raise "failed"
    end
    @no += 1
  end

  def test_all
    test("FcFcFaF", "3,0")
    test("FccFaaFcFcF", "-")
    test("ccFaF", "-")
    test("cFcFaaF", "-")
    test("aFccFcFcF", "4,1")
    test("cFaFaFaFaaF", "4,0")
    test("cFccFaFaaFaF", "5,1")
    test("cFaaFaaFcFcFccF", "5,2")
    test("aaFaFaaFaFccFaFccF", "6,0")
    test("aaFaaFcFccFcFccFccFaF", "6,1")
    test("aFccFccFaaFccFcFcFcFaF", "7,4")
    test("ccFaaFaaFaFccFaaFaFcFccFaaF", "-")
    test("aaFaFaFcFaFaaFaFaFaaFccFaaFaaF", "8,3")
    test("aaFccFaFaFccFaaFaaFaaFccFccFcFaFaF", "13,10")
    test("aFaFaaFaaFaaFccFaFccFaFaaFccFccFaaFccF", "11,0")
    test("ccFccFcFaaFaaFaFccFaaFaFcFaaFaaFcFcFcF", "10,2")
    test("aaFaaFaaFccFccFaFaaFaaFaFccFcFcFccFaaFaFccFccF", "10,3")
    test("ccFaFccFaaFaaFcFccFaFcFccFccFaaFccFaFaaFaFaFccF", "11,3")
    test("cFcFaFaaFaFccFaaFcFaFaaFccFaFaaFccFaFcFaaFccFcF", "12,0")
    test("cFaFaaFcFaaFaaFaFccFaaFcFaaFccFaaFccFaFcFccFaFaFaFcFcF", "19,16")
    test("aFaFccFaaFccFccFaFccFaFaaFccFaaFccFcFccFaFaFccFaaFccFcF", "15,11")
    test("aFccFccFccFaaFaaFcFcFaaFccFaFcFccFaaFaFcFaaFcFaFccFccFaFaF", "23,20")
    test("cFaFaaFcFaFaaFccFccFaaFaFccFccFccFaFaFccFccFccFaaFcFcFcFaF", "22,18")
    test("aFcFaFccFccFaFccFaaFaFaaFaaFaFcFaFcFcFcFaFaFaaFaaFaFaaFcFccFaF", "14,4")
    test("cFaFaaFcFaFccFcFccFaFaaFaaFaFcFccFccFaFcFaFaaFccFaFaFccFcFaFaFaaF", "22,19")
    test("aaFaaFaFcFccFaaFcFaaFccFaFaFcFaFaaFaFaFaFcFccFaFaaFcFcFccFccFccFcF", "16,11")
    test("cFaaFaFcFaFaaFccFaaFaFccFccFaaFccFcFaFaaFaaFaFccFcFccFccFaFaaFcFcFaF", "26,23")
    test("cFaaFccFaFcFaFcFaaFccFaFccFaaFcFaFaaFccFaaFccFcFaFaaFaFcFccFccFaFcFaaFccFcF", "-")
    test("ccFccFaaFaFccFaaFaaFcFccFaaFaFcFccFccFccFaFaaFcFaFccFaaFcFcFaFccFaFccFaaFaaFaF", "-")
    test("aaFccFaFccFccFaaFccFaFcFccFaFccFcFcFaFcFcFaaFaaFcFccFccFcFaFaaFaFcFcFaaFaaFaaF", "19,5")
    test("aFaaFccFaFaaFaaFccFccFaFcFaaFaaFaaFccFaFccFaaFaaFaFccFccFcFaaFaFccFccFaFcFaaFccF", "-")
    test("aaFaFaaFcFccFccFaFcFaaFaaFaFccFccFccFaFaaFccFcFaaFccFaaFccFaaFccFccFccFcFaaFcFaaFccF", "30,23")
    test("aaFccFaFaaFccFcFaFccFaFcFccFaaFccFaFcFaaFccFaaFaFccFccFccFcFccFaFccFcFaaFaFcFccFcFaFaaF", "32,17")
    test("ccFcFcFaFaaFaFaaFccFcFccFaFcFaFccFaaFcFccFcFaaFcFaaFcFaaFaaFcFaaFaFaFaFaaFccFaaFcFcFaFaF", "18,14")
    test("ccFaFaaFaaFcFaaFaaFaaFaaFaaFaFccFcFaaFaFcFccFaaFcFaFaaFccFccFaaFcFaaFaaFaaFccFaaFcFcFaFaFccFaFcFccF", "17,0")
    test("aaFccFccFaFcFaFcFaFccFccFccFaFccFccFcFaFcFaaFccFcFccFccFaaFcFccFaaFccFccFaFccFcFcFaaFaFccFcFaaFaaFcF", "24,11")
    test("aaFccFaFccFaaFaaFcFaFcFaFcFaaFaaFccFaFcFaFaaFcFaaFaFcFaaFccFcFaaFccFaaFccFaaFccFcFaFcFaFccFaaFaaFccFaaF", "-")
    test("aFaaFaFaaFcFccFaaFccFaFcFaaFccFccFcFcFaFaFcFccFcFccFaaFcFaFcFaaFcFaFaaFccFaaFccFaFaaFaFcFaFccFaFaaFaFaaF", "17,14")
    test("aaFcFaaFccFaaFaaFcFaaFccFccFaFcFaFcFccFcFaaFaaFaFcFaFcFaaFcFaFaaFaFccFccFccFcFaFaFcFcFaFcFaaFcFaaFcFcFaaF", "27,23")
    test("ccFaFccFaFcFaFccFcFaaFccFccFcFaFccFccFaaFaaFaFaaFcFaaFccFcFaaFcFccFaaFcFaFccFccFaFccFaaFaaFcFcFccFaFccFcFcF", "25,18")
    test("cFcFccFaFaaFaaFccFccFcFccFccFaFcFaaFcFccFccFcFccFaFaFaFaFaFaaFaFcFaFccFcFccFaaFccFaaFccFcFaFaaFccFaFccFcFaaF", "16,4")
    test("aFcFcFaaFcFaaFcFaFaaFaaFaaFaFcFccFccFccFaFaaFaFaaFaaFcFcFccFaFaaFcFaFaaFccFaaFcFccFcFcFccFaaFcFaFccFaaFaaFccF", "19,15")
    test("ccFaaFcFaFccFaFccFaFcFaaFaaFccFaaFccFcFaFaFccFaFaaFaFaaFaFaaFaaFccFaaFaFcFaaFaFaFcFaaFcFaFaaFaaFcFccFaaFaFaFaF", "22,17")
    test("aaFcFaaFaFcFccFccFaFaFccFaFaaFaFcFccFaaFaaFaaFcFccFccFaFaaFccFcFaFaFcFaaFcFcFcFccFccFaaFcFcFaFccFccFccFaaFcFaaFcF", "14,5")
    test("cFcFaFccFaaFaFccFaFccFaaFaFccFaaFaaFccFaaFccFaaFccFaFaaFaFaFaaFaaFccFaFcFaaFcFcFaFaFcFcFcFaFaaFcFaFcFaaFccFccFcFaaFaFccF", "10,1")
    test("ccFaFcFaaFcFccFaFccFaaFccFaaFaaFcFaaFccFaaFccFccFcFaaFaaFcFaaFccFaaFcFcFaaFaFaFccFcFaFaFaFccFccFccFccFccFccFcFcFccFccFcF", "25,13")
    test("aFccFaFcFaFcFaaFaaFcFaaFccFaFaaFaFcFaFaaFaaFaaFccFaaFaaFccFccFccFccFccFaaFaFcFaFaFccFaFccFcFccFcFcFccFcFccFccFccFccFccFaF", "18,8")
    test("cFaaFcFaaFaFcFccFaaFcFccFcFaFccFaaFaaFccFccFccFaFcFccFcFaaFcFcFccFcFccFaFaFccFccFcFaFaFaaFcFaFcFccFccFccFaaFaFaFccFcFccFccF", "25,22")
    test("aaFcFccFcFaFcFaFaFcFccFaFaaFaFcFccFccFaaFccFccFaaFaaFccFaaFaaFccFaaFccFcFaaFaFcFaFcFccFaaFccFaFaFccFaaFcFaaFaFccFaaFaaFccFccFcFaF", "-")
    test("aFaaFccFccFaaFaaFccFccFaaFaaFaFcFccFaFcFaaFaFccFaaFccFaFcFaFccFaaFaaFaFccFaFaaFaaFcFaaFccFaaFcFaFccFccFaaFaaFaaFaaFccFcFccFaaFaFaaFaaF", "-")
    test("aaFcFccFccFaFccFaFccFaaFaaFaaFccFaaFaaFccFaaFccFaFaaFccFccFaaFcFccFaFccFcFaaFaFccFccFccFaaFaFccFccFaFaaFccFccFccFaaFccFccFaFaFcFaFccFccF", "-")
  end
end

Tester.new.test_all
