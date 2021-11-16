easings.gml

Easing for GMS2

Easings (EASE.*)
  LINEAR (none)
  SMOOTHSTEP
  SMOOTHERSTEP
  INVERSE_SMOOTHSTEP
  IN_/​OUT_/​INOUT_*
    QUAD, CUBIC, QUART, QUINT, SINE, 
    EXPO, BOUNCE, CIRC, BACK, ELASTIC

e.g. EASE.INOUT_ELASTIC(x)

OR

ease
  function: Eases value within unit interval
  argument: Number, Easing (Optional)
  returned: Number

tween
  function: Eases positional value
  argument: Start, End, Position, Easing (Optional)
  returned: Number
    
Reference
  wikipedia.org/wiki/Smoothstep
  easings.net

@offalynne, 2021
MIT licensed, use as you please
