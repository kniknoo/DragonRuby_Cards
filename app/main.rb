# frozen_string_literal: true

require 'lib/deck.rb'
require 'lib/dragon_object.rb'
require 'lib/card_group.rb'
require 'lib/player.rb'
require 'lib/board.rb'

$board = Board.new
$deja_vu = 'fonts/DejaVuSans.ttf'
$player = Player.new
def tick(args)
  args.outputs.solids << [0, 0, 1280, 720, 0, 0, 0]
  args.outputs.labels << [0, 360, 'Undo Pickup', 6, 0, [255, 255, 255]]
  args.outputs.labels << [1130, 360, 'Deal Again', 6, 0, [255, 255, 255]]
  args.outputs.labels << [640, 690, 'Play some Solitaire, ya person!', 6, 1, [255, 255, 255]]

  $board.show
  $player.display_hand
  return unless $player.clicks?

  $player.change_mind if args.inputs.mouse.x < 150
  new_deal if args.inputs.mouse.x > 1130

  if $player.hand.empty?
    $board.backup.reset_pile if $board.backup.reserve.empty? && $board.backup.stock_clicked?
    $board.backup.flip_three if $board.backup.stock_clicked?
  end

  $board.suits.groups.each do |stack|
    $player.put_on(stack) if stack.clicked? && valid_suit_card?(stack)
  end

  $board.columns.groups.each do |col|
    if col.clicked?
      if $player.hand.empty?
        $player.get(col, col.card_position + 1) if valid_pickup?(col, col.card_position)
      else
        $player.put_on(col) if column_accepts_card?(col)
      end
    end
  end

  unless $board.backup.cards.empty?
    $player.get($board.backup, 1) if $board.backup.shown_clicked?
  end

end

def valid_suit_card?(stack)
  return unless $player.hand.size == 1

  if stack.cards.empty?
    $player.hand.first[:value] == 1
  else
    $player.hand.first[:value] == stack.cards.last[:value] + 1 &&
      $player.hand.first[:suit] == stack.cards.last[:suit]
  end
end

def column_accepts_card?(column)
  if column.cards.empty?
    $player.hand.first[:value] == 13
  else
    $player.hand.first[:value] == column.cards.last[:value] - 1 &&
      $player.hand.first[:color] != column.cards.last[:color]
  end
end

def valid_pickup?(column, position)
  return true if position == 0

  column.cards[-position - 1..-1].each_cons(2) do |card_a, card_b|
    #card_a[:value] == card_b[:value] + 1

    return false unless card_a[:value] == card_b[:value] + 1
    return false if card_a[:color] == card_b[:color]
  end
  true
end

def new_deal
  $board = Board.new
  $player = Player.new
end
