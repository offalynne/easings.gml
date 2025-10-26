function sc_test()
{
    // config
    var _animation_interval = 5; // in seconds

    // init
    static __x = 0;
    static __sign = 1;
    static __about_seen = false;
    
    static _eases = 
    [ 
        EASE.LINEAR, EASE.SMOOTHSTEP, EASE.SMOOTHERSTEP, EASE.SMOOTHESTSTEP, 
        
        EASE.IN_QUAD,   EASE.IN_CUBIC, EASE.IN_QUART,  EASE.IN_QUINT,  
        EASE.IN_CIRC,   EASE.IN_SINE,  EASE.IN_EXPO, 
        EASE.IN_BOUNCE, EASE.IN_BACK,  EASE.IN_ELASTIC, 
        
        EASE.OUT_QUAD, EASE.OUT_CUBIC, EASE.OUT_QUART, EASE.OUT_QUINT, 
        EASE.OUT_SINE, EASE.OUT_EXPO,  EASE.OUT_BOUNCE, 
        EASE.OUT_CIRC, EASE.OUT_BACK, EASE.OUT_ELASTIC, 
        
        EASE.INOUT_QUAD, EASE.INOUT_CUBIC, EASE.INOUT_QUART, EASE.INOUT_QUINT, 
        EASE.INOUT_SINE, EASE.INOUT_EXPO, EASE.INOUT_BOUNCE, EASE.INOUT_CIRC,
        EASE.INOUT_BACK, EASE.INOUT_ELASTIC 
    ];
    
    static _easesString = 
    [ 
        "EASE.LINEAR", "EASE.SMOOTHSTEP", "EASE.SMOOTHERSTEP", "EASE.SMOOTHESTSTEP", 
        
        "EASE.IN_QUAD",   "EASE.IN_CUBIC", "EASE.IN_QUART",  "EASE.IN_QUINT",  
        "EASE.IN_CIRC",   "EASE.IN_SINE",  "EASE.IN_EXPO", 
        "EASE.IN_BOUNCE", "EASE.IN_BACK",  "EASE.IN_ELASTIC", 
        
        "EASE.OUT_QUAD", "EASE.OUT_CUBIC", "EASE.OUT_QUART", "EASE.OUT_QUINT", 
        "EASE.OUT_SINE", "EASE.OUT_EXPO",  "EASE.OUT_BOUNCE", 
        "EASE.OUT_CIRC", "EASE.OUT_BACK", "EASE.OUT_ELASTIC", 
        
        "EASE.INOUT_QUAD", "EASE.INOUT_CUBIC", "EASE.INOUT_QUART", "EASE.INOUT_QUINT", 
        "EASE.INOUT_SINE", "EASE.INOUT_EXPO", "EASE.INOUT_BOUNCE", "EASE.INOUT_CIRC",
        "EASE.INOUT_BACK", "EASE.INOUT_ELASTIC" 
    ];

    // animate
    __x += (delta_time / (1000000 * _animation_interval)) * __sign;    
    if (__x > 1.0)
    {
        __x = 1 - (__x mod 1);
        __sign = -1;
    }
    else if (sign(__x) == -1)
    {
        __x = -__x;
        __sign = 1;
    }

    // bg
    var _pad = 190;
    draw_set_color(0);
    draw_rectangle(0, 0, _pad, room_height, false);
    draw_rectangle(room_width - _pad, 0, room_width, room_height, false);
        
    // fillbars
    var _i = 0;
    var _len = array_length(_eases);
    var _bar = room_height / _len;
    var _hover = floor((mouse_y / room_height) * _len);

    repeat(_len)
    {
        // ease bar
        draw_set_color((_i == _hover) ? c_silver : c_dkgray);
        draw_rectangle
        (
            _pad, 
            _i * _bar,
            _pad + (room_width - _pad*2) * interpolate(0, 1, __x, _eases[_i]),
            (_i + 1) * _bar, 
            false
        );

        // hover overlay
        draw_set_color(c_silver);
        if (_i == _hover)
        {
            draw_set_alpha(0.125);
            draw_rectangle(_pad, _i * _bar, _pad + (room_width - _pad*2), (_i + 1) * _bar, false);
            draw_set_alpha(1);
            draw_set_color(0);
        }

        // label
        draw_text(_pad, -2 + _i * _bar, _easesString[_i]);
                
        ++_i;
    }

    // overlay
    draw_set_alpha(0.125);
    draw_set_color(c_silver);
    draw_rectangle(_pad, 0, _pad + (room_width  - (_pad * 2)) * __x, room_height, false);
    draw_set_alpha(1);
    
    // about button
    var _x1 = room_width - 50;
    var _x2 = room_width - 10;
    var _y1 = 10;
    var _y2 = 50;
    
    if (__about_seen) draw_set_color(c_dkgray);
    draw_rectangle(_x1, _y1, _x2, _y2, false);
    
    // handle click
    if (!__about_seen && (mouse_x > _x1) && (mouse_x < _x2) && (mouse_y > _y1) && (mouse_y < _y2))
    {
        window_set_cursor(cr_handpoint);
        
        if (mouse_check_button_pressed(mb_left))
        {
            __about_seen = true;
            url_open("https://easings.net/");
        }
    }
    else if (window_get_cursor() != cr_default)
    {
        window_set_cursor(cr_default);
    }
    
    draw_set_color(c_black);
    draw_text(_x1 + 15, _y1 + 10, "?");
}
