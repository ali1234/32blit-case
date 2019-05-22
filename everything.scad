// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

include <common.scad>;

use <front.scad>;
use <back.scad>;
use <dpad.scad>;
use <analog.scad>;
use <buttons.scad>;
use <small_buttons.scad>;

main_colour = [0.7, 1.0, 0.4];
insert_colour = "grey";

translate([0, 0, -6.6]) mirror([1, 0]) color(main_colour) back();


module front_assembly() {
    {
        color(main_colour) front();
        btn_pos() {
            translate([0, 0, 4.5]) rotate([0, 180, 0]) buttons();
            translate([0, 0, 1.6]) color(insert_colour) button_insert();
        }
        smlbtn_pos() {
            translate([0, 0, 4.5]) rotate([0, 180, 0]) small_buttons();
            translate([0, 0, 1.6]) color(insert_colour) small_button_insert();
        }
        dpad_pos() {
            translate([0, 0, 4.5]) rotate([0, 180, 0]) linear_extrude(height=5) dpad();
            translate([0, 0, 1.6]) color(insert_colour) dpad_insert();
        }
        analog_pos() {
            color([0.2, 0.2, 0.2]) translate([0, 0, -3]) analog();
            color(insert_colour) translate([0, 0, 3.4]) analog_insert();
        }
    }
}

translate([0, 0, 7.6]) rotate([0, 180, 0]) front_assembly();

color("black") {
    screen();
    translate([0, 0, 2])mirror([1, 0]) analog_pos() square(20, center=true);
}

translate([0, -80, 0]) rotate([0, 0, 180]) front_assembly();
