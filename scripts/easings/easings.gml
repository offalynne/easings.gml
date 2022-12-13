// easings.gml, @offalynne 2021
// github.com/offalynne/easings.gml
//
// refs
//   solhsa.com/interpolation/
//   github.com/ai/easings.net

function ease(_amount, _ease_type = EASE_LINEAR)
{
    gml_pragma("forceinline");
    return _ease_type(clamp(_amount, 0, 1));
}

function tween(_from, _to, _amount, _ease_type = EASE_LINEAR)
{
    gml_pragma("forceinline");
    return _from + (_to - _from) * ease(_amount, _ease_type);
}

function __easing()
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
    __linear = function(_z){ return _z; };

    __in_quad  = function(_z){ return power(_z, 2); };
    __in_cubic = function(_z){ return power(_z, 3); };
    __in_quart = function(_z){ return power(_z, 4); };
    __in_quint = function(_z){ return power(_z, 5); };

    __out_quad  = function(_z){ return 1 - power(1 - _z, 2); };
    __out_cubic = function(_z){ return 1 - power(1 - _z, 3); };
    __out_quart = function(_z){ return 1 - power(1 - _z, 4); };
    __out_quint = function(_z){ return 1 - power(1 - _z, 5); };

    __inout_quad  = function(_z){ return _z < 0.5 ? power(_z, 2) *  2 : 1 - power(-2 * _z + 2, 2) / 2; };
    __inout_cubic = function(_z){ return _z < 0.5 ? power(_z, 3) *  4 : 1 - power(-2 * _z + 2, 3) / 2; };
    __inout_quart = function(_z){ return _z < 0.5 ? power(_z, 4) *  8 : 1 - power(-2 * _z + 2, 4) / 2; };
    __inout_quint = function(_z){ return _z < 0.5 ? power(_z, 5) * 16 : 1 - power(-2 * _z + 2, 5) / 2; };

    __in_sine    = function(_z){ return 1 - cos((_z * pi)      / 2); };
    __out_sine   = function(_z){ return     sin((_z * pi)      / 2); };
    __inout_sine = function(_z){ return   -(cos( _z * pi) - 1) / 2;  };

    __in_expo    = function(_z){ return _z == 0 ? 0 :     power(2,  10 * _z - 10); };
    __out_expo   = function(_z){ return _z == 1 ? 1 : 1 - power(2, -10 * _z     ); };
    __inout_expo = function(_z)
    {
        if (_z == 0.0) return 0;
        if (_z == 1.0) return 1;
        if (_z >= 0.5) return (2 - power(2, -20 * _z + 10)) / 2;
                       return      power(2,  20 * _z - 10)  / 2   
    };

    __out_bounce = function(_z)
    {
             if (_z < 1.0 / __const_d1){                             return __const_n1 * _z * _z;          }
        else if (_z < 2.0 / __const_d1){ _z -= (1.5   / __const_d1); return __const_n1 * _z * _z + 0.75;   }
        else if (_z < 2.5 / __const_d1){ _z -= (2.25  / __const_d1); return __const_n1 * _z * _z + 0.9375; }
                                         _z -= (2.625 / __const_d1); return __const_n1 * _z * _z + 0.984375;
    };

    __inout_bounce = function(_z)
    {
        if (_z < 0.5) return (1 - __out_bounce(1 - 2 * _z)) / 2
                     return (1 + __out_bounce(2 * _z - 1)) / 2;
    };

    __in_bounce = function(_z){ return 1 - __out_bounce(1 - _z); };

    __in_circ    = function(_z){ return 1 - __sqrt(1 - power( _z,      2)); };
    __out_circ   = function(_z){ return     __sqrt(1 - power((_z - 1), 2)); };
    __inout_circ = function(_z)
    {
        if (_z >= 0.5) return (1 + __sqrt(1 - power(-2 * _z + 2, 2))) / 2;
                       return (1 - __sqrt(1 - power( 2 * _z,     2))) / 2;
    };

    __in_back    = function(_z){ return     __const_c3 * power(_z,     3) - __const_c1 * power(_z,     2); };
    __out_back   = function(_z){ return 1 + __const_c3 * power(_z - 1, 3) + __const_c1 * power(_z - 1, 2); };
    __inout_back = function(_z)
    {
        if (_z >= 0.5) return (power(2 * _z - 2, 2) * ((__const_c2 + 1) * (_z * 2 - 2) + __const_c2) + 2) / 2;
                       return (power(2 * _z,     2) * ((__const_c2 + 1) * (_z * 2    ) - __const_c2)    ) / 2;
    };

    __in_elastic = function(_z)
    {
        if (_z == 0.0) return 0;
        if (_z == 1.0) return 1;

        return -power(2, 10 * _z - 10) * sin((_z * 10 - 10.75) * __const_c4);
    };

    __out_elastic = function(_z)
    {
        if (_z == 0.0) return 0;
        if (_z == 1.0) return 1;

        return power(2, -10 * _z) * sin((_z * 10 - 0.75) * __const_c4) + 1;
    };

    __inout_elastic = function(_z)
    {
        if (_z == 0.0) return 0;
        if (_z == 1.0) return 1;
        if (_z >= 0.5) return   power(2, -20 * _z + 10) * sin((20 * _z - 11.125) * __const_c5)  / 2 + 1;
                       return -(power(2,  20 * _z - 10) * sin((20 * _z - 11.125) * __const_c5)) / 2;
    }
       
    __smootheststep = function(_z){ return -20 * power(_z, 7) + 70 * power(_z, 6) - 84 * power(_z, 5) + 35 * power(_z, 4); };
    __smootherstep  = function(_z){ return _z * _z * _z * (_z * (_z * 6 - 15) + 10); };
    __smoothstep    = function(_z){ return _z * _z * (3 - 2 * _z); };

    })();
    return instance;
};

#macro EASE_LINEAR         (__easing()).__linear
#macro EASE_SMOOTHSTEP     (__easing()).__smoothstep
#macro EASE_SMOOTHERSTEP   (__easing()).__smootherstep
#macro EASE_SMOOTHESTSTEP  (__easing()).__smootheststep
#macro EASE_IN_QUAD        (__easing()).__in_quad
#macro EASE_IN_CUBIC       (__easing()).__in_cubic
#macro EASE_IN_QUART       (__easing()).__in_quart
#macro EASE_IN_QUINT       (__easing()).__in_quint
#macro EASE_IN_SINE        (__easing()).__in_sine
#macro EASE_IN_EXPO        (__easing()).__in_expo
#macro EASE_IN_BOUNCE      (__easing()).__in_bounce
#macro EASE_IN_CIRC        (__easing()).__in_circ
#macro EASE_IN_BACK        (__easing()).__in_back
#macro EASE_IN_ELASTIC     (__easing()).__in_elastic
#macro EASE_OUT_QUAD       (__easing()).__out_quad
#macro EASE_OUT_CUBIC      (__easing()).__out_cubic
#macro EASE_OUT_QUART      (__easing()).__out_quart
#macro EASE_OUT_QUINT      (__easing()).__out_quint
#macro EASE_OUT_SINE       (__easing()).__out_sine
#macro EASE_OUT_EXPO       (__easing()).__out_expo
#macro EASE_OUT_BOUNCE     (__easing()).__out_bounce
#macro EASE_OUT_CIRC       (__easing()).__out_circ
#macro EASE_OUT_BACK       (__easing()).__out_back
#macro EASE_OUT_ELASTIC    (__easing()).__out_elastic
#macro EASE_INOUT_QUAD     (__easing()).__inout_quad
#macro EASE_INOUT_CUBIC    (__easing()).__inout_cubic
#macro EASE_INOUT_QUART    (__easing()).__inout_quart
#macro EASE_INOUT_QUINT    (__easing()).__inout_quint
#macro EASE_INOUT_SINE     (__easing()).__inout_sine
#macro EASE_INOUT_EXPO     (__easing()).__inout_expo
#macro EASE_INOUT_BOUNCE   (__easing()).__inout_bounce
#macro EASE_INOUT_CIRC     (__easing()).__inout_circ
#macro EASE_INOUT_BACK     (__easing()).__inout_back
#macro EASE_INOUT_ELASTIC  (__easing()).__inout_elastic