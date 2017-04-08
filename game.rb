require_relative 'player'
require_relative 'game'
require_relative 'deck'
require_relative 'card'
require_relative 'dealer'
require_relative 'croupier'
require_relative 'user'

class Game

  def initialize
    puts 'Please enter your name.'
    name = gets.chomp
    @player = Player.new(name)
    puts "Hey, #{@player.name}"
    @dealer = Dealer.new
  end

  def menu(code)
    if code == 'n'
      start_game
    elsif code == 'q'
      exit_game
    else
      puts "Sorry, I don't understand."
    end
  end

  def start_game
    @bank = 0
    @game_over = false
    @croupier = Croupier.new
    make_bets
    deal_cards
    play_game
    open_cards
  end

  def make_bets
    self.bank += @player.make_bet
    self.bank += @dealer.make_bet
  end

  def deal_cards
    @player.take_cards(@croupier.deal_cards)
    @dealer.take_cards(@croupier.deal_cards)
  end

  def play_game
    until @game_over
      player_move
      break if @game_over || players_cards_limit_reached?
      dealer_move
      stop_game if players_cards_limit_reached?
    end
  end

  def player_move
    show_info
    @player.process_move(command(@player), @croupier)
    self.game_over = @player.open_cards
  end

  def dealer_move
    show_info
    @dealer.process_move(@croupier)
    self.game_over = @dealer.open_cards
  end

  def open_cards
    self.game_over = true
    confirm_open_cards
    show_info
    determine_winner
    clear_bank
    show_balances
    exit_game if players_cannot_play?
    show_base_commands
  end

  def show_balances
    @player.show_balance
    @dealer.show_balance
    puts
  end

  def show_info
    @dealer.show_cards_back unless @game_over
    @dealer.show_cards_face if @game_over
    @player.show_cards_face

    show_score(@dealer.name, @croupier.score(@dealer.cards)) if @game_over
     how_score(@player.name, @croupier.score(@player.cards))

    show_bank(@bank)
  end

  def stop_game
    show_info
    self.game_over = true
  end

  def determine_winner
    player_score = @croupier.score(@player.cards)
    dealer_score = @croupier.score(@dealer.cards)
    if @croupier.drawn?(player_score, dealer_score)
      players_take_money(@bank / 2.0)
    elsif @croupier.player_win?(player_score, dealer_score)
      @player.win(@bank)
    else
      @dealer.win(@bank)
    end
  end

  def players_take_money(summa)
    @dealer.take_money(summa)
    @player.take_money(summa)
  end

  def clear_bank
    self.bank = 0
  end

  def players_cards_limit_reached?
    @player.cards_limit_reached? && @dealer.cards_limit_reached?
  end

  def players_cannot_play?
    @player.balance == 0 || @dealer.balance == 0
  end
end
