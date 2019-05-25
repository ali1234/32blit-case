// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

include <common.scad>;

use <front.scad>;
use <back.scad>;
use <dpad.scad>;
use <analog.scad>;
use <buttons.scad>;
use <small_buttons.scad>;

main_colour = "lightgrey";
insert_colour = "grey";

translate([0, 0, -6.6]) mirror([1, 0]) color(main_colour) back($fn=RES);

RES=32;

module front_assembly() {
    color(main_colour) front($fn=RES);
    btn_pos() {
        translate([0, 0, 4.5]) rotate([0, 180, 0]) buttons($fn=RES);
        translate([0, 0, 1.5]) color(insert_colour) button_insert($fn=RES);
    }
    smlbtn_pos() {
        translate([0, 0, 4.5]) rotate([0, 180, 0]) color(main_colour)  small_buttons($fn=RES);
        translate([0, 0, 1.5]) color(insert_colour) small_button_insert($fn=RES);
    }
    dpad_pos() {
        translate([0, 0, 3.75]) rotate([0, 180, 0]) color([0.1, 0.1, 0.1]) dpad($fn=RES);
        translate([0, 0, 1.5]) color(insert_colour) dpad_insert($fn=RES);
    }
    analog_pos() {
        color([0.2, 0.2, 0.2]) translate([0, 0, -2]) analog($fn=RES);
        color(insert_colour) translate([0, 0, 3.4]) analog_insert($fn=RES);
    }
}

translate([0, 0, 7.6]) rotate([0, 180, 0]) front_assembly();

color("black") {
    screen();
    translate([0, 0, 2])mirror([1, 0]) analog_pos() square(20, center=true);
}

translate([0, -80, 0]) rotate([0, 0, 180]) front_assembly();
