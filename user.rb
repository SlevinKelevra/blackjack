class User

  attr_reader :name, :cards, :balance
  attr_reader :passed_move, :took_card, :open_cards

  def initialize(name)
    @name = name
    @balance = BALANCE
    @cards = []
    @passed_move = false
    @took_card = false
    @open_cards = false
  end

  def take_money(summa)
    @balance += summa
  end

  def win(bank)
    puts "#{@name} win!"
    take_money(bank)
  end

  def take_cards(cards)
    @cards.concat(cards) if can_take_cards?
  end

  def show_cards_back
    @cards.each { printf('%4s', '*') }
  end

  def show_cards_face
    @cards.each { |card| printf('%4s', "#{card.value}#{card.suit}") }
  end

  def show_balance
    puts "#{@name}'s balance: #{@balance}"
  end

  def make_bet
    @balance -= RATE
    RATE
  end

  protected

  attr_writer :passed_move, :took_card, :open_cards

  BALANCE = 100
  RATE = 10
  MAX_CARDS_COUNT = 3

  def can_take_card?
    @cards.size < MAX_CARDS_COUNT
  end

  def pass_move
    puts "#{name} pass the move."
    self.passed_move = true
  end

  def take_card(card)
    puts "#{name} take a card."
    take_cards(card)
    self.took_card = true
  end

  def open_cards
    self.open_cards = true
  end

  def can_take_cards?
    @cards.size < 3
  end

  def can_open_cards?(command)
    command == 'o'
  end

end
