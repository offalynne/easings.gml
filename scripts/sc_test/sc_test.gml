function sc_test()
{
    // config
    var _animation_interval = 5; // in seconds

    // init
    static _x = 0;
    static _sign = 1;
    
    static _eases = 
    [ 
        EASE_LINEAR, EASE_SMOOTHSTEP, EASE_SMOOTHERSTEP, EASE_SMOOTHESTSTEP, 
        
        EASE_IN_QUAD,   EASE_IN_CUBIC, EASE_IN_QUART,  EASE_IN_QUINT,  
        EASE_IN_CIRC,   EASE_IN_SINE,  EASE_IN_EXPO, 
        EASE_IN_BOUNCE, EASE_IN_BACK,  EASE_IN_ELASTIC, 
        
        EASE_OUT_QUAD, EASE_OUT_CUBIC, EASE_OUT_QUART, EASE_OUT_QUINT, 
        EASE_OUT_SINE, EASE_OUT_EXPO, EASE_OUT_BOUNCE, 
        EASE_OUT_CIRC, EASE_OUT_BACK, EASE_OUT_ELASTIC, 
        
        EASE_INOUT_QUAD, EASE_INOUT_CUBIC, EASE_INOUT_QUART, EASE_INOUT_QUINT, 
        EASE_INOUT_SINE, EASE_INOUT_EXPO, EASE_INOUT_BOUNCE, EASE_INOUT_CIRC,
        EASE_INOUT_BACK, EASE_INOUT_ELASTIC 
    ];
    
    static _names =
    [
        "LINEAR", "SMOOTHSTEP", "SMOOTHERSTEP", "SMOOTHESTSTEP",
        
        "IN_QUAD",   "IN_CUBIC", "IN_QUART", "IN QUINT",
        "IN_SINE",   "IN_CIRC",  "IN_EXPO",
        "IN_BOUNCE", "IN_BACK",  "IN_ELASTIC",
        
        "OUT_QUAD", "OUT_CUBIC", "OUT_QUART", "OUT_QUINT",
        "OUT_SINE", "OUT_EXPO",  "OUT_BOUNCE",
        "OUT_CIRC", "OUT_BACK",  "OUT_ELASTIC",
        
        "INOUT_QUAD", "INOUT_CUBIC", "INOUT_QUART", "INOUT_QUINT",
        "INOUT_SINE", "INOUT_EXPO",  "INOUT_BOUNCE",
        "INOUT_BACK", "INOUT_CIRC",  "INOUT_ELASTIC"
    ];

    // animate
    _x += (delta_time / (1000000 * _animation_interval)) * _sign;    
    if (_x > 1.0)
    {
        _x = 1 - (_x mod 1);
        _sign = -1;
    }
    else if (sign(_x) == -1)
    {
        _x = -_x;
        _sign = 1;
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
            _pad + (room_width - _pad*2) * tween(0, 1, _x, _eases[_i]),
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
        draw_text(_pad, -2 + _i * _bar, "EASE_" + _names[_i]);
                
        ++_i;
    }

    // overlay
    draw_set_alpha(0.125);
    draw_set_color(c_silver);
    draw_rectangle(_pad, 0, _pad + (room_width  - (_pad * 2)) * _x, room_height, false);
    draw_set_alpha(1);
}