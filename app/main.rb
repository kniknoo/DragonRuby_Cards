require 'lib/deck.rb'

$gtk.reset seed: srand


$deck = Deck.new#.make_deck(1)
$deck.shuffle!
$deja_vu = "fonts/DejaVuSans.ttf"
$card_columns = []
7.times { |i| $card_columns << $deck.slice!(0, i) }

def tick args
  # background
  args.outputs.solids << [0, 0, 1280, 720, 0, 0, 0]
  # suit piles (foundations)
  4.times do |i|
    args.outputs.borders <<  [675 + (50 * i), 550, 40, 60, 255, 255, 255]
  end
  # card_columns
  $card_columns.each_with_index do |j, i|
    show_column(args, 350 + (80 * i), 500 , j )
  end
  # stock pile
  $deck.size.times do |i|
    show_back(args, 435 + (i * 3), 610)
  end
  #helper pile
end

def show_card(args, x, y, card)
  backing = [x, y, 37, -50, 255, 255, 255]
  face = [x - 2, y - 3, card[:face] , 12, 0, card[:color], 255, $deja_vu ]
  args.outputs.primitives << [backing.solid, face.label]
end

def show_back(args, x, y)
  backing = [x, y, 37, -50, 255, 255, 255]
  face = [x - 2, y - 3, "🂠" , 12, 0, 0,0,0, 255, $deja_vu ]
  args.outputs.primitives << [backing.solid, face.label]
end

def show_column(args, x, y, cards)
  cards.each.with_index { |card, i| show_card(args, x, y - (30 * i), card) }
end
