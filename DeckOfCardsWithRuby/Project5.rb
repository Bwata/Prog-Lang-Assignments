#
# CIS 343, Fall 2013
# Project 5
# Author(s): Thomas Verstraete
# Ruby Version for Testing: 1.8.7

#
# A class that represents a card used in card games
#    rank of card: 'A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K'
#    suit of card: 'c', 'd', 'h', 's'
#    string representation: rank followed by the suit - "8d", "Js", "Th", ...
#

$allSuit = ['c', 'd', 'h', 's']
$allRank = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']

class Card
    
    # Getter methods for instance variables @rank and @suit
    attr_reader :rank, :suit
    
    #
    # Initialize the instance variables with parameter values
    # Raises ArgumentError if input is not valid
    #
    def initialize(rank, suit)
        
        if $allRank.include?(rank)
                @rank = rank
        else
            raise ArgumentError.new("Rank not valid")
        end
        
        if $allSuit.include?(suit)
            @suit = suit
        else
            raise ArgumentError.new("suit not valid")
        end
        
    end
    
    #
    # Setter method for instance variable @rank
    # Raises ArgumentError if input is not valid
    #
    def rank=(rank)
        if $allRank.include?(rank)
            @rank = rank
            else
            raise ArgumentError.new("Rank not valid")
        end

    end
    
    #
    # Setter method for instance variable @suit
    # Raises ArgumentError if input is not valid
    #
    def suit=(suit)
        if $allSuit.include?(suit)
            @suit = suit
            else
            raise ArgumentError.new("suit not valid")
        end
    end
    
    #
    # Returns string representation of Card object
    #
    def to_s
        @rank.to_s + @suit.to_s
    end
end

#
# A class that represents a deck of 52 playing cards using an array of Card class defined above
#
class CardDeck
    
    #
    # Initialize instance variable @deck (an array) with 52 cards in a normal deck of cards
    #
    def initialize
        @cardCount = 52
        @deck = []
        # TO DO
        
        $allRank.each do |r|
            $allSuit.each do |s|
                @deck << Card.new(r, s)
            end
        end
    end
    
    #
    # Shuffles the cards in the deck and returns nil
    #
    def shuffle
        
        (1...1000000).each do |i|
            randNum1 = rand(52)
            randNum2 = rand(52)
            
            until randNum1 != randNum2
                randNum2 = rand(52)
            end
            
            tempCard = @deck[randNum1]
            @deck[randNum1] = @deck[randNum2]
            @deck[randNum2] = tempCard
        
        end
        nil
    end
    
    #
    # Returns true if the deck is empty false otherwise
    #
    def empty?
        if @cardCount == 0
            true
        else
            false
        end
    end
    
    #
    # Returns the number of cards in the deck
    #
    def size
        @cardCount
    end
    
    #
    # Deals and returns n number of cards from the deck as an array
    # Returns nil if any these conditions is met:
    #    n is not a Fixnum
    #    n < 1 or n > deck size
    #    deck size is 0
    #
    def deal(n=1)
        
        if !n.instance_of?(Fixnum)
            nil
        elsif n < 1 || n > @cardCount
            nil
        elsif @cardCount == 0
            nil
        else
            dealDeck = []
            
            (1..n).each do |i|
                dealDeck << @deck[(@cardCount - 1)]
                @cardCount -= 1
            end
            
            dealDeck
       end
    end
    
    #
    # Returns a string representation of an array of Card objects (see sample output)
    # Returns nil if input is not an Array
    # Returns nil if the array contains objects that are not Card type
    #
    def CardDeck.to_s(ary_of_cards)
        printString = '['
        
        if ary_of_cards.instance_of?(Array)
            
            ary_of_cards.each_with_index do |card, index|
                
                
                
                if !card.instance_of?(Card)
                    printString = nil
                    break
                end
                
                printString << card.to_s
                
                
                
                
                if index < ary_of_cards.length-1
                    printString << ','
                else
                    printString << ']'
                end
                
                
            end
            
            printString
                
        else
            nil
        end
    end
    
    #
    # Returns the string representation of Card objects in the deck
    #
    def to_s
        printString = '['
        
        (0...@cardCount).each do |index|
            
            printString << @deck[index].to_s
            
            if index < @cardCount-1
                printString << ','
            end
            
        end
        
        printString << ']'
    end
    
end

#
# Open the Array class and add two new methods to this class
#

class Array
    
    #
    # Returns the symmetric difference of self array and other array
    # Returns nil if other is not an Array
    # code was addapted from: http://rosettacode.org/wiki/Symmetric_difference#Ruby
    def ^(other)
        if other.instance_of?(Array)
            a_not_b = self - other
            b_not_a = other - self
            sym_diff = a_not_b + b_not_a
        else
            nil
        end
    end

    #
    # Returns the cartesian product of self array and other array
    # Returns nil if other is not an Array
    #
    def **(other)
        return_array = []

        if other.instance_of?(Array)
            self.each do |self_element|
                
                other.each do |other_element|
                    return_array << [self_element, other_element]
                end
            end
            return_array
        else
            nil
        end
    end

    def to_s
        printString = '['
        
        self.each_with_index do |element, index|
            printString << element.to_s
            
            if index < self.length-1
                printString << ', '
                else
                printString << ']'
            end
        end
        
        printString
    end

end

#
# global function to test the functionality of Card, CardDeck, and Array classes
#
def main
    # Test the methods of Card class
    c = Card.new('A','s')
    puts c.rank()
    puts c.suit()
    puts c
    
    c = Card.new('10','s')
    puts c.rank()
    puts c.suit()
    puts c
    
    begin
        c.rank= '15'
    rescue ArgumentError => ex
        puts ex.message
    end
    
    begin
        c.suit= 'z'
    rescue ArgumentError => ex
        puts ex.message
    end
    
    begin
        Card.new('15','s')
    rescue ArgumentError => ex
        puts ex.message
    end
    
    begin
        Card.new('4','z')
    rescue ArgumentError => ex
        puts ex.message
    end
    
    begin
        Card.new('b','z')
    rescue ArgumentError => ex
        puts ex.message
    end


    #Test the methods of CardDeck class
    d = CardDeck.new
    puts "\nNew deck of 52 cards: #{d}"
    puts "Deck size: #{d.size}"
    puts "Deck empty? #{d.empty?}"
    
    d.shuffle
    puts "Shuffled deck of 52 cards: #{d}"
    puts "Deck size: #{d.size}"
    puts "Deck empty? #{d.empty?}"
    
    puts "Deal one card from the deck: #{CardDeck.to_s(d.deal())}"
    puts "Deal one card from the deck: #{CardDeck.to_s(d.deal(1))}"
    puts "Deal ten cards from the deck: #{CardDeck.to_s(d.deal(10))}"
    puts "Deck size after dealing: #{d.size}"
    
    d = CardDeck.new
    puts "\nNew deck of 52 cards: #{d}"
    puts "Deck size: #{d.size}"
    puts "Deck empty? #{d.empty?}"
    puts "Deal all cards from the deck: #{CardDeck.to_s(d.deal(52))}"
    puts "Deck after dealing all cards: #{d}"
    puts "Deck empty? #{d.empty?}"
    puts "Deck size after dealing: #{d.size}"
    
    d = CardDeck.new
    puts "\nNew deck of 52 cards: #{d}"
    puts "Deck size: #{d.size}"
    puts "Deck empty? #{d.empty?}"
    puts "Dealing 55 cards from a new deck will return nil: #{d.deal(55).nil?}"
    puts "Deck empty? #{d.empty?}"
    puts "Deck size after dealing: #{d.size}"
    
    puts "Deal 20 cards from the deck: #{CardDeck.to_s(d.deal(20))}"
    puts "Deck empty? #{d.empty?}"
    puts "Deck size after dealing: #{d.size}"
    
    puts "Dealing 35 cards from the deck now will return nil: #{d.deal(35).nil?}"
    puts "Dealing -10 cards from the deck will return nil: #{d.deal(-10).nil?}"
    puts "Dealing 1.5 cards from the deck will return nil: #{d.deal(1.5).nil?}"
    puts "Dealing 'junk' cards from the deck will return nil: #{d.deal('junk').nil?}"
    puts "Deck empty? #{d.empty?}"
    puts "Deck size after dealing: #{d.size}"
    
    deck = [Card.new('5','s'), Card.new('J','s'), 5, Card.new('10','s'), nil, "junk"]
    puts "This should return nil: #{CardDeck.to_s(deck).nil?}"
    
    # Test methods added to the Array class
    a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    b = [1, 3, 5, 7, 9, 11, 13, 15]
    c = [2, 4, 6, 8, 10, 12, 14, 16]
    d = []
    
    puts "\na^b:  #{(a^b).sort}"
    puts "a^c:  #{(a^c).sort}"
    puts "b^c:  #{(b^c).sort}"
    puts "b^d:  #{(b^d).sort}"
    puts "d^b:  #{(d^b).sort}"
    
    a = [1, 2, 3]
    b = ['a', 'b', 'c', 'c']
    puts("a**b:  #{a**b}")
    puts "a^5 should be nil: #{(a^5).nil?}"
    puts "a**5 should be nil: #{(a**5).nil?}"
end

# invoke the main function
main()
