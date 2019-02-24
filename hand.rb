require_relative 'card'
require_relative 'deck'

class Hand

  attr_reader :cards, :points

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

  def reset
    @cards = []
    @points = 0
  end

  private

  def count_points
    points = cards.map(&:value).sum
    points = ace_correction(points)
    @points = points
  end

  def ace_correction(points)
    @cards.each do |card|
      points -= card.additional if card.ace? && points > MAX_POINTS
    end
    points
  end

end
