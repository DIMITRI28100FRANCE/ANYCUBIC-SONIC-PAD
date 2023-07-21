#================== MACROS fluidd / mainsail (Web interfaces) ===================
[gcode_macro PAUSE]
description: Pause the actual running print
rename_existing: PAUSE_BASE
# change this if you need more or less extrusion
variable_extrude: 1.0
gcode:
  ##### read E from pause macro #####
  {% set E = printer["gcode_macro PAUSE"].extrude|float %}
  ##### set park positon for x and y #####
  # default is your max posion from your printer.cfg
  {% set x_park = printer.toolhead.axis_maximum.x|float - 5.0 %}
  {% set y_park = printer.toolhead.axis_maximum.y|float - 5.0 %}
  ##### calculate save lift position #####
  {% set max_z = printer.toolhead.axis_maximum.z|float %}
  {% set act_z = printer.toolhead.position.z|float %}
  {% if act_z < (max_z - 2.0) %}
      {% set z_safe = 2.0 %}
  {% else %}
      {% set z_safe = max_z - act_z %}
  {% endif %}
  ##### end of definitions #####
  PAUSE_BASE
  G91
  {% if printer.extruder.can_extrude|lower == 'true' %}
    G1 E-{E} F2100
  {% else %}
    {action_respond_info("Extruder not hot enough")}
  {% endif %}
  {% if "xyz" in printer.toolhead.homed_axes %}
    G1 Z{z_safe} F900
    G90
    G1 X{x_park} Y{y_park} F6000
  {% else %}
    {action_respond_info("Printer not homed")}
  {% endif %}

[gcode_macro RESUME]
description: Resume the actual running print
rename_existing: RESUME_BASE
gcode:
  ##### read E from pause macro #####
  {% set E = printer["gcode_macro PAUSE"].extrude|float %}
  #### get VELOCITY parameter if specified ####
  {% if 'VELOCITY' in params|upper %}
    {% set get_params = ('VELOCITY=' + params.VELOCITY)  %}
  {%else %}
    {% set get_params = "" %}
  {% endif %}
  ##### end of definitions #####
  {% if printer.extruder.can_extrude|lower == 'true' %}
    G91
    G1 E{E} F2100
  {% else %}
    {action_respond_info("Extruder not hot enough")}
  {% endif %}
  RESUME_BASE {get_params}

[gcode_macro CANCEL_PRINT]
description: Cancel the actual running print
rename_existing: CANCEL_PRINT_BASE
gcode:
  TURN_OFF_HEATERS
  {% if "xyz" in printer.toolhead.homed_axes %}
    G91
    G1 Z4.5 F300
    G90
  {% else %}
    {action_respond_info("Printer not homed")}
  {% endif %}
    G28 X Y
  {% set y_park = printer.toolhead.axis_maximum.y|float - 5.0 %}
    G1 Y{y_park} F2000
    M84
  CANCEL_PRINT_BASE


#======================================================
# SET_PRINT_STATS_INFO with Cura
#======================================================
# Klipper provides the SET_PRINT_STATS_INFO macro so that slicers can set the Layer Count and
# Current Layer information, but Cura doesn't have a way to use this directly (the only "g-code
# on layer change" post-processing plugin doesn't support variables), so the only way to work 
# around is by adding a replacement post-processing script and a specific macro to Klipper.
#
# To add the script to Cura, use the following steps:
# - Open Cura
# - Open the "Extensions" menu, then "Post processing", and click on "Modify G-Code"
# - Click the "Add Script" button, and select "Search and Replace" from the options
# - On the "Search" textbox, enter this: ;(LAYER|LAYER_COUNT)\:(\d+)
# - On the "Replace" textbox, enter this: ;\1:\2\n_CURA_SET_PRINT_STATS_INFO \1=\2
# - Tick the "Use Regular Expressions" checkbox
#- Click Close
#
#[print_stats]
# Pass slicer info (layer count, layer current) to Klipper

[gcode_macro _CURA_SET_PRINT_STATS_INFO]
gcode:
  {% if params.LAYER_COUNT is defined %}
    SET_PRINT_STATS_INFO TOTAL_LAYER={params.LAYER_COUNT}
  {% endif %}
  {% if params.LAYER is defined %}
    SET_PRINT_STATS_INFO CURRENT_LAYER={(params.LAYER | int) + 1}
  {% endif %}