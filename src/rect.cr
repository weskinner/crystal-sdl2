struct SDL2::Rect
  property x, y, w, h

  def initialize(@x = 0 : Int, @y = 0, @w = 0, @h = 0)
  end

  def self.new(rect : LibSDL2::Rect)
    new rect.x, rect.y, rect.w, rect.h
  end

  def to_unsafe
    LibSDL2::Rect.new x: x, y: y, w: w, h: h
  end
end
