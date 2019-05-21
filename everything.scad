// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

include <common.scad>;

use <front.scad>;
use <back.scad>;
use <analog.scad>;
use <buttons.scad>;


main_colour = "lightgrey";
insert_colour = "grey";

translate([0, 0, -6.65]) mirror([1, 0]) color(main_colour) back();


module front_assembly() {
    {
        color(main_colour) front();
        btn_pos() {
            translate([0, 0, 4.5]) rotate([0, 180, 0]) buttons();
            translate([0, 0, 1.6]) color(insert_colour) button_insert();
        }
        smlbtn_pos() smlbtn() circle(d=5.2);
        dpad_pos() dpad();
        analog_pos() {
            color([0.1, 0.1, 0.1]) translate([0, 0, -3]) analog();
            color(insert_colour) translate([0, 0, 3.4]) analog_insert();
        }
    }
}

translate([0, 0, 7.65]) rotate([0, 180, 0]) front_assembly();


translate([0, -80, 0]) rotate([0, 0, 180]) front_assembly();
