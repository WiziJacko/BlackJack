require_relative 'card'
require_relative 'deck'
require_relative 'hand'
require_relative 'player'
require_relative 'dealer'

class Game

  DRAW = 0
  PLAYER_WON = 1
  DEALER_WON = 2

  def initialize(player, dealer, interface)
    @deck = Deck.new
    @bank = Bank.new
    @dealer = dealer
    @player = player
    @interface = interface
    @winners = []
  end

  def user_move
    user_choice = @interface.user_action
    case user_choice
    when Interface::SKIP then false
    when Interface::ADD_CARD then user_take_card
    when Interface::OPEN_CARDS then true
    else @interface.not_correct_input; user_move
    end
  end

  def dealer_move
    @dealer.take_card(@deck) if @dealer.can_take_card?
  end

  def user_take_card
    @player.take_card(@deck) if @player.can_take_card?
    @interface.show_cards(@player)
  end

  def pre_round
    @deck.shuffle_deck
    @player.new_round
    @dealer.new_round
    Hand::BASIC_NUMBER_CARDS.times { @player.take_card(@deck)}
    Hand::BASIC_NUMBER_CARDS.times { @dealer.take_card(@deck)}
    @player.bet(@bank)
    @dealer.bet(@bank)
  end

  def round
    @interface.show_cards(@player)
    loop do
      decision = user_move
      break if decision == true
      dealer_move
      break if @dealer.cards.size == Hand::MAX_NUMBER_CARDS && @player.cards.size == Hand::MAX_NUMBER_CARDS
    end
  end

  def game_result
    points_diff = @player.points - @dealer.points
    return DRAW if @dealer.points_over? && @player.points_over? 
    return DRAW if points_diff == 0
    return DEALER_WON if @player.points_over?
    return PLAYER_WON if @dealer.points_over?
    return PLAYER_WON if points_diff > 0
    return DEALER_WON if points_diff < 0
  end

  def calc_the_prize(result)
    @winners << @player if result == PLAYER_WON || result == DRAW
    @winners << @dealer if result == DEALER_WON || result == DRAW
    @bank.player_reward(@winners)
  end

  def run
    pre_round
    round
    result = game_result
    calc_the_prize(result)
    @interface.show_results(result)
    @interface.show_cards(@player)
    @interface.show_cards(@dealer)
    @interface.show_money(@player)
    @interface.show_money(@dealer)
  end

  def repeat_game?

    asnwer = @interface.play_further?(@player)
    case asnwer
    when 1 then true
    when 2 then false
    else @interface.not_correct_input; repeat_game?
    end
  end

end
