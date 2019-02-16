require_relative 'card'
require_relative 'hand'
require_relative 'player'
require_relative 'bank'
require_relative 'dealer'

class Main
  WELCOME_MENU = <<~WELCOME_WORDS
    ------------------------------------------------------------
    |                                                          |
    |               Привет, дорогой пользователь!              |
    |            Приветствую тебя в игре 'BlackJack'           |
    |                                                          |
    ------------------------------------------------------------
  WELCOME_WORDS

  PLAYER_NAME_MENU = <<~PLAYER_NAME
    ------------------------------------------------------------
    |            Для начала игры введите Ваше имя              |
    ------------------------------------------------------------
  PLAYER_NAME

  ACTIONS_MENU = <<~ACTIONS
    ------------------------------------------------------------
    |                     Выберите действие                    |
    |   Введите "1", если хотите Пропустить ход                |
    |   Введите "2", если хотите Добавить карту                |
    |   Введите "3", если хотите Открыть карты                 |
    ------------------------------------------------------------
  ACTIONS

  PLAY_FURTHER_MENU = <<~PLAY_FURTHER
    ------------------------------------------------------------
    |               Выхотите продолжить игру?                  |
    |   Введите "1", если хотите Да                            |
    |   Введите "2", если хотите Нет                           |
    ------------------------------------------------------------
  PLAY_FURTHER

  def initialize
  	@bank = Bank.new
    @players = []
    @winners = []
    @dealer = Dealer.new
    @players.push(@dealer)
  end

  def run
    puts WELCOME_MENU
    name_view
  end

  def name_view
    puts PLAYER_NAME_MENU
    name = gets.chomp.to_s.capitalize
    @player = Player.new(name)
    @players.push(@player)
    actions_view
  end

  def actions_view
    @dealer.bet(@bank)
    @player.bet(@bank)
    puts "#{@player.name}, начинаем игру!"
    puts "Вам розданы карты: "
    all_cards(@player)
    loop do
      puts ACTIONS_MENU
      answer = gets.to_i
      case answer
      when 1 then skip_view
      when 2 then add_card_view
      when 3 then open_cards_view
      else not_correct_input
      end
    end
  end

  def all_cards_view
  	puts " --------- "
    puts "Ваши карты:"
    all_cards(@player)
    puts " --------- "
    puts "Карты дилера:"
    all_cards(@dealer)
    puts " --------- "
  end

  def open_cards_view
    define_winner_view
  end

  def skip_view
  	dealer_turn_view
  end

  def dealer_turn_view
    @dealer.take_card
    define_winner_view if check_cards
  end 

  def add_card_view
    @player.take_card
    puts "Выдана карта #{@player.cards[-1].shirt}"
    puts "Количество очков вашей руки: #{@player.points}"
    define_winner_view if check_cards || @player.points_over?
    dealer_turn_view
  end

  def check_cards
    @dealer.cards.count == 3 && @player.cards.count == 3
  end

  def define_winner_view
  	all_cards_view
  	if @player.points_over?
  	  looser_view
  	elsif @dealer.points_over?
  	  winner_view
  	else
      points_diff = @player.points - @dealer.points
      draw_view if points_diff == 0
  	  looser_view if points_diff < 0
      winner_view if points_diff > 0
    end
  	@bank.player_reward(@winners)
  	play_further_decision
  end

  def looser_view
    puts "Вы проиграли."
    @winners.push(@dealer)
  end

  def winner_view
    puts "Вы выграли"
    @winners.push(@player)
  end

  def draw_view
    puts "Ничья!"
    @winners.push(@player)
    @winners.push(@dealer)
  end

  def play_further_decision
  	puts "У вас осталось денег: #{@player.money}"
  	end_game if @player.money == 0 || @dealer.money == 0
  	loop do
      puts PLAY_FURTHER_MENU
      answer = gets.to_i
      case answer
      when 1 then next_round
      when 2 then end_game
      else not_correct_input
      end
    end
  end

  def next_round
  	@winners = []
  	@player.clear_points
  	@dealer.clear_points
  	Card.clear_instances
  	@dealer.hand.initial_cards
  	@player.hand.initial_cards
    actions_view
  end

  def end_game
    puts "Спасибо за игру!"
    exit
  end

  def not_correct_input
    puts "!! Некорректный ввод !!"
  end

  def enough_cards
    puts "Больше нельзя взять карт!"
  end

  def all_cards(player)
    player.cards.each do |card|
      puts "Карта '#{card.shirt}'."
    end
    puts "Количество очков: #{player.points}"
  end

end