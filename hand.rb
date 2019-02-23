require_relative 'card'
require_relative 'deck'

class Hand

  attr_reader :cards
  attr_accessor :points

  BASIC_NUMBER_CARDS = 2
  MAX_NUMBER_CARDS = 3
  MAX_POINTS = 21

  def initialize
    @cards = []
    @points = 0
  end

  def add_card(deck)
    @cards << deck.take_card
    count_points
  end

  def clear_hand
    @cards = []
  end

  def count_points
    @points = 0
    @cards.each do |card| 
      @points += card.value + card.additional
      @points -= card.additional  if @points > 21
    end
  end

end
