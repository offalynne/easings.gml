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
            _pad + (room_width - _pad*2) * tween(0, 1, __x, _eases[_i]),
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
        draw_text(_pad, -2 + _i * _bar, _eases[_i]);
                
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