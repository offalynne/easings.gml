// easings.gml, @offalynne 2021
//
// refs
//   sol.gfxile.net/interpolation
//   github.com/ai/easings.net

function ease(_value, _ease_type = EASE.LINEAR)
{
   return _ease_type(clamp(_value, 0, 1));
}

function tween(_from, _to, _amount, _ease_type = EASE.LINEAR)
{
    return _from + (_to - _from) * ease(_amount, _ease_type);
}

#macro EASE (___easing())
function ___easing()
{
    static instance = new (function() constructor {

    LINEAR = function(z){ return z; };

    SMOOTHSTEP = function(z){ return z * z * (3 - 2 * z); };
       
    SMOOTHERSTEP = function(z){ return z * z * z * (z * (z * 6 - 15) + 10); };

    SMOOTHESTSTEP = function(z){ return -20 * power(z, 7) + 70 * power(z, 6) - 84 * power(z, 5) + 35 * power(z, 4); };

    IN_QUAD  = function(z){ return power(z, 2); };
    IN_CUBIC = function(z){ return power(z, 3); };
    IN_QUART = function(z){ return power(z, 4); };
    IN_QUINT = function(z){ return power(z, 5); };

    OUT_QUAD  = function(z){ return 1 - power(1 - z, 2); };
    OUT_CUBIC = function(z){ return 1 - power(1 - z, 3); };
    OUT_QUART = function(z){ return 1 - power(1 - z, 4); };
    OUT_QUINT = function(z){ return 1 - power(1 - z, 5); };

    INOUT_QUAD  = function(z){ return z < 0.5 ? power(z, 2) *  2 : 1 - power(-2 * z + 2, 2) / 2; };
    INOUT_CUBIC = function(z){ return z < 0.5 ? power(z, 3) *  4 : 1 - power(-2 * z + 2, 3) / 2; };
    INOUT_QUART = function(z){ return z < 0.5 ? power(z, 4) *  8 : 1 - power(-2 * z + 2, 4) / 2; };
    INOUT_QUINT = function(z){ return z < 0.5 ? power(z, 5) * 16 : 1 - power(-2 * z + 2, 5) / 2; };

    IN_SINE    = function(z){ return 1 - cos((z * pi)      / 2); };
    OUT_SINE   = function(z){ return     sin((z * pi)      / 2); };
    INOUT_SINE = function(z){ return   -(cos( z * pi) - 1) / 2;  };

    IN_EXPO    = function(z){ return z == 0 ? 0 :     power(2,  10 * z - 10); };
    OUT_EXPO   = function(z){ return z == 1 ? 1 : 1 - power(2, -10 * z     ); };
    INOUT_EXPO = function(z)
    {
        if (z == 0.0) return 0;
        if (z == 1.0) return 1;
        if (z >= 0.5) return (2 - power(2, -20 * z + 10)) / 2;
                      return      power(2,  20 * z - 10)  / 2   
    };
    
    global.___EASING_D1 2.75
    global.___EASING_N1 7.5625

    OUT_BOUNCE = function(z)
    {
             if (z < 1.0 / global.___EASING_D1) {                                     return global.___EASING_N1 * z * z;          }
        else if (z < 2.0 / global.___EASING_D1) { z -= (1.5   / global.___EASING_D1); return global.___EASING_N1 * z * z + 0.75;   }
        else if (z < 2.5 / global.___EASING_D1) { z -= (2.25  / global.___EASING_D1); return global.___EASING_N1 * z * z + 0.9375; }
                                                  z -= (2.625 / global.___EASING_D1); return global.___EASING_N1 * z * z + 0.984375;
    };

    INOUT_BOUNCE = function(z)
    {
        if (z < 0.5) return (1 - OUT_BOUNCE(1 - 2 * z)) / 2
                     return (1 + OUT_BOUNCE(2 * z - 1)) / 2;
    };

    IN_BOUNCE = function(z){ return 1 - OUT_BOUNCE(1 - z); };
    
    global.___EASING_SQRT = function(z){ return ((sign(z) == 1) ? sqrt(z) : 0); }

    IN_CIRC    = function(z){ return 1 - global.___EASING_SQRT(1 - power( z,      2)); };
    OUT_CIRC   = function(z){ return     global.___EASING_SQRT(1 - power((z - 1), 2)); };
    INOUT_CIRC = function(z)
    {
        if (z >= 0.5) return (1 + global.___EASING_SQRT(1 - power(-2 * z + 2, 2))) / 2;
                      return (1 - global.___EASING_SQRT(1 - power( 2 * z,     2))) / 2;
    };
    
    global.___EASING_C1 1.70158
    global.___EASING_C2 = global.___EASING_C1 * 1.525;
    global.___EASING_C3 = global.___EASING_C1 + 1;

    IN_BACK    = function(z){ return     global.___EASING_C3 * power(z,     3) -global.___EASING_C1 * power(z,     2); };
    OUT_BACK   = function(z){ return 1 + global.___EASING_C3 * power(z - 1, 3) +global.___EASING_C1 * power(z - 1, 2); };
    INOUT_BACK = function(z)
    {
        if (z >= 0.5) return (power(2 * z - 2, 2) * ((global.___EASING_C2 + 1) * (z * 2 - 2) + global.___EASING_C2) + 2) / 2;
                      return (power(2 * z,     2) * ((global.___EASING_C2 + 1) * (z * 2    ) - global.___EASING_C2)    ) / 2;
    };
    
    global.___EASING_C4 = (2 * pi) / 3;
    global.___EASING_C5 = (2 * pi) / 4.5;

    IN_ELASTIC = function(z)
    {
        if (z == 0.0) return 0;
        if (z == 1.0) return 1;

        return -power(2, 10 * z - 10) * sin((z * 10 - 10.75) * global.___EASING_C4);
    };

    OUT_ELASTIC = function(z)
    {
        if (z == 0.0) return 0;
        if (z == 1.0) return 1;

        return power(2, -10 * z) * sin((z * 10 - 0.75) * global.___EASING_C4) + 1;
    };

    INOUT_ELASTIC = function(z)
    {
        if (z == 0.0) return 0;
        if (z == 1.0) return 1;
        if (z >= 0.5) return   power(2, -20 * z + 10) * sin((20 * z - 11.125) * global.___EASING_C5)  / 2 + 1;
                      return -(power(2,  20 * z - 10) * sin((20 * z - 11.125) * global.___EASING_C5)) / 2;
    }
        
    })();
    return instance;
};
