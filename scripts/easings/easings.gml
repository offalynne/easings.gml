// easings.gml, @offalynne 2021
// github.com/offalynne/easings.gml
//
// refs
//   solhsa.com/interpolation/
//   github.com/ai/easings.net

function ease(_amount, _easing = EASE_LINEAR)
{
    return _easing.__toValue(clamp(_amount, 0, 1));
}

function tween(_from, _to, _amount, _easing = EASE_LINEAR)
{
    return _from + (_to - _from) * ease(_amount, _easing);
}

//Library singleton
function __easings() { static __instance = new (function() constructor 
{
    //Tau my beloved
    __2pi = 2*pi;
    
    //Epsilon-safe square root
    __sqrt = function(_z){ return (sign(_z) == 1)? sqrt(_z) : 0; };
    
    //Easing class
    __easing = function(_name, _value) constructor
    {
        //Name field for *ease* of debugging
        __name    = _name;        
        __toValue = _value;
        static toString = function(){ return __name; };
    };
    
    //Easing factory
    var _add_easing = function(_name, _value, _struct = self)
    {
        //Index function with code-valid name based on readable name
        variable_struct_set(_struct, string_replace_all("__" + _name, " ", "_"), new __easing("ease " + _name, _value));
    };

    //Easings functions    
    _add_easing("linear", function(_z){ return _z; });

    _add_easing("in quad",  function(_z){ return power(_z, 2); });
    _add_easing("in cubic", function(_z){ return power(_z, 3); });
    _add_easing("in quart", function(_z){ return power(_z, 4); });
    _add_easing("in quint", function(_z){ return power(_z, 5); });

    _add_easing("out quad",   function(_z){ return 1 - power(1 - _z, 2); });
    _add_easing("out cubic",  function(_z){ return 1 - power(1 - _z, 3); });
    _add_easing("out quart",  function(_z){ return 1 - power(1 - _z, 4); });
    _add_easing("out quint",  function(_z){ return 1 - power(1 - _z, 5); });

    _add_easing("in out quad",  function(_z){ return _z < 0.5 ? power(_z, 2)* 2 : 1 - power(-2*_z + 2, 2)/2; });
    _add_easing("in out cubic", function(_z){ return _z < 0.5 ? power(_z, 3)* 4 : 1 - power(-2*_z + 2, 3)/2; });
    _add_easing("in out quart", function(_z){ return _z < 0.5 ? power(_z, 4)* 8 : 1 - power(-2*_z + 2, 4)/2; });
    _add_easing("in out quint", function(_z){ return _z < 0.5 ? power(_z, 5)*16 : 1 - power(-2*_z + 2, 5)/2; });

    _add_easing("in sine",     function(_z){ return 1 - cos((_z*pi)     /2); });
    _add_easing("out sine",    function(_z){ return     sin((_z*pi)     /2); });
    _add_easing("in out sine", function(_z){ return   -(cos( _z*pi) - 1)/2;  });

    _add_easing("in expo",     function(_z){ return _z == 0 ? 0 :     power(2,  10 * _z - 10); });
    _add_easing("out expo",    function(_z){ return _z == 1 ? 1 : 1 - power(2, -10 * _z     ); });
    _add_easing("in out expo", function(_z)
    {
        if (_z == 0.0) return 0;
        if (_z == 1.0) return 1;
        if (_z >= 0.5) return (2 - power(2, -20*_z + 10))/2;
                        return     power(2,  20*_z - 10) /2   
    });
        
    __d1 = 2.75;
    __n1 = 7.5625;

    _add_easing("out bounce", function(_z)
    {
             if (_z < 1.0/(__easings()).__d1){                                   return (__easings()).__n1*_z*_z;          }
        else if (_z < 2.0/(__easings()).__d1){ _z -= (1.5  /(__easings()).__d1); return (__easings()).__n1*_z*_z + 0.75;   }
        else if (_z < 2.5/(__easings()).__d1){ _z -= (2.25 /(__easings()).__d1); return (__easings()).__n1*_z*_z + 0.9375; }
                                               _z -= (2.625/(__easings()).__d1); return (__easings()).__n1*_z*_z + 0.984375;
    });

    _add_easing("in out bounce", function(_z)
    {
        if (_z < 0.5) return (1 - (__easings()).__out_bounce.__toValue(1 -  2*_z))/2
                      return (1 + (__easings()).__out_bounce.__toValue(2*_z -  1))/2;
    });
    
    _add_easing("in bounce", function(_z){ return 1 - (__easings()).__out_bounce.__toValue(1 - _z); });

    _add_easing("in circ",     function(_z){ return 1 - (__easings()).__sqrt(1 - power( _z,      2)); });
    _add_easing("out circ",    function(_z){ return     (__easings()).__sqrt(1 - power((_z - 1), 2)); });
    _add_easing("in out circ", function(_z)
    {
        if (_z >= 0.5) return (1 + (__easings()).__sqrt(1 - power(-2*_z + 2, 2)))/2;
                       return (1 - (__easings()).__sqrt(1 - power( 2*_z,     2)))/2;
    });
        
    __c1 = 1.70158;
    __c2 = __c1 * 1.525;
    __c3 = __c1 + 1;

    _add_easing("in back",     function(_z){ return     (__easings()).__c3*power(_z,     3) - (__easings()).__c1*power(_z,     2); });
    _add_easing("out back",    function(_z){ return 1 + (__easings()).__c3*power(_z - 1, 3) + (__easings()).__c1*power(_z - 1, 2); });
    _add_easing("in out back", function(_z)
    {
        if (_z >= 0.5) return (power(2*_z - 2, 2) * (((__easings()).__c2 + 1) * (_z*2 - 2) + (__easings()).__c2) + 2)/2;
                       return (power(2*_z,     2) * (((__easings()).__c2 + 1) * (_z*2    ) - (__easings()).__c2)    )/2;
    });
        
    __c4 = __2pi/3;

    _add_easing("in elastic", function(_z)
    {
        if (_z == 0.0) return 0;
        if (_z == 1.0) return 1;

        return -power(2, 10*_z - 10) * sin((_z*10 - 10.75)*__c4);
    });

    _add_easing("out elastic", function(_z)
    {
        if (_z == 0.0) return 0;
        if (_z == 1.0) return 1;

        return power(2, -10*_z) * sin((_z*10 - 0.75)*__c4) + 1;
    });        

    __c5 = __2pi/4.5;

    _add_easing("in out elastic", function(_z)
    {
        if (_z == 0.0) return 0;
        if (_z == 1.0) return 1;
        if (_z >= 0.5) return   power(2, -20*_z + 10) * sin((20*_z - 11.125)*__c5) /2 + 1;
                       return -(power(2,  20*_z - 10) * sin((20*_z - 11.125)*__c5))/2;
    });
       
    _add_easing("smootheststep", function(_z){ return -20*power(_z, 7) + 70*power(_z, 6) - 84*power(_z, 5) + 35*power(_z, 4); });
    _add_easing("smootherstep",  function(_z){ return _z*_z*_z*(_z*(_z*6 - 15) + 10); });
    _add_easing("smoothstep",    function(_z){ return _z*_z*(3 - 2 * _z); });

})(); return __instance; };

#macro EASE_LINEAR        (__easings()).__linear
#macro EASE_IN_QUAD       (__easings()).__in_quad
#macro EASE_IN_CUBIC      (__easings()).__in_cubic
#macro EASE_IN_QUART      (__easings()).__in_quart
#macro EASE_IN_QUINT      (__easings()).__in_quint
#macro EASE_IN_SINE       (__easings()).__in_sine
#macro EASE_IN_EXPO       (__easings()).__in_expo
#macro EASE_IN_BOUNCE     (__easings()).__in_bounce
#macro EASE_IN_CIRC       (__easings()).__in_circ
#macro EASE_IN_BACK       (__easings()).__in_back
#macro EASE_IN_ELASTIC    (__easings()).__in_elastic
#macro EASE_OUT_QUAD      (__easings()).__out_quad
#macro EASE_OUT_CUBIC     (__easings()).__out_cubic
#macro EASE_OUT_QUART     (__easings()).__out_quart
#macro EASE_OUT_QUINT     (__easings()).__out_quint
#macro EASE_OUT_SINE      (__easings()).__out_sine
#macro EASE_OUT_EXPO      (__easings()).__out_expo
#macro EASE_OUT_BOUNCE    (__easings()).__out_bounce
#macro EASE_OUT_CIRC      (__easings()).__out_circ
#macro EASE_OUT_BACK      (__easings()).__out_back
#macro EASE_OUT_ELASTIC   (__easings()).__out_elastic
#macro EASE_INOUT_QUAD    (__easings()).__in_out_quad
#macro EASE_INOUT_CUBIC   (__easings()).__in_out_cubic
#macro EASE_INOUT_QUART   (__easings()).__in_out_quart
#macro EASE_INOUT_QUINT   (__easings()).__in_out_quint
#macro EASE_INOUT_SINE    (__easings()).__in_out_sine
#macro EASE_INOUT_EXPO    (__easings()).__in_out_expo
#macro EASE_INOUT_BOUNCE  (__easings()).__in_out_bounce
#macro EASE_INOUT_CIRC    (__easings()).__in_out_circ
#macro EASE_INOUT_BACK    (__easings()).__in_out_back
#macro EASE_INOUT_ELASTIC (__easings()).__in_out_elastic
#macro EASE_SMOOTHSTEP    (__easings()).__smoothstep
#macro EASE_SMOOTHERSTEP  (__easings()).__smootherstep
#macro EASE_SMOOTHESTSTEP (__easings()).__smootheststep
