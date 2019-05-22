// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

include <common.scad>;

RES = undef;

$fn = RES ? RES : 16;



module dpad() {
    offset(r=0.5) offset(r=-0.5) offset(r=-0.5) offset(r=0.5) union() {
        square([6.5, 19], center=true);
        square([19, 6.5], center=true);
    }
}



module dpad_insert() {

    front_thickness = 1.2;
/*
    translate([0, 0, front_thickness]) difference() {
        linear_extrude(height=1.6, convexity=2) offset(1) rubber() button_base();
        translate([0, 0, -0.1]) linear_extrude(height=10, convexity=4) button_positions() offset(0.4) button_base();
        translate([0, 0, 1.45]) cube([5.7, 4.8, 3], center=true);
    }
*/

    difference() {
        union() {
            cylinder(d=button_hole_diameter-0.3, h=front_thickness);
            linear_extrude(height=front_thickness, convexity=2) {
                square([8, 30], center=true);
                square([30, 8], center=true);
            }
        }
        translate([0, 0, -0.1]) linear_extrude(height=20) dpad();
    }
}


dpad_insert();
