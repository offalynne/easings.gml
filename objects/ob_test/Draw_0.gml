function draw_test()
{
    // config
    var _animation_interval = 5; // in seconds
    
    // init
    static _x    = 0;
    static _sign = 1;
    static _ease_names = [
        "LINEAR",
        "SMOOTHSTEP", 
        "SMOOTHERSTEP", 
        "INVERSE_SMOOTHSTEP",
        
        "IN_QUAD",   "IN_QUART",   "IN_QUINT",   "IN_CUBIC",   "IN_SINE",   "IN_EXPO",   "IN_ELASTIC",   "IN_BOUNCE",   "IN_CIRC",   "IN_BACK",
       "OUT_QUAD",  "OUT_QUART",  "OUT_QUINT",  "OUT_CUBIC",  "OUT_SINE",  "OUT_EXPO",  "OUT_ELASTIC",  "OUT_BOUNCE",  "OUT_CIRC",  "OUT_BACK",
     "INOUT_QUAD","INOUT_QUART","INOUT_QUINT","INOUT_CUBIC","INOUT_SINE","INOUT_EXPO","INOUT_ELASTIC","INOUT_BOUNCE","INOUT_CIRC","INOUT_BACK",
    ];

    // animate
    _x += (delta_time / (1000000 * _animation_interval)) * _sign;    
    if (_x > 1.0)
    {
        _x    =  1 - (_x mod 1);
        _sign = -1;
    }
    else if (sign(_x) == -1)
    {
        _x    = -_x;
        _sign =   1;
    }
    
    // draw setup
    var _i     = 0;
    var _pad   = 190;
    var _len   = EASE.NUMBER;
    var _bar   = room_height / _len;
    var _hover = floor((mouse_y / room_height) * _len);
        
    // bg
    draw_set_color(0);
    draw_rectangle(0, 0, _pad, room_height, false);
    draw_rectangle(room_width - _pad, 0, room_width, room_height, false);
        
    // fillbars
    repeat(_len)
    {
        // ease bar
        draw_set_color((_i == _hover) ? c_silver : c_dkgray);
        draw_rectangle(_pad, _i * _bar, _pad + (room_width - _pad*2) * tween(0, 1, _x, _i), (_i + 1) * _bar, false);
        
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
        draw_text(_pad, -2 + _i * _bar, "EASE." + _ease_names[_i]);
                
        ++_i;
    }
    
    // overlay
    draw_set_alpha(0.125);
    draw_set_color(c_silver);
    draw_rectangle(_pad, 0, _pad + (room_width  - (_pad * 2)) * _x, room_height, false);
    draw_set_alpha(1);
}

draw_test();
