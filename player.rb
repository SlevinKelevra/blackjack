class Player < User

  def process_move(command, croupier)
    if can_pass?(command)
      pass_move
    elsif can_take_card?(command)
      take_card(croupier.deal_one_card)
    elsif can_open_cards?(command)
      open_cards
    end
  end

  protected

  def can_pass?(command)
    command == 'p' && !@passed_move
  end

  def can_take_card?(command)
    command == 't' && !@took_card
  end

end
