struct SDL2::Renderer
  def initialize(window, index, flags)
    @renderer = LibSDL2.create_renderer(window, index, flags)
    SDL2.raise "Can't create SDL render" unless @renderer
  end

  def clear()
    LibSDL2.render_clear(self)
  end

  def present()
    LibSDL2.render_present(self)
  end

  def create_texture(surface)
    texture = LibSDL2.create_texture_from_surface(self, surface)
    SDL2.raise "Can't create texture" unless texture
    Texture.new texture
  end

  def copy(texture, src_rect = nil, dst_rect = nil)
    LibSDL2.render_copy self, texture,
      src_rect ? (src = src_rect.to_unsafe; pointerof(src)) : Pointer(LibSDL2::Rect).null,
      dst_rect ? (dst = dst_rect.to_unsafe; pointerof(dst)) : Pointer(LibSDL2::Rect).null
  end

  def to_unsafe
    @renderer
  end

  def destroy
    LibSDL2.destroy_renderer(@renderer)
  end
end
