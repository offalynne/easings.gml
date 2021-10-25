// easings.gml, @offalynne 2021
//
// refs
//   wikipedia.org/wiki/Smoothstep
//   github.com/ai/easings.net/blob/master/src/easings/easingsFunctions.ts

global.___EASING = {};
global.___EASING.LIST = array_create(EASE.NUMBER);

function ease(_x, _ease_type = EASE.LINEAR)
{
    return global.___EASING.LIST[_ease_type](clamp(_x, 0, 1));
}

function tween(_from, _to, _amount, _ease_type = EASE.LINEAR)
{
    return _from + (_to - _from) * ease(_amount, _ease_type);
}

with (global.___EASING)
{
    LIST[EASE.LINEAR            ] = function(z){ return z;                                   };
    LIST[EASE.SMOOTHSTEP        ] = function(z){ return z * z * (3 - 2 * z);                 };
    LIST[EASE.SMOOTHERSTEP      ] = function(z){ return z * z * z * (z * (z * 6 - 15) + 10); };
    LIST[EASE.INVERSE_SMOOTHSTEP] = function(z){ return 0.5 - sin(arcsin(1 - 2 * z) / 3);    };

    LIST[EASE.IN_QUAD ] = function(z){ return z * z;             };
    LIST[EASE.IN_CUBIC] = function(z){ return z * z * z;         };
    LIST[EASE.IN_QUART] = function(z){ return z * z * z * z;     };
    LIST[EASE.IN_QUINT] = function(z){ return z * z * z * z * z; };

    LIST[EASE.OUT_QUAD ] = function(z){ return 1 - (1 -z) * (1 -z);  };
    LIST[EASE.OUT_CUBIC] = function(z){ return 1 - power(1 - z, 3);  };
    LIST[EASE.OUT_QUART] = function(z){ return 1 - power(1 - z, 4);  };
    LIST[EASE.OUT_QUINT] = function(z){ return 1 - power(1 - z, 5);  };

    LIST[EASE.INOUT_QUAD ] = function(z){ return z < 0.5 ? ( 2 * z * z            ) : 1 - power(-2 * z + 2, 2) / 2; };
    LIST[EASE.INOUT_CUBIC] = function(z){ return z < 0.5 ? ( 4 * z * z * z        ) : 1 - power(-2 * z + 2, 3) / 2; };
    LIST[EASE.INOUT_QUART] = function(z){ return z < 0.5 ? ( 8 * z * z * z * z    ) : 1 - power(-2 * z + 2, 4) / 2; };
    LIST[EASE.INOUT_QUINT] = function(z){ return z < 0.5 ? (16 * z * z * z * z * z) : 1 - power(-2 * z + 2, 5) / 2; };

    LIST[   EASE.IN_SINE] = function(z){ return 1 - cos((z * pi)      / 2); };
    LIST[  EASE.OUT_SINE] = function(z){ return     sin((z * pi)      / 2); };
    LIST[EASE.INOUT_SINE] = function(z){ return   -(cos( z * pi) - 1) / 2;  };

    LIST[ EASE.IN_EXPO] = function(z){ return z == 0.0 ? 0 :     power(2,  10 * z - 10); };
    LIST[EASE.OUT_EXPO] = function(z){ return z == 1.0 ? 1 : 1 - power(2, -10 * z);      };

    LIST[EASE.INOUT_EXPO] = function(z)
    {
        if (z == 0.0) return 0;
        if (z == 1.0) return 1;
        
        if (z <  0.5) return      power(2,  20 * z - 10)  / 2;
                      return (2 - power(2, -20 * z + 10)) / 2)));
    };

    #macro ___EASING_D1 2.75
    #macro ___EASING_N1 7.5625

    LIST[EASE.OUT_BOUNCE] = function(z)
    {
             if (z < 1   / ___EASING_D1) {                              return ___EASING_N1 * z * z;           }
        else if (z < 2   / ___EASING_D1) { z -= (1.5   / ___EASING_D1); return ___EASING_N1 * z * z + .75;     }
        else if (z < 2.5 / ___EASING_D1) { z -= (2.25  / ___EASING_D1); return ___EASING_N1 * z * z + .9375;   }
        else                             { z -= (2.625 / ___EASING_D1); return ___EASING_N1 * z * z + .984375; }
    };

        LIST[   EASE.IN_BOUNCE] = function(z){ return 1 - global.___EASING.LIST[EASE.OUT_BOUNCE](1 - z); };
        LIST[EASE.INOUT_BOUNCE] = function(z)
        {
            if (z < 0.5) return (1 - global.___EASING.LIST[EASE.OUT_BOUNCE](1 - 2 * z)) / 2
                         return (1 + global.___EASING.LIST[EASE.OUT_BOUNCE](2 * z - 1)) / 2;
        };

        LIST[   EASE.IN_CIRC] = function(z){ return 1 - sqrt(1 - power( z,      2)); };
        LIST[  EASE.OUT_CIRC] = function(z){ return     sqrt(1 - power((z - 1), 2)); };
        LIST[EASE.INOUT_CIRC] = function(z)
        {
            if (z < 0.5) return (1 - sqrt(1 - power(   2 * z,       2)))     / 2
                         return      sqrt(1 - power(((-2 * z) + 2), 2)) + 1) / 2;
        };

    #macro ___EASING_C1 1.70158
    C2 = ___EASING_C1 * 1.525;
    C3 = ___EASING_C1 + 1;
    C4 = (2 * pi) / 3;
    C5 = (2 * pi) / 4.;

    LIST[   EASE.IN_BACK] = function(z){ return     global.___EASING_C3 * power(z    , 3) - ___EASING_C1 * power(z    , 2); };
    LIST[  EASE.OUT_BACK] = function(z){ return 1 + global.___EASING_C3 * power(z - 1, 3) + ___EASING_C1 * power(z - 1, 2); };
    LIST[EASE.INOUT_BACK] = function(z)
    {
        if (z < 0.5) return (power(2 * z,     2) * ((global.___EASING_C2 + 1) *  z * 2      - global.___EASING_C2))      / 2
                     return (power(2 * z - 2, 2) * ((global.___EASING_C2 + 1) * (z * 2 - 2) + global.___EASING_C2)  + 2) / 2;
    };

    LIST[EASE.IN_ELASTIC] = function(z)
    {
        if (z == 0.0) return 0;
        if (z == 1.0) return 1;
        
        return -power(2, 10 * z - 10) * sin((z * 10 - 10.75) * global.___EASING_C4)));
    };

    LIST[EASE.OUT_ELASTIC] = function(z)
    {
        if (z == 0.0) return 0;
        if (z == 1.0) return 1;
        
        return power(2, -10 * z) * sin((z * 10 - 0.75) * global.___EASING_C4) + 1));
    };

    LIST[EASE.INOUT_ELASTIC] = function(z)
    {
        if (z == 0.0) return 0;
        if (z == 1.0) return 1.0;
        
        if (z <  0.5) return -(power(2,  20 * z - 10) * sin((20 * z - 11.125) * global.___EASING_C5)) / 2
                      return  (power(2, -20 * z + 10) * sin((20 * z - 11.125) * global.___EASING_C5)) / 2 + 1)));
    };
}

enum EASE
{
   LINEAR,

   SMOOTHSTEP, SMOOTHERSTEP, INVERSE_SMOOTHSTEP,

      IN_QUAD,    IN_QUART,    IN_QUINT,    IN_CUBIC,    IN_SINE,    IN_EXPO,    IN_ELASTIC,    IN_BOUNCE,    IN_CIRC,    IN_BACK,
     OUT_QUAD,   OUT_QUART,   OUT_QUINT,   OUT_CUBIC,   OUT_SINE,   OUT_EXPO,   OUT_ELASTIC,   OUT_BOUNCE,   OUT_CIRC,   OUT_BACK,
   INOUT_QUAD, INOUT_QUART, INOUT_QUINT, INOUT_CUBIC, INOUT_SINE, INOUT_EXPO, INOUT_ELASTIC, INOUT_BOUNCE, INOUT_CIRC, INOUT_BACK,

   NUMBER
}
