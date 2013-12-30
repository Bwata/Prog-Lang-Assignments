require "test/unit"
require Dir.getwd + "/Term.rb"

class TermTest < Test::Unit::TestCase
    
    
    ########## initialize Testing #############
    
    def test_initialize_success
        t = Term.new(4, 3)
        assert_equal(" + 4x^3",t.to_s)
    end
    
    def test_initialize_exp_zero
        t = Term.new(4, 0)
        assert_equal(" + 4",t.to_s)
    end
    
    def test_initialize_exp_1
        t = Term.new(4, 1)
        assert_equal(" + 4x",t.to_s)
    end
    
    def test_initialize_coef_1
        t = Term.new(1, 4)
        assert_equal(" + x^4",t.to_s)
    end
    
    def test_initialize_success_neg_coef
        t = Term.new(-4, 3)
        assert_equal(" - 4x^3",t.to_s)
    end
    
    def test_initialize_exp_zero_neg_coef
        t = Term.new(-4, 0)
        assert_equal(" - 4",t.to_s)
    end
    
    def test_initialize_exp_1_neg_coef
        t = Term.new(-4, 1)
        assert_equal(" - 4x",t.to_s)
    end
    
    def test_initialize_coef_1_neg_coef
        t = Term.new(-1, 4)
        assert_equal(" - x^4",t.to_s)
    end
    
    
    
    ########## Initialize Error Testing #############
    
    def test_initialize_error_coef_not_num
        assert_raise(ArgumentError) {
            t = Term.new("mouse", 4)
        }
    end
    
    def test_initialize_error_exp_not_num
        assert_raise(ArgumentError) {
            t = Term.new(4, "cat")
        }
    end
    
    def test_initialize_error_coef_zero
        assert_raise(ArgumentError) {
            t = Term.new(0, 4)
        }
    end
    
    def test_initialize_error_exp_negative
        assert_raise(ArgumentError) {
            t = Term.new(4, -4)
        }
    end
    
    
    ########## Getters/Setters Testing #############
    
    def test_getter_coef_success
        t = Term.new(4, 3)
        assert_equal(4,t.coef)
    end
    
    def test_getter_exp_success
        t = Term.new(4, 3)
        assert_equal(3,t.exp)
    end
    
    def test_setter_coef_success
        t = Term.new(2, 3)
        t.coef=(4)
        assert_equal(4,t.coef)
    end
    
    def test_setter_exp_success
        t = Term.new(4, 1)
        t.exp=(3)
        assert_equal(3,t.exp)
    end
    
    
    ########## Getters/Setters Error Testing #############
    

    def test_setter_coef_not_num
        assert_raise(ArgumentError) {
            t = Term.new(4, 3)
            t.coef=('mouse')
        }
    end

    def test_setter_error_exp_not_num
        assert_raise(ArgumentError) {
            t = Term.new(4, 3)
            t.exp=('mouse')
        }
    end

    def test_setter_error_coef_zero
        assert_raise(ArgumentError) {
            t = Term.new(4, 3)
            t.coef=(0)
        }
    end

    def test_setter_error_exp_negative
        assert_raise(ArgumentError) {
            t = Term.new(4, 3)
            t.exp=(-4)
        }
    end
    
    
    
    ########## <=> Testing #############
    
    def test_compare_less_then
        t = Term.new(4, 3)
        v = Term.new(4, 5)
        a = t.<=>(v)
        assert_equal(-1,a)
    end
    
    def test_compare_greater_then
        t = Term.new(4, 5)
        v = Term.new(4, 3)
        a = t.<=>(v)
        assert_equal(1,a)
    end
    
    def test_compare_equal
        t = Term.new(4, 3)
        v = Term.new(4, 3)
        a = t.<=>(v)
        assert_equal(0,a)
    end
    
    def test_compare_not_term_object
        t = Term.new(4, 3)
        v = 'Trillium'
        a = t.<=>(v)
        assert_equal(nil,a)
    end
    
    


    # additional unit tests here
    
end
