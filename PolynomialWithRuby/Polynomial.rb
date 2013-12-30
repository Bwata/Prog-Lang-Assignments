require Dir.getwd + "/Term.rb"

#
# Class to represent a univariate (single variable) polynomial (with non-negative integer
# exponents) and operations on polynomials.
#
class Polynomial
  
  include Enumerable
  
  #
  # Creates/initializes a new Polynomial obejct using the parameter value. The parameter could
  # be a Fixnum, an Aray, or a Hash. Otherwise, raise ArgumentError exception.
  #
  # Examples:
  #   Polynomial.new(4).to_s  #=> "x^3 + x^2 + x + 1"
  #   Polynomial.new[3, -4, 6, 8].to_s #=> "8x^3 + 6x^2 - 4x + 3"
  #   Polynomial.new[3, -4, 0, -5].to_s #=> "- 5x^3 - 4x + 3"
  #   Polynomial.new{1 => 2, 2 => 5, 3 => 4, 5 => 3}.to_s #=> "3x^5 + 4x^3 + 5x^2 + 2x"
  #   Polynomial.new{0 => 5, 2 => 5, 4 => 7, 5 => 5}.to_s #=> "5x^5 + 7x^4 + 5x^2 + 5"
  #
  # Raise ArgumentError exception if the parameter meets any of these conditions:
  #   - an integer <= 0
  #   - an empty array
  #   - empty hash
  def initialize(arg)
    # polynomial must be stored as a set of Term objects in the @terms array
    @terms = Array.new
    
    if arg.instance_of?(Fixnum)
        
        if arg <= 0
            raise ArgumentError.new("Fixnum must be a positive non-zero number")
        end
        
        x = 0...arg
        x.each {|i| @terms << Term.new(1, i)}
        
    
    elsif arg.instance_of?(Array)
    
        if arg.size == 0
            raise ArgumentError.new("Array may not be empty")
        end
        
        if arg[0].instance_of?(Term)
            arg.each {|newTerm| @terms << newTerm}
        else
        
            arg.each_with_index do |element,index|
                if element != 0
                    @terms << Term.new(element, index)
                end
            end
        
        end
        
        if @terms.length == 0
        	raise ArgumentError.new("Array may not be empty")
        else
        	@terms
        end
        
    elsif arg.instance_of?(Hash)
    
        if arg.size == 0
            raise ArgumentError.new("Hash may not be empty")
        end
    
        arg.each { |key,value| @terms << Term.new(value, key)}
        
        if @terms.length == 0
        	raise ArgumentError.new("Hash may not be empty")
        else
        	@terms
        end
    else
        raise ArgumentError.new("Invalid Polynomial Argument")
    end
          
    # sort the Terms in the array in decreasing order of exponent
    @terms.sort! {|a,b| b <=> a}
  end
  
  #
  # Performs polynomial addition
  # If other is a Polynomial object, returns a new Polynomial object that is
  # the sum of this Polynomial object and the other Polynomial object.
  # Otherwise, it returns nil.
  #
  def +(other)
  
      newTerms = Array.new
      
      if !other.instance_of?(Polynomial)
            nil
      else
            i = 0
            #Iterate down each "array" and places item in its place. If exp are == then adds
            other.each do |otherTerm|
                #Checks if the two exponents are equal
                if (i < @terms.length) && (otherTerm.exp == @terms[i].exp)
                
                    begin
                        newTerms << Term.new((@terms[i].coef + otherTerm.coef), @terms[i].exp)
                    rescue ArgumentError => exp
                    end
                    if i < @terms.length then i=i+1 end
                #Checks if this terms expenent is equal
                elsif (i < @terms.length) && (otherTerm.exp < @terms[i].exp)
                    newTerms << @terms[i]
                    if i < @terms.length then i=i+1 end
                    redo
                else
                    newTerms << otherTerm
                end

            end

            (i...@terms.length).each do |n|
                newTerms << @terms[i]
            end
                
            if newTerms.length == 0
            	nil
            else
            	Polynomial.new(newTerms)
            end
      end
  end

  #
  # Performs polynomial substraction
  # If other is a Polynomial object, returns a new Polynomial object that is
  # the result of subtracting other Polynomial object from this Polynomial object.
  # Otherwise, it returns nil.
  #

  def -(other)
	if other.instance_of?(Polynomial)
    	self + (-other)
    else
    	nil
    end
  end

  #
  # Performs polynomial negation
  # Returns a new Polynomial object with negated coefficients of this Polynomial object
  #
  def -@
	
    newTerms = Array.new

    @terms.each do |thisTerm|
       begin
		   newTerms << Term.new(-(thisTerm.coef), thisTerm.exp)
       rescue ArgumentError => exp
       end
    end

    if newTerms.length == 0
		nil
	else
		Polynomial.new(newTerms)
	end

  end
  
  #
  # Performs polynomial multiplication
  # If other is a Polynomial, Fixnum, or Float object, returns a new Polynomial object that is
  # the result of multiplying this Polynomial object and other object.
  # Otherwise, it returns nil.
  #      
  def *(other)

    newTerms = Array.new

    if other.instance_of?(Polynomial)
        tempPoly = nil
        #Iterate down each "array" and places item in its place. If exp are == then adds
        @terms.each_with_index do |thisTerm, index|
            
            other.each do |otherTerm|
               	begin
               		newTerms << Term.new((thisTerm.coef * otherTerm.coef), (thisTerm.exp + otherTerm.exp))
            	rescue ArgumentError => exp
                end
            end
            
            if index == 0
                tempPoly = Polynomial.new(newTerms)
                newTerms = Array.new
            else
                aPoly = Polynomial.new(newTerms)
                #puts "(#{tempPoly}) + (#{aPoly})"
                tempPoly = tempPoly + aPoly
                #puts "= #{tempPoly}"
                newTerms = Array.new
                
            end
            
       
        end
            
        tempPoly
          
    elsif other.instance_of?(Fixnum) || other.instance_of?(Float)
    
    	if other == 0
    		nil
    	else
			@terms.each do |thisTerm|
				begin
				newTerms << Term.new((thisTerm.coef*other), thisTerm.exp)
				rescue ArgumentError => exp
                end
			end
	
			if newTerms.length == 0
            	nil
            else
            	Polynomial.new(newTerms)
            end
        end
    else
        nil
    end
        
  end
  
  #
  # Performs polynomial evaluation/substitution
  # If the parameter is an Fixnum or Float object, evaluates the polynomial at value x.
  # Otherwise, it returns nil.
  def evaluate(x)
      
      if x.instance_of?(Fixnum) || x.instance_of?(Float)
          result = 0
          
          @terms.each do |thisTerm|
              result = result + (thisTerm.coef * (x ** thisTerm.exp))
          end
          
          result.instance_of?(Float) ? sprintf("%.2f",result).to_f : result
          
      else
        nil
      end
              
      
  end
  
  #
  # Returns the degree (the highest power of variable) of the polynomial
  #
  def degree
    @terms[0].exp
  end

  #
  # If the degree of this Polynomial object is > 0, then it computes and returns
  # the derivative (which is itself a polynomial) of this polynomial.
  # Otherwise, it returns nil.
  #
  def derivative
    
    newTerms = Array.new
    
    @terms.each do |thisTerm|
       
       if thisTerm.exp > 0
			begin
         		  newTerms << Term.new(thisTerm.coef * thisTerm.exp, thisTerm.exp-1)
       		rescue ArgumentError => exp
            end
       end
    end
	if newTerms.length == 0
		nil
	else
		Polynomial.new(newTerms)
	end
  end
  
  #
  # Computes and returns indefinite integral (which is itself a polynomial) of this polynomial.
  #
  def integral
    
    newTerms = Array.new
    
    @terms.each do |thisTerm|
        
        if thisTerm.exp >= 0
        	begin
            	newTerms << Term.new(thisTerm.coef.to_f / (thisTerm.exp+1), thisTerm.exp+1)
        	rescue ArgumentError => exp
            end
        end
    end
    
    if newTerms.length == 0
		nil
	else
		Polynomial.new(newTerms)
	end
    
  end
  
  #
  # Yields each term in the polynomial to the block associated with the call to this method
  #
  def each
      @terms.each {|s| yield s}
  end
  
  #
  # Returns a string representation of this polynomial object in the standard format (term 
  # with the highest degree first and the term with the lowest degree last as shown below:
  #     3x^4 + 4x^2 - 5x + 6
  #     - 5x^3 + 7x^2 - 4x + 10
  #
  def to_s
      
      printString = ""
      
      @terms.each { |item| printString = printString + item.to_s }

      printString = printString[1..printString.length]

      if printString[0] == ?+
          printString = printString[2...printString.length]
      end
      
      printString

  end
  
end