require "test/unit"
require Dir.getwd + "/Polynomial.rb"

class PolynomialTest < Test::Unit::TestCase
  def test_new_1
    p = Polynomial.new(4)
    assert_equal("x^3 + x^2 + x + 1",p.to_s)
  end

  def test_new_2
    p = Polynomial.new([3, -4, 6, 8])
    assert_equal("8x^3 + 6x^2 - 4x + 3",p.to_s)
  end

  def test_new_3
    p = Polynomial.new([3, -4, 0, -5])
    assert_equal("- 5x^3 - 4x + 3",p.to_s)
  end

  def test_new_4
    p = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3})
    assert_equal("3x^5 + 4x^3 + 5x^2 + 2x",p.to_s)
  end

  def test_new_5
    p = Polynomial.new({0 => 5, 2 => 5, 4 => 7, 5 => 5})
    assert_equal("5x^5 + 7x^4 + 5x^2 + 5",p.to_s)
  end

  def test_new_invalid_1()
    assert_raise(ArgumentError)  { Polynomial.new(0) }
  end

  def test_new_invalid_2()
    assert_raise(ArgumentError)  { Polynomial.new(-5) }
  end

  def test_new_invalid_3()
    assert_raise(ArgumentError)  { Polynomial.new([]) }
  end

  def test_new_invalid_4()
    assert_raise(ArgumentError)  { Polynomial.new({}) }
  end

  def test_new_invalid_5()
    assert_raise(ArgumentError)  { Polynomial.new("junk") }
  end

  def test_new_invalid_6()
    assert_raise(ArgumentError)  { Polynomial.new(nil) }
  end

  def test_new_invalid_7()
    assert_raise(ArgumentError)  { Polynomial.new({4 => 0, 2 => 0, 1 => 0}) }
  end

  def test_new_invalid_8()
    assert_raise(ArgumentError)  { Polynomial.new([0,0,0]) }
  end

  def test_add_1
    p = Polynomial.new(4)
    q = Polynomial.new([3, -4, 6, 8])
    assert_equal("9x^3 + 7x^2 - 3x + 4",(p + q).to_s)
  end

  def test_add_2
    p = Polynomial.new([3, -4, 6, 8])
    q = Polynomial.new([3, -4, 0, -5])
    assert_equal("3x^3 + 6x^2 - 8x + 6",(p + q).to_s)
  end

  def test_add_3
    p = Polynomial.new([3, -4, 0, -5])
    q = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3})
    assert_equal("3x^5 - x^3 + 5x^2 - 2x + 3",(p + q).to_s)
  end

  def test_add_4
    p = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3})
    q = Polynomial.new({0 => 5, 2 => 5, 4 => 7, 5 => 5})
    assert_equal("8x^5 + 7x^4 + 4x^3 + 10x^2 + 2x + 5",(p + q).to_s)
  end

  def test_add_5
    p = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3})
    assert_equal("6x^5 + 8x^3 + 10x^2 + 4x",(p + p).to_s)
  end

  def test_add_6
    p = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3})
    assert_equal(nil,p + "junk")
  end

  def test_negation_1
    p = Polynomial.new(4)
    assert_equal("- x^3 - x^2 - x - 1",(-p).to_s)
  end

  def test_negation_2
    p = Polynomial.new([3, -4, 6, 8])
    assert_equal("- 8x^3 - 6x^2 + 4x - 3",(-p).to_s)
  end

  def test_negation_3
    p = Polynomial.new([3, -4, 0, -5])
    assert_equal("5x^3 + 4x - 3",(-p).to_s)
  end

  def test_negation_4
    p = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3})
    assert_equal("- 3x^5 - 4x^3 - 5x^2 - 2x",(-p).to_s)
  end

  def test_negation_5
    p = Polynomial.new({0 => 5, 2 => 5, 4 => 7, 5 => 5})
    assert_equal("- 5x^5 - 7x^4 - 5x^2 - 5",(-p).to_s)
  end

  def test_negation_6
    p = Polynomial.new({0 => 5, 2 => 5, 4 => 7, 5 => 5})
    assert_equal("5x^5 + 7x^4 + 5x^2 + 5",(--p).to_s)
  end

  def test_negation_7
    p = Polynomial.new({0 => 5, 2 => 5, 4 => 7, 5 => 5})
    assert_equal("- 5x^5 - 7x^4 - 5x^2 - 5",(---p).to_s)
  end

  def test_subtract_1
    p = Polynomial.new(4)
    q = Polynomial.new([3, -4, 6, 8])
    assert_equal("- 7x^3 - 5x^2 + 5x - 2",(p - q).to_s)
  end

  def test_subtract_2
    p = Polynomial.new([3, -4, 6, 8])
    q = Polynomial.new([3, -4, 0, -5])
    assert_equal("13x^3 + 6x^2",(p - q).to_s)
  end

  def test_subtract_3
    p = Polynomial.new([3, -4, 0, -5])
    q = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3})
    assert_equal("- 3x^5 - 9x^3 - 5x^2 - 6x + 3",(p - q).to_s)
  end

  def test_subtract_4
    p = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3})
    q = Polynomial.new({0 => 5, 2 => 5, 4 => 7, 5 => 5})
    assert_equal("- 2x^5 - 7x^4 + 4x^3 + 2x - 5",(p - q).to_s)
  end

  def test_subtract_5
    p = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3})
    assert_equal(nil,p - p)
  end

  def test_subtract_6
    p = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3})
    assert_equal(nil,p - "junk")
  end

  def test_multscalar_1
    p = Polynomial.new(4)
    assert_equal("5x^3 + 5x^2 + 5x + 5",(p * 5).to_s)
  end

  def test_multscalar_2
    p = Polynomial.new([3, -4, 6, 8])
    assert_equal("- 80x^3 - 60x^2 + 40x - 30",(p * -10).to_s)
  end

  def test_multscalar_3
    p = Polynomial.new([3, -4, 0, -5])
    assert_equal("- 10x^3 - 8x + 6",(p * 2).to_s)
  end

  def test_multscalar_4
    p = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3})
    assert_equal("- 9x^5 - 12x^3 - 15x^2 - 6x",(p * -3).to_s)
  end

  def test_multscalar_5
    p = Polynomial.new({0 => 5, 2 => 5, 4 => 7, 5 => 5})
    assert_equal(nil,p * 0)
  end

  def test_mult_1
    p = Polynomial.new(4)
    q = Polynomial.new([3, -4, 6, 8])
    assert_equal("8x^6 + 14x^5 + 10x^4 + 13x^3 + 5x^2 - x + 3",(p * q).to_s)
  end

  def test_mult_2
    p = Polynomial.new([3, -4, 6, 8])
    q = Polynomial.new([3, -4, 0, -5])
    assert_equal("- 40x^6 - 30x^5 - 12x^4 - 15x^3 + 34x^2 - 24x + 9",(p * q).to_s)
  end

  def test_mult_3
    p = Polynomial.new([3, -4, 0, -5])
    q = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3})
    assert_equal("- 15x^8 - 32x^6 - 16x^5 - 26x^4 - 8x^3 + 7x^2 + 6x",(p * q).to_s)
  end

  def test_mult_4
    p = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3})
    q = Polynomial.new({0 => 5, 2 => 5, 4 => 7, 5 => 5})
    assert_equal("15x^10 + 21x^9 + 20x^8 + 68x^7 + 45x^6 + 49x^5 + 25x^4 + 30x^3 + 25x^2 + 10x",(p * q).to_s)
  end

  def test_mult_5
    p = Polynomial.new(4)
    assert_equal("x^6 + 2x^5 + 3x^4 + 4x^3 + 3x^2 + 2x + 1",(p * p).to_s)
  end

  def test_mult_6
    p = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3})
    assert_equal(nil,p * "junk")
  end

  def test_evaluate_1
    p = Polynomial.new(4)
    assert_equal(156,p.evaluate(5))
  end

  def test_evaluate_2
    p = Polynomial.new([3, -4, 6, 8])
    assert_equal(-827,p.evaluate(-5))
  end

  def test_evaluate_3
    p = Polynomial.new([3, -4, 0, -5])
    assert_equal(-850.88,p.evaluate(5.5))
  end

  def test_evaluate_4
    p = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3})
    assert_equal(-15623.78,p.evaluate(-5.5))
  end

  def test_evaluate_5
    p = Polynomial.new({0 => 5, 2 => 5, 4 => 7, 5 => 5})
    assert_equal(5,p.evaluate(0))
  end

  def test_evaluate_6
    p = Polynomial.new({0 => 5, 2 => 5, 4 => 7, 5 => 5})
    assert_equal(nil,p.evaluate("junk"))
  end

  def test_derivative_1
    p = Polynomial.new(4)
    assert_equal("3x^2 + 2x + 1",p.derivative.to_s)
  end

  def test_derivative_2
    p = Polynomial.new([3, -4, 6, 8])
    assert_equal("24x^2 + 12x - 4",p.derivative.to_s)
  end

  def test_derivative_3
    p = Polynomial.new([3, -4, 0, -5])
    assert_equal("- 15x^2 - 4",p.derivative.to_s)
  end

  def test_derivative_4
    p = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3})
    assert_equal("15x^4 + 12x^2 + 10x + 2",p.derivative.to_s)
  end

  def test_derivative_5
    p = Polynomial.new({0 => 5, 2 => 5, 4 => 7, 5 => 5})
    assert_equal("25x^4 + 28x^3 + 10x",p.derivative.to_s)
  end

  def test_derivative_6
    p = Polynomial.new({0 => 5})
    assert_equal(nil,p.derivative)
  end

  def test_integral_1
    p = Polynomial.new(4)
    assert_equal("0.25x^4 + 0.33x^3 + 0.50x^2 + x",p.integral.to_s)
  end

  def test_integral_2
    p = Polynomial.new([3, -4, 6, 8])
    assert_equal("2.00x^4 + 2.00x^3 - 2.00x^2 + 3.00x",p.integral.to_s)
  end

  def test_integral_3
    p = Polynomial.new([3, -4, 0, -5])
    assert_equal("- 1.25x^4 - 2.00x^2 + 3.00x",p.integral.to_s)
  end

  def test_integral_4
    p = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3})
    assert_equal("0.50x^6 + x^4 + 1.67x^3 + x^2",p.integral.to_s)
  end

  def test_integral_5
    p = Polynomial.new({0 => 5, 2 => 5, 4 => 7, 5 => 5})
    assert_equal("0.83x^6 + 1.40x^5 + 1.67x^3 + 5.00x",p.integral.to_s)
  end

  def test_integral_6
    p = Polynomial.new({3 => 4.5, 2 => -3, 1 => 2.5, 0 => 1.5})
    assert_equal("1.12x^4 - x^3 + 1.25x^2 + 1.50x",p.integral.to_s)
  end

  def test_integral_7
    p = Polynomial.new({3 => 4, 2 => -2, 1 => 1, 0 => 1})
    assert_equal("x^4 - 0.67x^3 + 0.50x^2 + x",p.integral.to_s)
  end

  def test_integral_8
    p = Polynomial.new({4 => 1, 2 => 2, 0 => 1})
    assert_equal("0.20x^5 + 0.67x^3 + x",p.integral.to_s)
  end

  def test_each_1
    p = Polynomial.new({4 => 1, 2 => 2, 0 => 1})
    i = 0
    p.each do |t|
      assert_equal(Term.new(1,4),t) if i == 0
      assert_equal(Term.new(2,2),t) if i == 1
      assert_equal(Term.new(1,0),t) if i == 2
      i += 1
    end
  end

  def test_each_2
    p = Polynomial.new([3, -4, 0, -5])
    i = 0
    p.each do |t|
      assert_equal(Term.new(-5,3),t) if i == 0
      assert_equal(Term.new(-4,1),t) if i == 1
      assert_equal(Term.new(3,0),t) if i == 2
      i += 1
    end
  end

  def test_each_3
    p = Polynomial.new([3, -4, 6, -5, 7])
    i = 0
    p.each do |t|
      assert_equal(Term.new(7,4),t) if i == 0
      assert_equal(Term.new(-5,3),t) if i == 1
      assert_equal(Term.new(6,2),t) if i == 2
      assert_equal(Term.new(-4,1),t) if i == 3
      assert_equal(Term.new(3,0),t) if i == 4
      i += 1
    end
  end

  def test_degree_1
    p = Polynomial.new(4)
    assert_equal(3,p.degree)
  end

  def test_degree_2
    p = Polynomial.new([3, -4, 6, 8])
    assert_equal(3,p.degree)
  end

  def test_degree_3
    p = Polynomial.new([3, -4, 0, -5, 6])
    assert_equal(4,p.degree)
  end

  def test_degree_4
    p = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3})
    assert_equal(5,p.degree)
  end

  def test_degree_5
    p = Polynomial.new({0 => 5, 2 => 5, 4 => 7, 5 => 5})
    assert_equal(5,p.degree)
  end

  def test_degree_6
    p = Polynomial.new([5])
    assert_equal(0,p.degree)
  end

  def test_degree_7
    p = Polynomial.new([5,10])
    assert_equal(1,p.degree)
  end

end
