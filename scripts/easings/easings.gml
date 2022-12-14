// easings.gml, @offalynne 2021
// github.com/offalynne/easings.gml
//
// refs
//   solhsa.com/interpolation/
//   github.com/ai/easings.net

function ease(_amount, _easing = EASE_LINEAR)
{
    gml_pragma("forceinline");
    return variable_struct_get(__easings(), _easing)(_amount);
}

function tween(_from, _to, _amount, _easing = EASE_LINEAR)
{
    gml_pragma("forceinline");
    return _from + (_to - _from) * ease(_amount, _easing);
}

function __easings()
{
    static instance = new (function() constructor {
    
    global.__2pi = 2.0 * pi;

    //Easing constants    
    __const_c1 = 1.70158;
    __const_c2 = __const_c1 * 1.525;
    __const_c3 = __const_c1 + 1;
    __const_c4 = global.__2pi / 3;
    __const_c5 = global.__2pi / 4.5;
    __const_d1 = 2.75;
    __const_n1 = 7.5625;
    
    //Episilon-safe square root
    __sqrt = function(_z){ return ((sign(_z) == 1) ? sqrt(_z) : 0); }

    //Easings
    self[$ EASE_LINEAR] = function(_z){ return _z; };

    self[$ EASE_IN_QUAD ] = function(_z){ return power(_z, 2); };
    self[$ EASE_IN_CUBIC] = function(_z){ return power(_z, 3); };
    self[$ EASE_IN_QUART] = function(_z){ return power(_z, 4); };
    self[$ EASE_IN_QUINT] = function(_z){ return power(_z, 5); };

    self[$ EASE_OUT_QUAD ] = function(_z){ return 1 - power(1 - _z, 2); };
    self[$ EASE_OUT_CUBIC] = function(_z){ return 1 - power(1 - _z, 3); };
    self[$ EASE_OUT_QUART] = function(_z){ return 1 - power(1 - _z, 4); };
    self[$ EASE_OUT_QUINT] = function(_z){ return 1 - power(1 - _z, 5); };

    self[$ EASE_INOUT_QUAD]  = function(_z){ return _z < 0.5 ? power(_z, 2) *  2 : 1 - power(-2 * _z + 2, 2) / 2; };
    self[$ EASE_INOUT_CUBIC] = function(_z){ return _z < 0.5 ? power(_z, 3) *  4 : 1 - power(-2 * _z + 2, 3) / 2; };
    self[$ EASE_INOUT_QUART] = function(_z){ return _z < 0.5 ? power(_z, 4) *  8 : 1 - power(-2 * _z + 2, 4) / 2; };
    self[$ EASE_INOUT_QUINT] = function(_z){ return _z < 0.5 ? power(_z, 5) * 16 : 1 - power(-2 * _z + 2, 5) / 2; };

    self[$ EASE_IN_SINE]    = function(_z){ return 1 - cos((_z * pi)      / 2); };
    self[$ EASE_OUT_SINE]   = function(_z){ return     sin((_z * pi)      / 2); };
    self[$ EASE_INOUT_SINE] = function(_z){ return   -(cos( _z * pi) - 1) / 2;  };

    self[$ EASE_IN_EXPO]    = function(_z){ return _z == 0 ? 0 :     power(2,  10 * _z - 10); };
    self[$ EASE_OUT_EXPO]   = function(_z){ return _z == 1 ? 1 : 1 - power(2, -10 * _z     ); };
    self[$ EASE_INOUT_EXPO] = function(_z)
    {
        if (_z == 0.0) return 0;
        if (_z == 1.0) return 1;
        if (_z >= 0.5) return (2 - power(2, -20 * _z + 10)) / 2;
                       return      power(2,  20 * _z - 10)  / 2   
    };

    self[$ EASE_OUT_BOUNCE] = function(_z)
    {
             if (_z < 1.0 / __const_d1){                             return __const_n1 * _z * _z;          }
        else if (_z < 2.0 / __const_d1){ _z -= (1.5   / __const_d1); return __const_n1 * _z * _z + 0.75;   }
        else if (_z < 2.5 / __const_d1){ _z -= (2.25  / __const_d1); return __const_n1 * _z * _z + 0.9375; }
                                         _z -= (2.625 / __const_d1); return __const_n1 * _z * _z + 0.984375;
    };

    self[$ EASE_INOUT_BOUNCE] = function(_z)
    {
        if (_z < 0.5) return (1 - self[$ EASE_OUT_BOUNCE](1 -  2 * _z)) / 2
                      return (1 + self[$ EASE_OUT_BOUNCE](2 * _z -  1)) / 2;
    };

    self[$ EASE_IN_BOUNCE] = function(_z){ return 1 - self[$ EASE_OUT_BOUNCE](1 - _z); };

    self[$ EASE_IN_CIRC]    = function(_z){ return 1 - __sqrt(1 - power( _z,      2)); };
    self[$ EASE_OUT_CIRC]   = function(_z){ return     __sqrt(1 - power((_z - 1), 2)); };
    self[$ EASE_INOUT_CIRC] = function(_z)
    {
        if (_z >= 0.5) return (1 + __sqrt(1 - power(-2 * _z + 2, 2))) / 2;
                       return (1 - __sqrt(1 - power( 2 * _z,     2))) / 2;
    };

    self[$ EASE_IN_BACK]    = function(_z){ return     __const_c3 * power(_z,     3) - __const_c1 * power(_z,     2); };
    self[$ EASE_OUT_BACK]   = function(_z){ return 1 + __const_c3 * power(_z - 1, 3) + __const_c1 * power(_z - 1, 2); };
    self[$ EASE_INOUT_BACK] = function(_z)
    {
        if (_z >= 0.5) return (power(2 * _z - 2, 2) * ((__const_c2 + 1) * (_z * 2 - 2) + __const_c2) + 2) / 2;
                       return (power(2 * _z,     2) * ((__const_c2 + 1) * (_z * 2    ) - __const_c2)    ) / 2;
    };

    self[$ EASE_IN_ELASTIC] = function(_z)
    {
        if (_z == 0.0) return 0;
        if (_z == 1.0) return 1;

        return -power(2, 10 * _z - 10) * sin((_z * 10 - 10.75) * __const_c4);
    };

    self[$ EASE_OUT_ELASTIC] = function(_z)
    {
        if (_z == 0.0) return 0;
        if (_z == 1.0) return 1;

        return power(2, -10 * _z) * sin((_z * 10 - 0.75) * __const_c4) + 1;
    };

    self[$ EASE_INOUT_ELASTIC] = function(_z)
    {
        if (_z == 0.0) return 0;
        if (_z == 1.0) return 1;
        if (_z >= 0.5) return   power(2, -20 * _z + 10) * sin((20 * _z - 11.125) * __const_c5)  / 2 + 1;
                       return -(power(2,  20 * _z - 10) * sin((20 * _z - 11.125) * __const_c5)) / 2;
    }
       
    self[$ EASE_SMOOTHESTSTEP] = function(_z){ return -20 * power(_z, 7) + 70 * power(_z, 6) - 84 * power(_z, 5) + 35 * power(_z, 4); };
    self[$ EASE_SMOOTHERSTEP]  = function(_z){ return _z * _z * _z * (_z * (_z * 6 - 15) + 10); };
    self[$ EASE_SMOOTHSTEP]    = function(_z){ return _z * _z * (3 - 2 * _z); };

    })();
    return instance;
};

#macro EASE_LINEAR        "ease linear"
#macro EASE_SMOOTHSTEP    "ease smoothstep"
#macro EASE_SMOOTHERSTEP  "ease smootherstep"
#macro EASE_SMOOTHESTSTEP "ease smootheststep"
#macro EASE_IN_QUAD       "ease in quad"
#macro EASE_IN_CUBIC      "ease in cubic"
#macro EASE_IN_QUART      "ease in quart"
#macro EASE_IN_QUINT      "ease in quint"
#macro EASE_IN_SINE       "ease in sine"
#macro EASE_IN_EXPO       "ease in expo"
#macro EASE_IN_BOUNCE     "ease in bounce"
#macro EASE_IN_CIRC       "ease in circ"
#macro EASE_IN_BACK       "ease in back"
#macro EASE_IN_ELASTIC    "ease in elastic"
#macro EASE_OUT_QUAD      "ease out quad"
#macro EASE_OUT_CUBIC     "ease out cubic"
#macro EASE_OUT_QUART     "ease out quart"
#macro EASE_OUT_QUINT     "ease out quint"
#macro EASE_OUT_SINE      "ease out sine"
#macro EASE_OUT_EXPO      "ease out expo"
#macro EASE_OUT_BOUNCE    "ease out bounce"
#macro EASE_OUT_CIRC      "ease out circ"
#macro EASE_OUT_BACK      "ease out back"
#macro EASE_OUT_ELASTIC   "ease out elastic"
#macro EASE_INOUT_QUAD    "ease in and out quad"
#macro EASE_INOUT_CUBIC   "ease in and out cubic"
#macro EASE_INOUT_QUART   "ease in and out quart"
#macro EASE_INOUT_QUINT   "ease in and out quint"
#macro EASE_INOUT_SINE    "ease in and out sine"
#macro EASE_INOUT_EXPO    "ease in and out expo"
#macro EASE_INOUT_BOUNCE  "ease in and out bounce"
#macro EASE_INOUT_CIRC    "ease in and out circ"
#macro EASE_INOUT_BACK    "ease in and out back"
#macro EASE_INOUT_ELASTIC "ease in and out elastic"