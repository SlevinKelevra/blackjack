class Croupier
  WIN_SCORE = 21
  DEFAULT_VALUE = 10
  MIN_VALUE = 1
  MAX_VALUE = 11

  def initialize
    deck = Deck.new
    @cards = deck.deck
  end

  def deal_cards(count = 2)
    @cards.sample(count).each { |value| @cards.delete(value) }
  end

  def deal_one_card
    deal_cards(1)
  end

  def score(cards)
    total_score = 0
    ace_count = 0
    cards.each do |card|
      ace_count += MIN_VALUE if card.value == 'A'
      total_score += get_card_score(card)
    end
    add_additional_ace_score(total_score, ace_count)
  end

  protected

  def get_card_score(card)
    if %w(J Q K).include? card.value
      DEFAULT_VALUE
    elsif card.value == 'A'
      MIN_VALUE
    else
      card.value.to_i
    end
  end

  def add_additional_ace_score(total_score, ace_count)
    ace_count.times do
      ace_score = MAX_VALUE - MIN_VALUE
      total_score += ace_score if total_score + ace_score <= WIN_SCORE + 5
    end
    total_score
  end

  def win_score?(score)
    WIN_SCORE == score
  end

  def score_difference(score)
    (WIN_SCORE - score).abs
  end

end
