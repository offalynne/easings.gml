easings.gml

Ease and Tween for GMS2

ease
  function: Eases number within unit interval
  argument: Number, Easing type (Optional)
  returned: Number

tween
  function: Eases positional value
  argument: Start, End, Position, Easing type (Optional)
  returned: Number

Easing types (Enum: EASE.*)
  LINEAR (none)
  SMOOTHSTEP
  SMOOTHERSTEP
  INVERSE_SMOOTHSTEP
  IN_/​OUT_/​INOUT_*
    QUAD, CUBIC, QUART, QUINT, SINE, 
    EXPO, BOUNCE, CIRC, BACK, ELASTIC
    
Reference
  wikipedia.org/wiki/Smoothstep
  easings.net

@offalynne, 2021
MIT licensed, use as you please
