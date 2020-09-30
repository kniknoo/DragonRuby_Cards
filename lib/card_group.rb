# frozen_string_literal: true

# make an object to represent a column, a set of columns, a pile, and a stack
class CardGroup
  attr_accessor :x, :y, :h, :w, :cards

  def initialize(x, y, w, h)
    @mouse = $gtk.args.mouse
    @cards = []
    @x = x
    @y = y
    @w = w
    @h = h
    @border = Border.new(x: @x, y: @y, w: @w, h: @h, color: [255, 255, 255])
    @solid = Solid.new(x: @x, y: @y, w: @w, h: @h, color: [0, 255, 0])
  end

  def show
    $gtk.args.primitives << [@solid, @border]
  end

  def clicked?
    (@x..(@x + @w)).include?(@mouse.x) && (@y..(@y + @h)).include?(@mouse.y)
  end

  def show_card(x, y, card)
    backing = [x, y, @w, @h, 255, 255, 255]
    face = [x - 2, y + 47, card[:face], 12, 0, card[:color], 255, $deja_vu]
    $gtk.args.primitives << [backing.solid, face.label]
  end

  def show_back(x, y)
    backing = [x, y, @w, @h, 255, 255, 255]
    face = [x - 2, y + 47, '🂠', 12, 0, 0, 0, 0, 255, $deja_vu]
    $gtk.args.primitives << [backing.solid, face.label]
  end
end
class CardStack < CardGroup
  def show
    super
    show_card(@x, @y, @cards.last) if @cards.size.positive?
  end
end

class CardCascade < CardGroup
  def initialize(x, y, w, h, cards = [])
    super(x, y, w, h)
    @cards = cards
  end

  def show
    super
    show_column(@x, @y, @cards)
  end

  def clicked?
    (@x..(@x + @w)).include?(@mouse.x) &&
      ((@y - (@cards.size - 1) * 30)..(@y + @h)).include?(@mouse.y)
  end

  def show_column(x, y, cards)
    cards.each.with_index { |card, i| show_card(x, y - (30 * i), card) }
  end

  def card_position
    @cards.each.with_index do |_card, i|
      if ((@y - (@cards.size - 1) * 30 + i * 30)..((@y - (@cards.size - 1) * 30 + i * 30) + @h)).include?(@mouse.y)
        return i
      end
    end
  end
end

class CardPile < CardGroup
  attr_accessor :reserve

  def initialize(x, y, w, h)
    super(x, y, w, h)
    @reserve = []
    #@cards = []
  end

  def show
    super
    @reserve.size.times { |i| show_back(@x + i * 3, @y) }
    @cards.last(3).map.with_index { |card, ci| show_card(@x + 130 + 10 * ci, @y, card) }
  end

  def flip_three
    @cards += @reserve.slice!(0, 3)
  end

  def stock_clicked?
    (@x..(@x + (@reserve.size - 1) * 3 + @w)).include?(@mouse.x) &&
      (@y..(@y + @h)).include?(@mouse.y)
  end

  def shown_clicked?
    ((@x + 130 + (@cards.last(3).size - 1) * 10)..(@x + 130 + (@cards.last(3).size - 1) * 10 + @w)).include?(@mouse.x) &&
      (@y..(@y + @h)).include?(@mouse.y)
  end
end

class CardSpread
  attr_accessor :groups

  def initialize(x, y, type, number)
    @x = x
    @y = y
    @groups = number.times.map { |i, _e| type.new(@x + 50 * i, @y, 37, 50) }
  end

  def show
    @groups.each(&:show)
  end

  def each
    self.groups.each
  end
end
