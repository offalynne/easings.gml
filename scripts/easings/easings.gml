// easings.gml, @offalynne 2021
//
// refs
//   wikipedia.org/wiki/Smoothstep
//   github.com/ai/easings.net/blob/master/src/easings/easingsFunctions.ts

function ease(_value, _ease_type = EASE.LINEAR)
{
   return EASE[$ _ease_type](_value);
}

function tween(_from, _to, _amount, _ease_type = EASE.LINEAR)
{
    return _from + (_to - _from) * ease(_amount, _ease_type);
}

#macro ___CONST global.___EASING_CONST
___EASING_CONST = 
{
    D1 : 2.75,
    N1 : 7.5625,
    C1 : 1.70158,
    C2 : 1.70158 * 1.525,
    C3 : 1.70158 + 1,
    C4 : (2 * pi) / 3,
    C5 : (2 * pi) / 4.5
}

#macro EASE global.___EASING
___EASING =
{
    LINEAR             : function(z){ return z;                                   },
    SMOOTHSTEP         : function(z){ return z * z * (3 - 2 * z);                 },
    SMOOTHERSTEP       : function(z){ return z * z * z * (z * (z * 6 - 15) + 10); },
    INVERSE_SMOOTHSTEP : function(z){ return 0.5 - sin(arcsin(1 - 2 * z) / 3);    },

    IN_QUAD  : function(z){ return z * z;             },
    IN_CUBIC : function(z){ return z * z * z;         },
    IN_QUART : function(z){ return z * z * z * z;     },
    IN_QUINT : function(z){ return z * z * z * z * z; },

    OUT_QUAD  : function(z){ return 1 - (1 -z) * (1 -z);  },
    OUT_CUBIC : function(z){ return 1 - power(1 - z, 3);  },
    OUT_QUART : function(z){ return 1 - power(1 - z, 4);  },
    OUT_QUINT : function(z){ return 1 - power(1 - z, 5);  },

    INOUT_QUAD  : function(z){ return z < 0.5 ? ( 2 * z * z            ) : 1 - power(-2 * z + 2, 2) / 2; },
    INOUT_CUBIC : function(z){ return z < 0.5 ? ( 4 * z * z * z        ) : 1 - power(-2 * z + 2, 3) / 2; },
    INOUT_QUART : function(z){ return z < 0.5 ? ( 8 * z * z * z * z    ) : 1 - power(-2 * z + 2, 4) / 2; },
    INOUT_QUINT : function(z){ return z < 0.5 ? (16 * z * z * z * z * z) : 1 - power(-2 * z + 2, 5) / 2; },

       IN_SINE : function(z){ return 1 - cos((z * pi)      / 2); },
      OUT_SINE : function(z){ return     sin((z * pi)      / 2); },
    INOUT_SINE : function(z){ return   -(cos( z * pi) - 1) / 2;  },

       IN_EXPO : function(z){ return z == 0.0 ? 0 :     power(2,  10 * z - 10); },
      OUT_EXPO : function(z){ return z == 1.0 ? 1 : 1 - power(2, -10 * z);      },
    INOUT_EXPO : function(z)
    {
        if (z == 0.0) return 0;
        if (z == 1.0) return 1;
        if (z <  0.5) return      power(2,  20 * z - 10)  / 2
                      return (2 - power(2, -20 * z + 10)) / 2;
    },

    IN_BOUNCE  : function(z){ return 1 - EASE.OUT_BOUNCE(1 - z); },
    OUT_BOUNCE : function(z)
    {
             if (z < 1   / ___CONST.D1)      {                        return ___CONST.N1 * z * z;            }
        else if (z < 2   / ___CONST.D1) { z -= (1.5   / ___CONST.D1); return ___CONST.N1 * z * z + 0.75;     }
        else if (z < 2.5 / ___CONST.D1) { z -= (2.25  / ___CONST.D1); return ___CONST.N1 * z * z + 0.9375;   }
                                          z -= (2.625 / ___CONST.D1); return ___CONST.N1 * z * z + 0.984375;
    },
    INOUT_BOUNCE : function(z)
    {
        if (z < 0.5) return (1 - EASE.OUT_BOUNCE(1 - 2 * z)) / 2
                     return (1 + EASE.OUT_BOUNCE(2 * z - 1)) / 2;
    },

       IN_CIRC : function(z){ return 1 - sqrt(1 - power( z,      2)); },
      OUT_CIRC : function(z){ return     sqrt(1 - power((z - 1), 2)); },
    INOUT_CIRC : function(z)
    {
			if (z < 0.5) return (1 - sqrt(1 - power( 2 * z    , 2)))     / 2;
			else         return (    sqrt(1 - power(-2 * z + 2, 2)) + 1) / 2;
    },

       IN_BACK : function(z){ return     ___CONST.C3 * power(z    , 3) - ___CONST.C1 * power(z    , 2); },
      OUT_BACK : function(z){ return 1 + ___CONST.C3 * power(z - 1, 3) + ___CONST.C1 * power(z - 1, 2); },
    INOUT_BACK : function(z)
    {
        if (z < 0.5) return (power(2 * z,     2) * ((___CONST.C2 + 1) *  z * 2      - ___CONST.C2))     / 2;
                     return (power(2 * z - 2, 2) * ((___CONST.C2 + 1) * (z * 2 - 2) + ___CONST.C2) + 2) / 2;
    },

    IN_ELASTIC : function(z)
    {
        if (z == 0.0) return 0;
        if (z == 1.0) return 1;
        
        return -power(2, 10 * z - 10) * sin((z * 10 - 10.75) * ___CONST.C4);
    },

    OUT_ELASTIC : function(z)
    {
        if (z == 0.0) return 0;
        if (z == 1.0) return 1;
        
        return power(2, -10 * z) * sin((z * 10 - 0.75) * ___CONST.C4) + 1;
    },

    INOUT_ELASTIC : function(z)
    {
        if (z == 0.0) return 0;
        if (z == 1.0) return 1;
        
        if (z <  0.5) return -(power(2,  20 * z - 10) * sin((20 * z - 11.125) * ___CONST.C5)) / 2
                      return   power(2, -20 * z + 10) * sin((20 * z - 11.125) * ___CONST.C5)  / 2 + 1;
    }
}

