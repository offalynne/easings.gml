draw_test = function()
{
    // config
    var _animation_interval = 5; // in seconds

    // init
    static _x = 0;
    static _sign = 1;
    static _names = // variable_struct_get_names(EASE);
    [
        "LINEAR", "SMOOTHSTEP", "SMOOTHERSTEP", "SMOOTHESTSTEP",
        
        "IN_QUAD",   "IN_CUBIC", "IN_QUART", "IN_QUINT",
        "IN_SINE",   "IN_CIRC",  "IN_EXPO",
        "IN_BOUNCE", "IN_BACK",  "IN_ELASTIC",
        
        "OUT_QUAD",  "OUT_CUBIC", "OUT_QUART", "OUT_QUINT",
        "OUT_SINE",  "OUT_EXPO",  "OUT_BOUNCE",
        "OUT_CIRC",  "OUT_BACK",  "OUT_ELASTIC",
        
        "INOUT_QUAD",  "INOUT_CUBIC", "INOUT_QUART", "INOUT_QUINT",
        "INOUT_SINE",  "INOUT_EXPO",  "INOUT_BOUNCE",
        "INOUT_BACK",  "INOUT_CIRC",  "INOUT_ELASTIC"
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
    var _len = array_length(_names);
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
            _pad + (room_width - _pad*2) * tween(0, 1, _x, variable_instance_get(EASE, _names[_i])),
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
        draw_text(_pad, -2 + _i * _bar, "EASE." + _names[_i]);
                
        ++_i;
    }

    // overlay
    draw_set_alpha(0.125);
    draw_set_color(c_silver);
    draw_rectangle(_pad, 0, _pad + (room_width  - (_pad * 2)) * _x, room_height, false);
    draw_set_alpha(1);
}

draw_test();
