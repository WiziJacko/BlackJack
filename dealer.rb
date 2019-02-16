require_relative 'player'

class Dealer < Player

  def initialize(name = "Dealer")
    super
  end

  def take_card
    return if self.hand.points >= 17
    super
  end

end