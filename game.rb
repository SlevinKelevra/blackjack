require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'dealer'

@@bank_game = 0
RATE = 10

def create_player
  puts "Enter your name"
  name = gets.chomp
  player = Player.new(name)
end

def create_dealer
  dealer = Dealer.new
end

def bet(bank)
  bank -= RATE
  @@bank_game += RATE
end
