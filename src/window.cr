struct SDL2::Window
  POS_UNDEFINED = 0x1FFF0000

  def initialize(title, x, y, width, height, flags : Flags)
    @window = LibSDL2.create_window(title, x, y, width, height, flags)
    SDL2.raise "Can't create SDL window" unless @window
  end

  def create_renderer(index = -1, flags = Renderer::Flags::None)
    Renderer.new self, index, flags
  end

  def get_surface
    surface = LibSDL2.get_window_surface(self)
    SDL2.raise "Can't get surface" unless surface
    surface
  end

  def update_surface
    value = LibSDL2.update_window_surface(self)
    SDL2.raise "Can't update window surface" unless value == 0
    value
  end

  def to_unsafe
    @window
  end
end
