require_relative 'card'

class Deck

  attr_reader :deck

  def initialize
    deck_initiation
  end

  def deck_initiation
    @deck = []
    Card::SUITS.each do |suit|
      value = 0
      additional = 10
      counter = 1
      Card::RANKS.each do |rank|
        value = counter if counter < 11
        additional = 0 if counter > 1
        value += additional
        @deck << Card.new(suit: suit, rank: rank, value: value, additional: additional)
        counter += 1
      end
    end
  end

  def shuffle_deck
    @deck.shuffle!.shuffle!
  end

  def take_card
    @deck.shift
  end

end
