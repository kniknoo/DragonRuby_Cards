# frozen_string_literal: true

class DragonObject
  attr_accessor :x, :y, :r, :g, :b, :a, :primitive_marker

  def initialize(x:, y:, color:)
    @x = x
    @y = y
    @r, @g, @b = color
    @a = color[3] || 255
  end
end

class Label < DragonObject
  attr_accessor :text, :size_enum, :alignment_enum, :font

  def initialize(x: 0, y: 50, color: [0, 0, 0, 255], text: 'Hello',
                 font_size: 12, font_align: 0, font: nil)
    super(x: x, y: y, color: color)
    @text = text
    @size_enum = font_size
    @alignment_enum = font_align
    @font = font
    @primitive_marker = :label
  end

  def identify
    [@x, @y, @text, @size_enum, @alignment_enum, @r, @g, @b, @a, @font, @primitive_marker]
  end
end

class Border < DragonObject
  attr_accessor :w, :h

  def initialize(x: 0, y: 0, w: 100, h: 100, color: [0, 0, 0, 255])
    super(x: x, y: y, color: color)
    @w = w
    @h = h
    @primitive_marker = :border
  end
  def identify
    [@x, @y, @w, @h, @r, @g, @b, @a, @primitive_marker]
  end
end

class Solid < Border
  def initialize(x: 0, y: 0, w: 100, h: 100, color: [0, 0, 0, 255])
    super(x: x, y: y, w: w, h: h, color: color)
    @primitive_marker = :solid
  end
end

class Line < DragonObject
  attr_accessor :x2, :y2

  def initialize(x: 0, y: 0, x2: 100, y2: 100, color: [0, 0, 0, 255])
    super(x: x, y: y, color: color)
    @x2 = x2
    @y2 = y2
    @primitive_marker = :line
  end
  def identify
    [@x, @y, @x2, @y2, @r, @g, @b, @a, @primitive_marker]
  end
end

class Sprite < Border
  attr_accessor :path, :angle, :source_x, :source_y, :source_w, :source_h,
                :tile_x, :tile_y, :tile_w, :tile_h, :flip_horizontally,
                :flip_vertically, :angle_anchor_x, :angle_anchor_y

  def initialize(x: 0, y: 0, w: 100, h: 100, path: '', color: [0, 0, 0, 255])
    super(x: x, y: y, w: w, h: h, color: color)
    @path = path
    @primitive_marker = :sprite
    @source_w = w
    @source_h = h
    @source_x = 0
    @source_y = 0
    @flip_vertically = false
    @flip_horizontally = false
    @tile_h = w
    @tile_y = h
    @tile_x = 0
    @tile_y = 0
    @angle_anchor_x = 0
    @angle_anchor_y = 0
  end
  def identify
    [@x, @y, @w, @h, @path, @angle, @a]
  end
end
