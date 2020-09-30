# frozen_string_literal: true

class Board
  attr_accessor :backup, :suits, :columns

  def initialize
    @deck = Deck.new
    @card = { w: 37, h: 50 }
    @bu = { x: 335, y: 550 }
    @co = { x: 350, y2: 500 }
    @columns = CardSpread.new(@co[:x], 400, CardCascade, 7)
    @st = { x: 675, y: 550, w: 40, h: 60 }
    @backup = CardPile.new(@bu[:x], @bu[:y], @card[:w], @card[:h])
    @suits = CardSpread.new(@st[:x], @st[:y], CardStack, 4)
    deal
  end

  def deal
    @deck.shuffle!
    @columns.each.with_index { |e, i| e.cards = @deck.slice!(0, i + 1) }
    @backup.reserve = @deck.slice!(0, @deck.size)
  end

  def show
    @suits.show
    @columns.show
    @backup.show
  end
end
