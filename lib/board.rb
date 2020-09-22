#require 'lib/deck.rb'

class Board
  #Don't handle background, handle the layout coordinates of the current game
  #handle displaying cards at their correct coordinates
  #in the test klondike, the board includes the 4 borders for the suit stacks,
  # 7 arrays populated in ascending order to form the columns, the backup pile,
  # and the top 3 helper cards. The board is responsible for making arrays for
  # each of these pieces to push to DR
  attr_gtk
  attr_accessor :args, :state, :inputs, :outputs, :grid
  attr_accessor :deck, :show_columns
  def initialize args
    @args = args
    @deck = Deck.new
    @card_columns = []
    @helper_cards = []
    @show_columns = []
    deal
  end

  def deal
    @deck.shuffle!
    7.times { |i| @card_columns << @deck.slice!(0, i) }
    @helper_cards = @deck.slice!(0, 3)
    show_all_columns
  end

  def draw_stack_borders
    4.times.map do |i|
      [675 + (50 * i), 550, 40, 60, 255, 255, 255]
    end
  end
  def show_back(x, y)
    backing = [x, y, 37, -50, 255, 255, 255]
    face = [x - 2, y - 3, "🂠" , 12, 0, 0,0,0, 255, $deja_vu ]
    [backing.solid, face.label]
  end
  def show_card( x, y, card)
    backing = [x, y, 37, -50, 255, 255, 255]
    face = [x - 2, y - 3, card[:face] , 12, 0, card[:color], 255, $deja_vu ]
    @args.outputs.primitives << [backing.solid, face.label]
  end
  def show_column(x, y, cards)
    cards.each.with_index { |card, i| show_card( x, y - (30 * i), card) }
  end
  def show_all_columns
    @card_columns.each_with_index do |col, i|
      show_column(350 + (80 * i), 500 , col )
    end
  end
end
