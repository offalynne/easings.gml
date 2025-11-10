// easings.gml, @offalynne 2021
// github.com/offalynne/easings.gml
//
// refs
//   solhsa.com/interpolation/
//   github.com/ai/easings.net

function ease(_amount, _easing = EASE.__NONE){
    return __easings().__list[_easing](clamp(_amount, 0, 1)) }

function interpolate(_from, _to, _amount, _easing = EASE.__NONE){
    return _from + (_to - _from)*ease(_amount, _easing) }

//Library singleton
function __easings(){ static __instance = new (function() constructor{

    __list = [];

    //Epsilon-safe square root
    __sqrt = function(_z){ return (sign(_z) == 1)? sqrt(_z) : 0 };
    
    //Easings functions    
    __list[EASE.__NONE     ] = function(_z){ return _z >= 0.5 };
    __list[EASE.LINEAR     ] = function(_z){ return _z };

    __list[EASE.IN_QUAD    ] = function(_z){ return power(_z, 2) };
    __list[EASE.IN_CUBIC   ] = function(_z){ return power(_z, 3) };
    __list[EASE.IN_QUART   ] = function(_z){ return power(_z, 4) };
    __list[EASE.IN_QUINT   ] = function(_z){ return power(_z, 5) };

    __list[EASE.OUT_QUAD   ] = function(_z){ return 1 - power(1 - _z, 2) };
    __list[EASE.OUT_CUBIC  ] = function(_z){ return 1 - power(1 - _z, 3) };
    __list[EASE.OUT_QUART  ] = function(_z){ return 1 - power(1 - _z, 4) };
    __list[EASE.OUT_QUINT  ] = function(_z){ return 1 - power(1 - _z, 5) };

    __list[EASE.INOUT_QUAD ] = function(_z){ return _z < 0.5 ? power(_z, 2)* 2 : 1 - power(-2*_z + 2, 2)/2 };
    __list[EASE.INOUT_CUBIC] = function(_z){ return _z < 0.5 ? power(_z, 3)* 4 : 1 - power(-2*_z + 2, 3)/2 };
    __list[EASE.INOUT_QUART] = function(_z){ return _z < 0.5 ? power(_z, 4)* 8 : 1 - power(-2*_z + 2, 4)/2 };
    __list[EASE.INOUT_QUINT] = function(_z){ return _z < 0.5 ? power(_z, 5)*16 : 1 - power(-2*_z + 2, 5)/2 };

    __list[EASE.IN_SINE    ] = function(_z){ return 1 - cos((_z*pi)     /2) };
    __list[EASE.OUT_SINE   ] = function(_z){ return     sin((_z*pi)     /2) };
    __list[EASE.INOUT_SINE ] = function(_z){ return   -(cos( _z*pi) - 1)/2  };

    __list[EASE.IN_EXPO    ] = function(_z){ return (_z == 0) ? 0 :     power(2,  10*_z - 10) };
    __list[EASE.OUT_EXPO   ] = function(_z){ return (_z == 1) ? 1 : 1 - power(2, -10*_z     ) };
    __list[EASE.INOUT_EXPO ] = function(_z){
        if (_z == 0.0){ return  0 }
        if (_z == 1.0){ return  1 }
        if (_z >= 0.5){ return (2 - power(2, -20*_z + 10))/2 }
                        return      power(2,  20*_z - 10) /2 };

    __bounce = function(_z){
             if (_z < 0.363636){                     return 7.5625*_z*_z            }
        else if (_z < 0.727272){ _z -= (1.5  /2.75); return 7.5625*_z*_z + 0.75     }
        else if (_z < 0.909090){ _z -= (2.25 /2.75); return 7.5625*_z*_z + 0.9375   }
                                 _z -= (2.625/2.75); return 7.5625*_z*_z + 0.984375 };

    __list[EASE.OUT_BOUNCE] = __bounce;
    
    __list[EASE.INOUT_BOUNCE] = function(_z){
        if (_z < 0.5) return (1 - __bounce(1 -  2*_z))/2
                      return (1 + __bounce(2*_z -  1))/2 };
    
    __list[EASE.IN_BOUNCE] = function(_z){ return 1 - __bounce(1 - _z) };

    __list[EASE.IN_CIRC   ] = function(_z){ return 1 - __sqrt(1 - power( _z,      2)) };
    __list[EASE.OUT_CIRC  ] = function(_z){ return     __sqrt(1 - power((_z - 1), 2)) };
    __list[EASE.INOUT_CIRC] = function(_z){
        if (_z >= 0.5){ return (1 + __sqrt(1 - power(-2*_z + 2, 2)))/2 }
                        return (1 - __sqrt(1 - power( 2*_z,     2)))/2 };

    __list[EASE.IN_BACK   ] = function(_z){ return     2.70158*power(_z,     3) - 1.70158*power(_z,     2) };
    __list[EASE.OUT_BACK  ] = function(_z){ return 1 + 2.70158*power(_z - 1, 3) + 1.70158*power(_z - 1, 2) };
    __list[EASE.INOUT_BACK] = function(_z){
        if (_z >= 0.5){ return (power(2*_z - 2, 2)*(3.5949095*(_z*2 - 2) + 2.5949095) + 2)/2 }
                        return (power(2*_z,     2)*(3.5949095*(_z*2    ) - 2.5949095)    )/2 };

    __list[EASE.IN_ELASTIC] = function(_z){
        static __c = 2*pi/3;
        if (_z == 0.0){ return 0 }
        if (_z == 1.0){ return 1 }
        return -power(2, 10*_z - 10)*sin((_z*10 - 10.75)*__c) };

    __list[EASE.OUT_ELASTIC] = function(_z){
        static __c = 2*pi/3;
        if (_z == 0.0){ return 0 }
        if (_z == 1.0){ return 1 }
        return power(2, -10*_z) * sin((_z*10 - 0.75)*__c) + 1 };        

    __list[EASE.INOUT_ELASTIC] = function(_z){
        static __c = 2*pi/4.5;
        if (_z == 0.0){ return 0 }
        if (_z == 1.0){ return 1 }
        if (_z >= 0.5){ return   power(2, -20*_z + 10)*sin((20*_z - 11.125)*__c) /2 + 1 }
                        return -(power(2,  20*_z - 10)*sin((20*_z - 11.125)*__c))/2 };
       
    __list[EASE.SMOOTHESTSTEP] = function(_z){ return -20*power(_z, 7) + 70*power(_z, 6) - 84*power(_z, 5) + 35*power(_z, 4) };
    __list[EASE.SMOOTHERSTEP ] = function(_z){ return _z*_z*_z*(_z*(_z*6 - 15) + 10) };
    __list[EASE.SMOOTHSTEP   ] = function(_z){ return _z*_z*(3 - 2*_z) };

})(); return __instance }

enum EASE {
    __NONE, 
    LINEAR, 
    IN_QUAD, 
    IN_CUBIC, 
    IN_QUART, 
    IN_QUINT, 
    IN_SINE, 
    IN_EXPO, 
    IN_BOUNCE, 
    IN_CIRC, 
    IN_BACK, 
    IN_ELASTIC, 
    OUT_QUAD, 
    OUT_CUBIC, 
    OUT_QUART, 
    OUT_QUINT, 
    OUT_SINE, 
    OUT_EXPO, 
    OUT_BOUNCE, 
    OUT_CIRC, 
    OUT_BACK, 
    OUT_ELASTIC, 
    INOUT_QUAD, 
    INOUT_CUBIC, 
    INOUT_QUART, 
    INOUT_QUINT, 
    INOUT_SINE, 
    INOUT_EXPO, 
    INOUT_BOUNCE, 
    INOUT_CIRC, 
    INOUT_BACK, 
    INOUT_ELASTIC, 
    SMOOTHSTEP, 
    SMOOTHERSTEP, 
    SMOOTHESTSTEP,    
}

