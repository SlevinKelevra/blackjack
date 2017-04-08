require_relative 'card'

class Deck
  SUIT = %w(♡ ♧ ♢ ♤)
  VALUE = %w(2 3 4 5 6 7 8 9 10 J Q K A)

  def initialize
    @deck = create_deck
  end

  private

  def create_deck
    deck = []
    SUIT.each do |suit|
      VALUE.each do |value|
        deck << Card.new(suit, value)
      end
    end
    deck.shuffle!
  end


end
