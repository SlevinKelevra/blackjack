require_relative 'game'

class Player

  def initialize(name)
    @name = name
    @bank = 100
    @cards = []
  end

  def beginning_game
    count = 0
    if count < 2
      card = @@deck.random
      @card << card
      @@deck.delete(card)
      count +=
    end
    bet(@bank)
  end

end
