class Card

  @@instances = {}

  attr_reader :value, :suit, :card_value, :shirt
  
  CARD_DEALED = "Карта уже роздана".freeze
  CARD_SUITS = %w[+ <3 ^ <>]
  CARD_VALUES = %w[T 2 3 4 5 6 7 8 9 10 T K D B]
  ACE_DIFF = 10

  VALUES = {
    "1" => 1,
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9,
    "10" => 10,
    "T" => 1,
    "K" => 10,
    "D" => 10,
    "B" => 10
  }

  class << self
    def find(shirt)
      @@instances[shirt]
    end

    def all_cards
      @@instances.values
    end

    def clear_instances
      @@instances = {}
    end
  end

  def initialize
    @value = CARD_VALUES[rand(CARD_VALUES.size)]
    @suit = CARD_SUITS[rand(CARD_SUITS.size)]
    @shirt = @value + @suit
    validate!
    @@instances[@shirt] = self
    @card_value = VALUES[@value]
  end

  def card_info
    return @value + @suit
  end

  protected

  def validate!
    raise CARD_DEALED if Card.find(@shirt)
  end

end