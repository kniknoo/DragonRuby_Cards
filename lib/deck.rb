
class Deck < Array
  SUITS = [{ suit: '♠', color: [0,0,0] }, { suit: '♣', color: [0,0,0] },
           { suit: '♥', color: [255,0,0] },   { suit: '♦', color: [255,0,0] }].to_enum

  SOL_VALUES = [{ name: 'A', value: 1 },   { name: '2',  value: 2 },
                { name: '3',  value: 3 },  { name: '4',  value: 4 },
                { name: '5',  value: 5 },  { name: '6',  value: 6 },
                { name: '7',  value: 7 },  { name: '8',  value: 8 },
                { name: '9',  value: 9 },  { name: '10', value: 10 },
                { name: 'J',  value: 11 }, { name: 'Q',  value: 12 },
                { name: 'K',  value: 13 }].freeze

  FACES = '🂡 🂢 🂣 🂤 🂥 🂦 🂧 🂨 🂩 🂪 🂫 🂭 🂮 🃑 🃒 🃓 🃔 🃕 🃖 🃗 🃘 🃙 🃚 🃛 🃝 🃞
  🂱 🂲 🂳 🂴 🂵 🂶 🂷 🂸 🂹 🂺 🂻 🂽 🂾 🃁 🃂 🃃 🃄 🃅 🃆 🃇 🃈 🃉 🃊 🃋 🃍 🃎'.split(' ')

  def initialize
    #super
    make_deck
  end

  def make_deck(deck_count = 1)
    x = -1
    SUITS.cycle(deck_count).flat_map do |s|
      SOL_VALUES.map.with_index(0) do |v, i|
        x += 1
        v[:face] = FACES[x]#.next
        self[x] = v.merge(s)

      end
    end
  end
end
# 🂠
