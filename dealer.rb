class Dealer < User

  def initialize(name = 'Dealer')
    super(name)
  end

  def process_move(croupier)
    think
    if can_pass?(croupier.score(@cards))
      pass_move
    elsif can_take_card?
      take_card(croupier.deal_one_card)
    else
      open_cards
    end
  end

  protected

  def think
    sleep(2)
  end

  def can_pass?(score)
    score >= 18 && !@passed_move
  end

  def can_take_card?
    !@took_card
  end

end
