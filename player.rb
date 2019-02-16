require_relative 'hand'
require_relative 'card'

class Player

  attr_accessor :name
  attr_reader :money, :hand

  BASIC_AMOUNT = 100
  BASIC_BET = 10
  NOT_ENOUGH_MONEY = 'Недостаточно денег'

  def initialize(name, money = BASIC_AMOUNT)
    @name = name
    @money = money
    @hand = Hand.new
  end

  def take_card
  	return if @hand.cards.size > Hand::BASIC_NUMBER_CARDS
    @hand.add_card
  end

  def add_money(value)
    @money += value
  end

  def new_round
    @hand.clear_hand
  end

  def cards
    @hand.cards
  end

  def points_over?
    @hand.points > Hand::MAX_POINTS
  end

  def points
    @hand.points
  end

  def clear_points
    @hand.points = 0
  end

  def bet(value = BASIC_BET, bank)
    return NOT_ENOUGH_MONEY if money - value < 0
    @money -= value
    bank.place_bet(value)
  end
end