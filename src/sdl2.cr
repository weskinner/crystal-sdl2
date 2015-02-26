require "./*"

module SDL2
  def self.run(flags = INIT::EVERYTHING)
    init flags
    begin
      yield
    ensure
      quit
    end
  end

  def self.init(flags = INIT::EVERYTHING)
    if LibSDL2.init(flags) != 0
      SDL2.raise "Can't initialize SDL"
    end
  end

  def self.load_bmp_from_file(filename)
    rw_ops = LibSDL2.rw_from_file(filename, "rb")
    SDL2.raise "Can't load bitmap from '#{filename}'" unless rw_ops

    bitmap = LibSDL2.load_bmp_rw(rw_ops, 1)
    SDL2.raise "Can't load bitmap from '#{filename}'" unless bitmap

    Surface.new bitmap
  end

  def self.show_cursor
    LibSDL2.show_cursor LibSDL2::ENABLE
  end

  def self.hide_cursor
    LibSDL2.show_cursor LibSDL2::DISABLE
  end

  def self.error
    String.new LibSDL2.get_error
  end

  def self.raise(msg)
    ::raise "#{msg}: #{error}"
  end

  def self.ticks
    LibSDL2.get_ticks
  end

  def self.quit
    LibSDL2.quit
  end

  def self.poll_events
    while LibSDL2.poll_event(out event) == 1
      yield event
    end
  end

  def self.delay(ms : UInt32)
    LibSDL2.delay(ms)
  end
end
