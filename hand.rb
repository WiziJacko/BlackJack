require_relative 'card'

class Hand

  attr_reader :cards
  attr_accessor :points

  BASIC_NUMBER_CARDS = 2
  MAX_POINTS = 21

  def initialize
  	@cards = []
  	@points = 0
    initial_cards
  end

  def initial_cards
  	clear_hand
    BASIC_NUMBER_CARDS.times do 
      add_card
    end
  end

  def add_card
    @cards.push(Card.new)
    count_points(cards[-1])
    @cards.last
  rescue RuntimeError
    retry
  end

  def clear_hand
    @cards = []
  end

  def count_points(card)
    @points += card.card_value
    @points += Card::ACE_DIFF if @points <= 11 && card.value == 'T'
  end

end