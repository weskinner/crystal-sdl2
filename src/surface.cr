struct SDL2::Surface
  def initialize(@surface)
  end

  def w
    @surface.value.w
  end

  def h
    @surface.value.h
  end

  def rect
    Rect.new 0, 0, w, h
  end

  def lock
    LibSDL2.lock_surface self
  end

  def unlock
    LibSDL2.unlock_surface self
  end

  def update_rect(x, y, w, h)
    LibSDL2.update_rect self, x, y, w, h
  end

  def flip
    LibSDL2.flip self
  end

  def []=(offset, color)
    (@surface.value.pixels.as(UInt32*))[offset] = color.to_u32
  end

  def []=(x, y, color)
    self[y.to_i32 * @width + x.to_i32] = color
  end

  def offset(x, y)
    x.to_i32 + (y.to_i32 * @width)
  end

  def free
    LibSDL2.free_surface self
  end

  def to_unsafe
    @surface
  end
end
