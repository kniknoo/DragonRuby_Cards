require 'lib/deck.rb'
require 'lib/board.rb'
#$gtk.reset seed: Time.now.to_i

$board = Board.new args
$deja_vu = "fonts/DejaVuSans.ttf"


p $board.show_columns
sleep 1

def tick args
  # background
  args.outputs.solids << [0, 0, 1280, 720, 0, 0, 0]
  # suit piles (foundations)
  args.outputs.borders << $board.draw_stack_borders
  # card_columns
  args.outputs.primitives << $board.show_all_columns
  # stock pile
  #$deck.size.times { |i| show_back(args, 435 + (i * 3), 610) }
  #helper pile
  #3.times {|i| show_card(args, 555 + (i * 40), 610, $helper_cards[i - 3])}
end

#def show_card(args, x, y, card)
#  backing = [x, y, 37, -50, 255, 255, 255]
#  face = [x - 2, y - 3, card[:face] , 12, 0, card[:color], 255, $deja_vu ]
#  args.outputs.primitives << [backing.solid, face.label]
#end

#def show_back(args, x, y)
#  backing = [x, y, 37, -50, 255, 255, 255]
#  face = [x - 2, y - 3, "🂠" , 12, 0, 0,0,0, 255, $deja_vu ]
#  args.outputs.primitives << [backing.solid, face.label]
#end

#def show_column(args, x, y, cards)
#  cards.each.with_index { |card, i| show_card(args, x, y - (30 * i), card) }
#end
