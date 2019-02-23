require_relative 'card'
require_relative 'hand'
require_relative 'player'
require_relative 'bank'
require_relative 'dealer'
require_relative 'interface'
require_relative 'game'

class Main
  
  def initialize
    @interface = Interface.new
  end

  def run
    @interface.start
    name = @interface.user_info
    @player = Player.new(name)
    @dealer = Dealer.new

    loop do
      game = Game.new(@player, @dealer, @interface)
      game.run
      break if !@player.enough_money? || !@dealer.enough_money?
      break if !game.repeat_game?
    end

  end
end

m = Main.new
m.run
