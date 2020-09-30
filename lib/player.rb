# frozen_string_literal: true

class Player
  attr_accessor :hand

  def initialize
    @mouse = $gtk.args.mouse
    @hand = []
    @taken_from = []
  end

  def get(location, number)
    return unless @hand.empty?

    @taken_from = location
    @hand = location.cards.slice!(-number, number)
  end

  def put_on(location)
    return if @hand.empty?

    location.cards += @hand.slice!(0, @hand.size)
  end

  def show_card(x, y, card)
    backing = [x, y, 37, 50, 255, 255, 255]
    face = [x - 2, y + 47, card[:face], 12, 0, card[:color], 255, $deja_vu]
    $gtk.args.primitives << [backing.solid, face.label]
  end

  def show_column(x, y, cards)
    cards.each.with_index { |card, i| show_card(x, y - (30 * i), card) }
  end

  def clicks?
    $gtk.args.inputs.mouse.click
  end

  def display_hand
    show_column(@mouse.x - 25, @mouse.y - 35, @hand) unless @hand.empty?
  end

  def change_mind
    @taken_from.cards += @hand.slice!(0, @hand.size)
  end
end
