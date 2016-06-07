@[Link("SDL2")]
lib LibSDL2
  SWSURFACE = 0x00000000_u32
  HWSURFACE = 0x00000001_u32
  ASYNCBLIT = 0x00000004_u32

  ANYFORMAT  = 0x10000000_u32
  HWPALETTE  = 0x20000000_u32
  DOUBLEBUF  = 0x40000000_u32
  FULLSCREEN = 0x80000000_u32
  OPENGL     = 0x00000002_u32
  OPENGLBLIT = 0x0000000A_u32
  RESIZABLE  = 0x00000010_u32
  NOFRAME    = 0x00000020_u32

  HWACCEL     = 0x00000100_u32
  SRCCOLORKEY = 0x00001000_u32
  RLEACCELOK  = 0x00002000_u32
  RLEACCEL    = 0x00004000_u32
  SRCALPHA    = 0x00010000_u32
  PREALLOC    = 0x01000000_u32

  WINDOW_SHOWN      = 0x00000004_u32
  WINDOW_RESIZABLE  = 0x00000020_u32

  WINDOWPOS_UNDEFINED = 0x1FFF0000
  WINDOWPOS_CENTERED = 0x2FFF0000

  DISABLE = 0
  ENABLE = 1

  enum BlendMode
    NONE = 0x00000000
    BLEND = 0x00000001
    ADD = 0x00000002
    MOD = 0x00000004
  end

  enum TextureAccess
    STATIC
    STREAMING
    TARGET
  end

  struct Color
    r, g, b, unused : UInt8
  end

  struct Rect
    x, y : Int32
    w, h : Int32
  end

  struct Palette
    ncolors : Int32
    color : Color
  end

  enum PixelFormatEnum
  #TODO
  end

  struct PixelFormat
    format : PixelFormatEnum
    palette : Palette
    bits_per_pixel, bytes_per_pixel : UInt8
    r_mask, g_mask, b_mask, a_mask : UInt32
  end

  struct Surface
    flags : UInt32
    format : PixelFormat*
    w, h : Int32
    pitch : UInt16
    pixels : Void*
    #TODO
  end

  struct Window
    id : UInt32
    title : Char*
    icon : Surface*
    x, y, w, h : Int32
    min_w, min_h, max_w, max_h : Int32
    flags : UInt32
    #TODO
  end

  struct Renderer
    window : Window*
    #TODO
  end

  alias Texture = Void*

  enum Key
    ESCAPE = 27
    A = 97
    B = 98
    C = 99
    D = 100
    E = 101
    F = 102
    G = 103
    H = 104
    I = 105
    J = 106
    K = 107
    L = 108
    M = 109
    N = 110
    O = 111
    P = 112
    Q = 113
    R = 114
    S = 115
    T = 116
    U = 117
    V = 118
    W = 119
    X = 120
    Y = 121
    Z = 122
    UP = 273
    DOWN = 274
    RIGHT = 275
    LEFT = 276
    SPACE = 205
  end

  struct KeySym
    scan_code : SDL2::Scancode
    sym : Key # SDL_Keycode
    #TODO
  end

  struct KeyboardEvent
    type : SDL2::EventType
    timestamp : UInt32
    window_id : UInt32
    state : UInt8
    repeat : UInt8
    padding : UInt8[2]
    key_sym : KeySym
  end

  struct UserEvent
    type : SDL2::EventType
    timestamp : UInt32
    windowID : UInt32
    code : Int32
    data1 : Void*
    data2 : Void*
  end

  union Event
    type : SDL2::EventType
    key : KeyboardEvent
    user : UserEvent
    padding : UInt8[56]
  end

  alias RWops = Void*

  alias Point = Void*

  type TimerCallback = (UInt32, Void*) -> UInt32

  fun init = SDL_Init(flags : SDL2::INIT) : Int32
  fun init_sub_system = SDL_InitSubSystem(flags : SDL2::INIT)
  fun quit_sub_system = SDL_QuitSubSystem(flags : SDL2::INIT)
  fun was_init = SDL_WasInit(flags : SDL2::INIT) : SDL2::INIT
  fun get_error = SDL_GetError() : UInt8*
  fun quit = SDL_Quit() : Void
  # fun set_video_mode = SDL_SetVideoMode(width : Int32, height : Int32, bpp : Int32, flags : UInt32) : Surface*
  # fun load_bmp = SDL_LoadBMP(file : UInt8*) : Surface*
  fun create_window = SDL_CreateWindow(title : UInt8*, x : Int32, y : Int32, width : Int32, height : Int32, flags : SDL2::Window::Flags) : Window*
  fun destroy_window = SDL_DestroyWindow(Window*) : Void
  fun set_window_position = SDL_SetWindowPosition(window : Window*, x : Int32, y : Int32) : Void
  fun get_window_position = SDL_GetWindowPosition(window : Window*, x : Int32*, y : Int32*) : Void
  fun set_window_size = SDL_SetWindowSize(window : Window*, w : Int32, h : Int32) : Void
  fun get_window_size = SDL_GetWindowSize(window : Window*, w : Int32*, h : Int32*) : Void
  fun delay = SDL_Delay(ms : UInt32) : Void
  fun poll_event = SDL_PollEvent(event : Event*) : Int32
  fun wait_event = SDL_WaitEvent(event : Event*) : Int32
  fun push_event = SDL_PushEvent(event : Event*) : Int32

  fun get_window_surface = SDL_GetWindowSurface(window : Window*) : Surface*
  fun lock_surface = SDL_LockSurface(surface : Surface*) : Int32
  fun unlock_surface = SDL_UnlockSurface(surface : Surface*) : Void
  fun update_window_surface = SDL_UpdateWindowSurface(window : Window*) : Int32

  fun update_rect = SDL_UpdateRect(screen : Surface*, x : Int32, y : Int32, w : Int32, h : Int32) : Void
  fun fill_rect = SDL_FillRect(surface : Surface*, rect : Rect*, c : UInt32) : Int32

  fun show_cursor = SDL_ShowCursor(toggle : Int32) : Int32
  fun get_ticks = SDL_GetTicks : UInt32
  fun flip = SDL_Flip(screen : Surface*) : Int32

  fun create_renderer = SDL_CreateRenderer(window : Window*, index : Int32, flags : SDL2::Renderer::Flags) : Renderer*
  fun destroy_renderer = SDL_DestroyRenderer(renderer : Renderer*) : Void
  fun render_clear = SDL_RenderClear(renderer : Renderer*) : Int32
  fun render_present = SDL_RenderPresent(renderer : Renderer*) : Int32
  fun render_copy = SDL_RenderCopy(renderer : Renderer*, texture : Texture*, srcrect : Rect*, dstrect : Rect*) : Int16
  fun render_copy_ex = SDL_RenderCopyEx(renderer : Renderer*, texture : Texture*, srcrect : Rect*, dstrect : Rect*, angle : Float64, center : Point*, flip : SDL2::RenderFlip) : Int32
  fun render_draw_point = SDL_RenderDrawPoint(renderer : Renderer*, x : Int32, y : Int32) : Int32
  fun render_draw_points = SDL_RenderDrawPoints(renderer : Renderer*, points : Point*, count : Int32) : Int32
  fun render_draw_line = SDL_RenderDrawLine(renderer : Renderer*, x1 : Int32, y1 : Int32, x2 : Int32, y2 : Int32) : Int32
  fun render_draw_lines = SDL_RenderDrawLines(renderer : Renderer*, points : Point*, count : Int32) : Int32
  fun render_draw_rect = SDL_RenderDrawRect(renderer : Renderer*, rect : Rect*) : Int32
  fun render_draw_rects = SDL_RenderDrawRects(renderer : Renderer*, rects : Rect*, count : Int32) : Int32
  fun render_fill_rect = SDL_RenderFillRect(renderer : Renderer*, rect : Rect*) : Int32
  fun render_fill_rects = SDL_RenderFillRects(renderer : Renderer*, rects : Rect*, count : Int32) : Int32
  fun render_set_scale = SDL_RenderSetScale(renderer : Renderer*, scale_x : Float32, scale_y : Float32) : Int32
  fun render_get_scale = SDL_RenderGetScale(renderer : Renderer*, scale_x : Float32*, scale_y : Float32*) : Void
  fun set_render_draw_blend_mode = SDL_SetRenderDrawBlendMode(renderer : Renderer*, mode : BlendMode) : Int32
  fun set_render_target = SDL_SetRenderTarget(renderer : Renderer*, texture : Texture*) : Int32
  fun set_render_draw_color = SDL_SetRenderDrawColor(renderer : Renderer*, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int32

  fun create_texture_from_surface = SDL_CreateTextureFromSurface(renderer : Renderer*, surface : Surface*) : Texture*
  fun create_texture = SDL_CreateTexture(renderer : Renderer*, format : UInt32, access : TextureAccess, w : Int32, h : Int32) : Texture*
  fun destroy_texture = SDL_DestroyTexture(texture : Texture*) : Void
  fun set_texture_color_mod = SDL_SetTextureColorMod(texture : Texture*, r : UInt8, g : UInt8, b : UInt8) : Int32
  fun set_texture_alpha_mod = SDL_SetTextureAlphaMod(texture : Texture*, alpha : UInt8) : Int32

  fun rw_from_file = SDL_RWFromFile(str1 : UInt8*, str2 : UInt8*) : RWops*
  fun load_bmp_rw = SDL_LoadBMP_RW(rw_ops : RWops*, int : Int32) : Surface*

  fun map_rgb = SDL_MapRGB(format : PixelFormat*, r : UInt8, g : UInt8, b : UInt8) : UInt32

  fun blit_surface = SDL_UpperBlit(src : Surface*, src_rect : Rect*, dst : Surface*, dst_rect : Rect*) : Int32
  fun free_surface = SDL_FreeSurface(surface : Surface*) : Void
  fun set_color_key = SDL_SetColorKey(surface : Surface*, flag : Int32, key : UInt32) : Int32
  fun get_color_key = SDL_GetColorKey(surface : Surface*, key : UInt32*) : Int32

  fun add_timer = SDL_AddTimer(interval : UInt32, callback : TimerCallback, param : Void*) : Int32
  fun remove_timer = SDL_RemoveTimer(id : Int32) : Int32
end
