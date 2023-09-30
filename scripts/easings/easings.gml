// easings.gml, @offalynne 2021
// github.com/offalynne/easings.gml
//
// refs
//   solhsa.com/interpolation/
//   github.com/ai/easings.net

function ease(_amount, _easing = EASE_LINEAR){
    return __easings()[$ _easing](clamp(_amount, 0, 1));
}

function tween(_from, _to, _amount, _easing = EASE_LINEAR){
    return _from + (_to - _from) * ease(_amount, _easing);
}

//Library singleton
function __easings() { static __instance = new (function() constructor {

    //Tau my beloved
    __2pi = 2*pi;

    //Epsilon-safe square root
    __sqrt = function(_z){ return (sign(_z) == 1)? sqrt(_z) : 0; };
    
    //Easing factory
    var _add_easing = function(_name, _function, _struct = self){
        variable_struct_set(_struct, _name, _function);
    };

    //Easings functions    
    _add_easing(EASE_LINEAR, function(_z){ return _z; });

    _add_easing(EASE_IN_QUAD,  function(_z){ return power(_z, 2); });
    _add_easing(EASE_IN_CUBIC, function(_z){ return power(_z, 3); });
    _add_easing(EASE_IN_QUART, function(_z){ return power(_z, 4); });
    _add_easing(EASE_IN_QUINT, function(_z){ return power(_z, 5); });

    _add_easing(EASE_OUT_QUAD,  function(_z){ return 1 - power(1 - _z, 2); });
    _add_easing(EASE_OUT_CUBIC, function(_z){ return 1 - power(1 - _z, 3); });
    _add_easing(EASE_OUT_QUART, function(_z){ return 1 - power(1 - _z, 4); });
    _add_easing(EASE_OUT_QUINT, function(_z){ return 1 - power(1 - _z, 5); });

    _add_easing(EASE_INOUT_QUAD,  function(_z){ return _z < 0.5 ? power(_z, 2)* 2 : 1 - power(-2*_z + 2, 2)/2; });
    _add_easing(EASE_INOUT_CUBIC, function(_z){ return _z < 0.5 ? power(_z, 3)* 4 : 1 - power(-2*_z + 2, 3)/2; });
    _add_easing(EASE_INOUT_QUART, function(_z){ return _z < 0.5 ? power(_z, 4)* 8 : 1 - power(-2*_z + 2, 4)/2; });
    _add_easing(EASE_INOUT_QUINT, function(_z){ return _z < 0.5 ? power(_z, 5)*16 : 1 - power(-2*_z + 2, 5)/2; });

    _add_easing(EASE_IN_SINE,    function(_z){ return 1 - cos((_z*pi)     /2); });
    _add_easing(EASE_OUT_SINE,   function(_z){ return     sin((_z*pi)     /2); });
    _add_easing(EASE_INOUT_SINE, function(_z){ return   -(cos( _z*pi) - 1)/2;  });

    _add_easing(EASE_IN_EXPO,    function(_z){ return _z == 0 ? 0 :     power(2,  10 * _z - 10); });
    _add_easing(EASE_OUT_EXPO,   function(_z){ return _z == 1 ? 1 : 1 - power(2, -10 * _z     ); });
    _add_easing(EASE_INOUT_EXPO, function(_z){
        if (_z == 0.0) return 0;
        if (_z == 1.0) return 1;
        if (_z >= 0.5) return (2 - power(2, -20*_z + 10))/2;
                        return     power(2,  20*_z - 10) /2   
    });
        
    __d1 = 2.75;
    __n1 = 7.5625;

    __out_bounce = function(_z){
             if (_z < 1.0/(__easings()).__d1){                                   return (__easings()).__n1*_z*_z;          }
        else if (_z < 2.0/(__easings()).__d1){ _z -= (1.5  /(__easings()).__d1); return (__easings()).__n1*_z*_z + 0.75;   }
        else if (_z < 2.5/(__easings()).__d1){ _z -= (2.25 /(__easings()).__d1); return (__easings()).__n1*_z*_z + 0.9375; }
                                               _z -= (2.625/(__easings()).__d1); return (__easings()).__n1*_z*_z + 0.984375;
    };

    _add_easing(EASE_OUT_BOUNCE, __out_bounce);

    _add_easing(EASE_INOUT_BOUNCE, function(_z){
        if (_z < 0.5) return (1 - (__easings()).__out_bounce(1 -  2*_z))/2
                      return (1 + (__easings()).__out_bounce(2*_z -  1))/2;
    });
    
    _add_easing(EASE_IN_BOUNCE, function(_z){ return 1 - (__easings()).__out_bounce(1 - _z); });

    _add_easing(EASE_IN_CIRC,    function(_z){ return 1 - (__easings()).__sqrt(1 - power( _z,      2)); });
    _add_easing(EASE_OUT_CIRC,   function(_z){ return     (__easings()).__sqrt(1 - power((_z - 1), 2)); });
    _add_easing(EASE_INOUT_CIRC, function(_z){
        if (_z >= 0.5) return (1 + (__easings()).__sqrt(1 - power(-2*_z + 2, 2)))/2;
                       return (1 - (__easings()).__sqrt(1 - power( 2*_z,     2)))/2;
    });
        
    __c1 = 1.70158;
    __c2 = __c1 * 1.525;
    __c3 = __c1 + 1;
    __c4 = __2pi/3;
    __c5 = __2pi/4.5;

    _add_easing(EASE_IN_BACK,    function(_z){ return     (__easings()).__c3*power(_z,     3) - (__easings()).__c1*power(_z,     2); });
    _add_easing(EASE_OUT_BACK,   function(_z){ return 1 + (__easings()).__c3*power(_z - 1, 3) + (__easings()).__c1*power(_z - 1, 2); });
    _add_easing(EASE_INOUT_BACK, function(_z){
        if (_z >= 0.5) return (power(2*_z - 2, 2) * (((__easings()).__c2 + 1) * (_z*2 - 2) + (__easings()).__c2) + 2)/2;
                       return (power(2*_z,     2) * (((__easings()).__c2 + 1) * (_z*2    ) - (__easings()).__c2)    )/2;
    });

    _add_easing(EASE_IN_ELASTIC, function(_z){
        if (_z == 0.0) return 0;
        if (_z == 1.0) return 1;

        return -power(2, 10*_z - 10) * sin((_z*10 - 10.75)*__c4);
    });

    _add_easing(EASE_OUT_ELASTIC, function(_z){
        if (_z == 0.0) return 0;
        if (_z == 1.0) return 1;

        return power(2, -10*_z) * sin((_z*10 - 0.75)*__c4) + 1;
    });        

    _add_easing(EASE_INOUT_ELASTIC, function(_z){
        if (_z == 0.0) return 0;
        if (_z == 1.0) return 1;
        if (_z >= 0.5) return   power(2, -20*_z + 10) * sin((20*_z - 11.125)*__c5) /2 + 1;
                       return -(power(2,  20*_z - 10) * sin((20*_z - 11.125)*__c5))/2;
    });
       
    _add_easing(EASE_SMOOTHESTSTEP, function(_z){ return -20*power(_z, 7) + 70*power(_z, 6) - 84*power(_z, 5) + 35*power(_z, 4); });
    _add_easing(EASE_SMOOTHERSTEP,  function(_z){ return _z*_z*_z*(_z*(_z*6 - 15) + 10); });
    _add_easing(EASE_SMOOTHSTEP,    function(_z){ return _z*_z*(3 - 2 * _z); });

})(); return __instance; };

#macro EASE_LINEAR         "linear"
#macro EASE_IN_QUAD        "in quad"
#macro EASE_IN_CUBIC       "in cubic"
#macro EASE_IN_QUART       "in quart"
#macro EASE_IN_QUINT       "in quint"
#macro EASE_IN_SINE        "in sine"
#macro EASE_IN_EXPO        "in expo"
#macro EASE_IN_BOUNCE      "in bounce"
#macro EASE_IN_CIRC        "in circ"
#macro EASE_IN_BACK        "in back"
#macro EASE_IN_ELASTIC     "in elastic"
#macro EASE_OUT_QUAD       "out quad"
#macro EASE_OUT_CUBIC      "out cubic"
#macro EASE_OUT_QUART      "out quart"
#macro EASE_OUT_QUINT      "out quint"
#macro EASE_OUT_SINE       "out sine"
#macro EASE_OUT_EXPO       "out expo"
#macro EASE_OUT_BOUNCE     "out bounce"
#macro EASE_OUT_CIRC       "out circ"
#macro EASE_OUT_BACK       "out back"
#macro EASE_OUT_ELASTIC    "out elastic"
#macro EASE_INOUT_QUAD     "in out quad"
#macro EASE_INOUT_CUBIC    "in out cubic"
#macro EASE_INOUT_QUART    "in out quart"
#macro EASE_INOUT_QUINT    "in out quint"
#macro EASE_INOUT_SINE     "in out sine"
#macro EASE_INOUT_EXPO     "in out expo"
#macro EASE_INOUT_BOUNCE   "in out bounce"
#macro EASE_INOUT_CIRC     "in out circ"
#macro EASE_INOUT_BACK     "in out back"
#macro EASE_INOUT_ELASTIC  "in out elastic"
#macro EASE_SMOOTHSTEP     "smoothstep"
#macro EASE_SMOOTHERSTEP   "smootherstep"
#macro EASE_SMOOTHESTSTEP  "smootheststep"
