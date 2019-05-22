// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

include <util.scad>;
include <common.scad>;

use <buttons.scad>;


module small_button_positions() {
    positions = [[9.5/2, 0], [-9.5/2, 0]];
    for($which = [0:1]) translate(positions[$which]) children();
}

module small_button_hole() {
    offset(r=4) hull() small_button_positions() circle(d=5.2);
}

module small_rubber() {
    hull() small_button_positions() small_button_base();

}


module small_button_base() {

    difference() {
        square(small_button_radius*2, center=true);
/*
        rotate(small_button_rotations[$which]) {
            translate([8.5, 0, 0]) square(10, center=true);
            translate([-8, 0, 0]) square(10, center=true);

            translate([-2.3, 0, 0]) {
                    translate([0, 4.5, 0]) circle(d=1.5);
                    translate([0, -4.5, 0]) circle(d=1.5);
            }
        }

 */
    }

}

module small_button() {
    color("lightgrey") {
        union() {
            linear_extrude(height=1.2) small_button_base();
            cylinder(r=small_button_radius, h=button_height);
            translate([0, 0, button_height-0.0]) button_top(small_button_radius, small_button_letters[$which]);
        }
    }
}

module small_buttons() {
    small_button_positions() small_button();
}



module small_button_insert() {

    front_thickness = 1.2;

    translate([0, 0, front_thickness]) difference() {
        linear_extrude(height=1.6, convexity=2) offset(1) small_rubber() small_button_base();
        translate([0, 0, -0.1]) linear_extrude(height=10, convexity=4) small_button_positions() offset(0.4) small_button_base();

    }

    difference() {
        union() {
            linear_extrude(height=front_thickness) offset(r=-0.15) small_button_hole();
            linear_extrude(height=front_thickness, convexity=2) {
                square([8, 16], center=true);
                square([26, 8], center=true);
            }
        }
        translate([0, 0, -0.1]) small_button_positions() cylinder(r=small_button_radius+0.4, h=10);
    }
}



RES = undef;

$fn = RES ? RES : 16;


WHICH = undef;
if (WHICH == "H") {
    small_button($which = 0);
}
else if (WHICH == "M") {
    small_button($which = 1);
}
else if (WHICH == "insert") {
    small_button_insert();
}
else if (1) {
    translate([0, 0, -10]) rotate([0, 180, 0]) small_button_insert();
    small_button_positions() small_button();
}
