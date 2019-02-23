class Card

  attr_reader :value, :suit, :card_value, :additional
  
  CARD_SUITS = %w[♠ ♥ ♣ ♦].freeze
  CARD_VALUES = %w[A 2 3 4 5 6 7 8 9 10 J Q K].freeze

  def initialize(args)
    @suit = args[:suit]
    @card_value = args[:card_value]
    @value = args[:value]
    @additional = args[:additional]
  end

  def card_info
    return @card_value + @suit
  end

end
