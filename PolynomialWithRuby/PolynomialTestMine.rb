require "test/unit"
require Dir.getwd + "/Polynomial.rb"
 
class PolynomialTest < Test::Unit::TestCase
 
 ########## initialize Testing #############
 
  def test_initialize_fixnum_4
    p = Polynomial.new(4)
    assert_equal("x^3 + x^2 + x + 1",p.to_s)
  end
  
  def test_initialize_fixnum_1
      p = Polynomial.new(1)
      assert_equal("1",p.to_s)
  end
  
  def test_initialize_array_4_pos
      p = Polynomial.new([ 3, 4, 6, 8])
      assert_equal("8x^3 + 6x^2 + 4x + 3",p.to_s)
  end
  
  def test_initialize_array_4_neg
      p = Polynomial.new([-3, -4, -6, -8])
      assert_equal("- 8x^3 - 6x^2 - 4x - 3",p.to_s)
  end
  
  def test_initialize_hash_4
      p = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3})
      assert_equal("3x^5 + 4x^3 + 5x^2 + 2x",p.to_s)
  end
  
  def test_initialize_array_floats
      p = Polynomial.new([ 3.3, 4.4, 6.6, 8.8])
      assert_equal("8x^3 + 6x^2 + 4x + 3",p.to_s)
  end
  
=begin
  ########## Initialize Error Testing #############
  
  def test_initialize_error_fixnum_zero
      assert_raise(ArgumentError) {
          p = Polynomial.new(0)
      }
  end
  
  def test_initialize_error_fixnum_neg
      assert_raise(ArgumentError) {
          p = Polynomial.new(-1)
      }
  end
  
  def test_initialize_error_array_empty
      assert_raise(ArgumentError) {
          p = Polynomial.new([])
      }
  end
  
  def test_initialize_error_hash_empty
      assert_raise(ArgumentError) {
          p = Polynomial.new(Hash.new)
      }
  end
  
  ########## Addition Testing #############
  

  
  def test_add_all_matches
      p1 = Polynomial.new({ 3 => 4, 2 => 3, 1 => 2, 0 => 1}) #=> 4x^3 + 3x^2 + 2x + 1
      p2 = Polynomial.new({ 3 => 4, 2 => 3, 1 => 2, 0 => 1}) #=> 4x^3 + 3x^2 + 2x + 1
      p3 = p1 + p2
      assert_equal("8x^3 + 6x^2 + 4x + 2",p3.to_s)
  end
  
  def test_add_no_matches
      p1 = Polynomial.new({6 => 4, 4 => 3, 2 => 2 }) #=> 4x^6 + 3x^4 + 2x^2
      p2 = Polynomial.new({5 => 4, 3 => 3, 1 => 2 }) #=> 4x^5 + 3x^3 + 2x
      p3 = p1 + p2
      assert_equal("4x^6 + 4x^5 + 3x^4 + 3x^3 + 2x^2 + 2x",p3.to_s)
  end
  
  def test_add_with_negatives
      p1 = Polynomial.new({5 => 4, 3 => -5, 1 => 2 }) #=> 4x^5 - 5x^3 + 2x
      p2 = Polynomial.new({5 => -2, 3 => 3, 1 => -1 }) #=> - 2x^5 + 3x^3 - 1x
      p3 = p1 + p2
      assert_equal("2x^5 - 2x^3 + x",p3.to_s)
  end
  
  def test_add_extra_1
      p1 = Polynomial.new([ 3, -4, 6, 8]) #=> 8x^3 + 6x^2 - 4x + 3
      p2 = Polynomial.new([ 3, -4, 0, -5]) #=> - 5x^3 - 4x + 3
      p3 = p1 + p2
      assert_equal("3x^3 + 6x^2 - 8x + 6",p3.to_s)
  end
  
  def test_add_extra_2
      p1 = Polynomial.new([3, -4, 6, 8]) #=> 8x^3 + 6x^2 - 4x + 3
      p2 = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3}) #=> 3x^5 + 4x^3 + 5x^2 + 2x
      p3 = p1 + p2
      assert_equal("3x^5 + 12x^3 + 11x^2 - 2x + 3",p3.to_s)
  end

  
  ########## Subtraction Testing #############
  # need to test x^2 - x^2 = 0
  

    def test_sub_all_matches
        p1 = Polynomial.new({ 3 => 4, 2 => 3, 1 => 2, 0 => 1}) #=> 4x^3 + 3x^2 + 2x + 1
        p2 = Polynomial.new({ 3 => 3, 2 => 4, 1 => 1, 0 => 2}) #=> 3x^3 + 4x^2 + 1x + 2
        p3 = p1 - p2
        assert_equal("x^3 - x^2 + x - 1",p3.to_s)
    end

    def test_sub_no_matches
        p1 = Polynomial.new({6 => 4, 4 => 3, 2 => 2 }) #=> 4x^6 + 3x^4 + 2x^2
        p2 = Polynomial.new({5 => 4, 3 => 3, 1 => 2 }) #=> 4x^5 + 3x^3 + 2x
        p3 = p1 - p2
        assert_equal("4x^6 - 4x^5 + 3x^4 - 3x^3 + 2x^2 - 2x",p3.to_s)
    end

    def test_sub_with_negatives
        p1 = Polynomial.new({5 => 4, 3 => -5, 1 => 2 }) #=> 4x^5 - 5x^3 + 2x
        p2 = Polynomial.new({5 => -2, 3 => 3, 1 => -1 }) #=> - 2x^5 + 3x^3 - 1x
        p3 = p1 - p2
        assert_equal("6x^5 - 8x^3 + 3x",p3.to_s)
    end

    def test_sub_extra_1
        p1 = Polynomial.new([ 3, -4, 6, 8]) #=> 8x^3 + 6x^2 - 4x + 3
        p2 = Polynomial.new([ 3, -4, 0, -5]) #=> - 5x^3 - 4x + 3
        p3 = p1 - p2
        assert_equal("13x^3 + 6x^2",p3.to_s)
    end

    def test_sub_extra_2
        p1 = Polynomial.new([3, -4, 6, 8]) #=> 8x^3 + 6x^2 - 4x + 3
        p2 = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3}) #=> 3x^5 + 4x^3 + 5x^2 + 2x
      p3 = p1 - p2
      assert_equal("- 3x^5 + 4x^3 + x^2 - 6x + 3",p3.to_s)
  end
  
  
  ########## Negation Testing #############
  
  
  def test_negation_1
      p1 = Polynomial.new(4)
      assert_equal("- x^3 - x^2 - x - 1",(-p1).to_s)
  end
  
  def test_negation_2
      p1 = Polynomial.new([ 3, -4, 6, 8])
      assert_equal("- 8x^3 - 6x^2 + 4x - 3",(-p1).to_s)
  end
  
  def test_negation_3
      p1 = Polynomial.new([3, -4, 0, -5])
      assert_equal("5x^3 + 4x - 3",(-p1).to_s)
  end
  
  def test_negation_4
      p1 = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3})
      assert_equal("- 3x^5 - 4x^3 - 5x^2 - 2x",(-p1).to_s)
  end
  
  def test_negation_5
      p1 = Polynomial.new({0 => 5, 2 => 5, 4 => 7, 5 => 5})
      assert_equal("- 5x^5 - 7x^4 - 5x^2 - 5",(-p1).to_s)
  end
  
  ########## Multiply Polys Testing #############
  
  def test_multiply_all_matches
      p1 = Polynomial.new({ 3 => 4, 2 => 3, 1 => 2, 0 => 1}) #=> 4x^3 + 3x^2 + 2x + 1
      p2 = Polynomial.new({ 3 => 4, 2 => 3, 1 => 2, 0 => 1}) #=> 4x^3 + 3x^2 + 2x + 1
      p3 = p1 * p2
      assert_equal("16x^6 + 24x^5 + 25x^4 + 20x^3 + 10x^2 + 4x + 1",p3.to_s)
  end
  
  def test_multiply_no_matches
      p1 = Polynomial.new({6 => 4, 4 => 3, 2 => 2 }) #=> 4x^6 + 3x^4 + 2x^2
      p2 = Polynomial.new({5 => 4, 3 => 3, 1 => 2 }) #=> 4x^5 + 3x^3 + 2x
      p3 = p1 * p2
      assert_equal("16x^11 + 24x^9 + 25x^7 + 12x^5 + 4x^3",p3.to_s)
  end
  
  def test_multiply_with_negatives
      p1 = Polynomial.new({5 => 4, 3 => -5, 1 => 2 }) #=> 4x^5 - 5x^3 + 2x
      p2 = Polynomial.new({5 => -2, 3 => 3, 1 => -1 }) #=> - 2x^5 + 3x^3 - 1x
      p3 = p1 * p2
      assert_equal("- 8x^10 + 22x^8 - 23x^6 + 11x^4 - 2x^2",p3.to_s)
  end
  
  def test_multiply_extra_1
      p1 = Polynomial.new([ 3, -4, 6, 8]) #=> 8x^3 + 6x^2 - 4x + 3
      p2 = Polynomial.new([ 3, -4, 0, -5]) #=> - 5x^3 - 4x + 3
      p3 = p1 * p2
      assert_equal("- 40x^6 - 30x^5 - 12x^4 - 15x^3 + 34x^2 - 24x + 9",p3.to_s)
  end
  
  def test_multiply_extra_2
      p1 = Polynomial.new([3, -4, 6, 8]) #=> 8x^3 + 6x^2 - 4x + 3
      p2 = Polynomial.new({1 => 2, 2 => 5, 3 => 4, 5 => 3}) #=> 3x^5 + 4x^3 + 5x^2 + 2x
      p3 = p1 * p2
      assert_equal("24x^8 + 18x^7 + 20x^6 + 73x^5 + 30x^4 + 4x^3 + 7x^2 + 6x",p3.to_s)
  end

    ########## Multiply Nums Testing #############
    # * -num
    # * 0
    # * 0.4
    # * 4.4

    def test_multiply_fixnum_1
        p1 = Polynomial.new({ 3 => 4, 2 => 3, 1 => 2, 0 => 1}) #=> 4x^3 + 3x^2 + 2x + 1
        eval = p1 * 4
        assert_equal(595,eval)
    end



  ########## Evaluation Testing #############
  # eval @ 0
  # eval @ -num
  # eval at floats
  
  def test_evaluation_1
      p1 = Polynomial.new([ 3, -4, 6, 8])
      eval = p1.evaluate(4)
      assert_equal(595,eval)
  end
  
  
  ########## Degree Testing ############
  # check for a few numbers
  # check for degree 1 & 0
  
  def test_degree_1
      p1 = Polynomial.new([ 3, -4, 6, 8])
      deg = p1.degree
      assert_equal(3,deg)
  end
  
  ########## Derivative Testing #############
  # derivative of ax^0
  # der of ax^1
  
  
  def test_derivative_1
      p1 = Polynomial.new([ 3, -4, 6, 8])
      p1d = p1.derivative
      assert_equal("24x^2 + 12x - 4",p1d.to_s)
  end
  
  
  ########## Integral Testing #############
  # what do we do with the "+ c"
  #
  
  def test_itegral_1
      p1 = Polynomial.new([ 3, -4, 6, 8])
      p1i = p1.integral
      assert_equal("2x^4 + 2x^3 - 2x^2 + 3x",p1i.to_s)
  end

  # additional unit tests here
=end 
end
