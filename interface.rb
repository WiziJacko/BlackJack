class Interface
  
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

  GAME_ENDED_MENU = <<~GAME_ENDED
    ------------------------------------------------------------
    |                                                          |
    |                      Игра окончена!                      |
    |                     Спасибо за игру                      |
    |                                                          |
    ------------------------------------------------------------
  GAME_ENDED

  RESULTS = ["Ничья!", "Вы выграли!", "Вы програли!"]

  SKIP = 1
  ADD_CARD = 2
  OPEN_CARDS = 3


  def start
    puts WELCOME_MENU
  end

  def user_info
    puts PLAYER_NAME_MENU
    gets.chomp.to_s.capitalize!
  end

  def show_cards(player)
    puts "Игрок: #{player.name}. Количество очков: #{player.points}"
    player.hand.cards.each { |card| puts " Карта: #{card.card_info}" }
  end

  def user_action
    puts ACTIONS_MENU
    gets.to_i
  end

  def show_results(result)
    puts "-" * 10
    puts RESULTS[result]
    puts "-" * 10
  end

  def show_money(player)
    puts "-" * 30
    puts "Количества денег у '#{player.name}' -- #{player.money}"
    puts "-" * 30
  end

  def play_further?(player)
    puts PLAY_FURTHER_MENU
    gets.to_i
  end

  def game_ended
    puts GAME_ENDED_MENU
  end

  def not_correct_input
    puts "!!! Некорректный ввод !!!"
  end

end
