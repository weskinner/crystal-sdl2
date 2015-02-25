struct SDL2::Texture
  def initialize(@texture)
  end

  def to_unsafe
    @texture
  end
end
