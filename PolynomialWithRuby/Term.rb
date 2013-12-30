class Term
  
  include Comparable
  
  #
  # Intializes the instance variables (@coef, @exp) of this object with the values provided.
  # Raise ArgumentError exception when any of these conditions are met:
  #   - coef is not a Fixnum or a Float
  #   - coef is 0
  #   - exp is not a Fixnum
  #   - exp is < 0
  #
  def initialize(coef,exp)
    # TO DO: parameter validation
    if !coef.is_a?(Numeric)
        raise ArgumentError.new("Coeficcient is not a number")
    end
    
    if coef == 0
        raise ArgumentError.new("Coeficcient can not be 0")
    end
    
    if !exp.is_a?(Numeric)
        raise ArgumentError.new("Exponent is not a number")
    end
    
    if exp < 0
        raise ArgumentError.new("Exponent must be positive")
    end
    
    @coef = coef
    @exp = exp
  end
  
  #
  # Getter for instance variable @coef
  #
  def coef
    @coef
  end
  
  #
  # Setter for instance variable @coef
  # Raise ArgumentError exception when any of these conditions are met:
  #   - coef is not a Fixnum or a Float
  #   - coef is 0
  def coef=(value)
      if !value.is_a?(Numeric)
          raise ArgumentError.new("Coeficcient is not a number")
      end
      
      if value == 0
          raise ArgumentError.new("Coeficcient can not be 0")
      end

      @coef = value
    
  end
  
  #
  # Getter for instance variable @exp
  #
  def exp
    @exp
  end
  
  #
  # Setter for instance variable @exp
  # Raise ArgumentError exception when any of these conditions are met:
  #   - exp is not a Fixnum
  #   - exp is < 0
  #
  def exp=(value)
    
    if !value.is_a?(Numeric)
        raise ArgumentError.new("Exponent is not a number")
    end
    
    if value < 0
        raise ArgumentError.new("Exponent must be positive")
    end
    
    @exp = value
    
  end
  
  #
  # Compares this object against another object, returning -1, 0, or +1 depending on
  # whether this object is less than, equal to, or greater than the other object. Uses @exp
  # field as the basis for comparison.
  # Return nil if other is not a Term object
  #
  def <=>(other)
    if other.instance_of?(Term)
        exp <=> other.exp
    else
        nil
    end
  end
  
  #
  # Returns a string representation of this Term in the form shown below:
  #   + 4x
  #   + 5x^2
  #   - 6x
  #   + 10
  #   - 3x^4
  #
  def to_s

      if @coef < 0
          printString = ' - '
      else
          printString = ' + '
      end
      
      if @coef.abs != 1
      	if !@coef.instance_of?(Float)
            printString << @coef.abs.to_s
        else  
        	printString << sprintf("%.2f", @coef.abs)
        end
      end
      
      if @exp > 0
          printString << 'x'
          
          if @exp > 1
              printString << '^' << @exp.to_s
          end
      elsif @exp == 0 && @coef.abs == 1
          printString << @coef.abs.to_s
      end
      printString
  end
  
end