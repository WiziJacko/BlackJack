class Bank

  attr_reader :amount

  def initialize
    reset_bank
  end

  def place_bet(bet)
    @amount += bet
  end 

  def player_reward(winners) 
    prize = @amount / winners.count
    winners.each do |winner|
      winner.add_money(prize)
    end
    reset_bank
  end

  protected

  def reset_bank
    @amount = 0
  end

end