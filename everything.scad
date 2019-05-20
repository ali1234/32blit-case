// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

include <common.scad>;

use <front.scad>;
use <back.scad>;
use <buttons.scad>;


translate([0, 0, -8]) back();

rotate([0, 180, 0]) translate([0, 0, -8]) {
    front();
    btn_pos() translate([0, 0, 4]) rotate([0, 180, 0]) buttons();
    smlbtn_pos() smlbtn() circle(d=5.2);
    dpad_pos() dpad();
    analog_pos() analog();
}
