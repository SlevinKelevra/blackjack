require_relative 'card'

class Deck
  SUIT = [ :Hearts, :Diamonds, :Clubs, :Spades ]
  VALUE = [ 2, 3, 4, 5, 6, 7, 8, 9, 10 ]

  def initialize
    @@deck = []
    create_deck
    @@deck.shuffle!
  end

  private

  def create_deck
    SUIT.each do |suit|
      VALUE.each do |value|
        @@deck << Card.new(suit, value)
      end
    end
  end


end
