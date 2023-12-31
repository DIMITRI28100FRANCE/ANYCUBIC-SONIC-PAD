[stepper_x]
step_pin: PF0
dir_pin: !PF1
enable_pin: !PD7
microsteps: 16
rotation_distance: 40
endstop_pin: ^!PE5
position_min: 0
position_endstop: 0
position_max: 300
homing_speed: 30.0

[stepper_y]
step_pin: PF6
dir_pin: PF7
enable_pin: !PF2
microsteps: 16
rotation_distance: 40
endstop_pin: PL7
position_endstop: 0
position_max: 300
homing_speed: 30.0

[stepper_z]
step_pin: PL3
dir_pin: PL1
enable_pin: !PK0
microsteps: 16
rotation_distance: 4
endstop_pin: ^!PD3
position_endstop: 0.0
position_max: 305
homing_speed: 5.0

[stepper_z1]
step_pin: PC1
dir_pin: PC3
enable_pin: !PC7
microsteps: 16
rotation_distance: 4
endstop_pin: ^!PL6

[extruder]
step_pin: PA4
dir_pin: PA6
enable_pin: !PA2
microsteps: 16
rotation_distance: 7.592
nozzle_diameter: 0.400
filament_diameter: 1.750
heater_pin: PB4
sensor_type: ATC Semitec 104GT-2
sensor_pin: PK5
control: pid
pid_Kp: 15.717
pid_Ki: 0.569
pid_Kd: 108.451
min_temp: 0
max_temp: 260

[heater_fan extruder_fan]
pin: PL5

[heater_bed]
heater_pin: PH5
sensor_type: EPCOS 100K B57560G104F
sensor_pin: PK6
control: pid
pid_Kp: 74.883
pid_Ki: 1.809
pid_Kd: 775.038
min_temp: 0
max_temp: 120

[fan]
pin: PH6

[mcu]
serial: /dev/serial/by-id/usb_serial_1

[printer]
kinematics: cartesian
max_velocity: 300
max_accel: 2000
max_z_velocity: 10
max_z_accel: 60

[heater_fan stepstick_fan]
pin: PH4

[virtual_sdcard]
path: ~/printer_data/gcodes
on_error_gcode: CANCEL_PRINT

[include webinterface.cfg]
[include macros.cfg]

# [resonance_tester]
# accel_chip: adxl345
# accel_per_hz: 70
# probe_points:
#      150,150,10

# [adxl345]
# cs_pin: rpi:None
# spi_speed: 2000000
# spi_bus: spidev2.0

# [mcu rpi]
# serial: /tmp/klipper_host_mcu

#*# <---------------------- SAVE_CONFIG ---------------------->
#*# DO NOT EDIT THIS BLOCK OR BELOW. The contents are auto-generated.
#*#
#*# [input_shaper]
#*# shaper_type_x = 2hump_ei
#*# shaper_freq_x = 76.8
#*# shaper_type_y = mzv
#*# shaper_freq_y = 25.8
