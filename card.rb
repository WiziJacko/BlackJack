class Card

  attr_reader :value, :suit, :rank, :additional
  
  SUITS = %w[♠ ♥ ♣ ♦].freeze
  RANKS = %w[A 2 3 4 5 6 7 8 9 10 J Q K].freeze

  def initialize(args)
    @suit = args[:suit]
    @rank = args[:rank]
    @value = args[:value]
    @additional = args[:additional]
  end

  def card_info
    return @rank + @suit
  end

end
