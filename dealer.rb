require_relative 'player'

class Dealer < Player

  MAX_DEALER_POINTS = 17

  def initialize(name = "Dealer")
    super
  end

  def can_take_card?
    points < MAX_DEALER_POINTS && cards.size < Hand::MAX_NUMBER_CARDS
  end

end
