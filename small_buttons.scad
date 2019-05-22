// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0


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
    offset(2) offset(-2) square([18.9, 9.1], center=true);

}


module small_button_base() {
    difference() {
        offset(0.5) offset(-0.5) square(6.0, center=true);
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
    front_thickness = 2;
    difference() {
        union() {
            linear_extrude(height=4.4) offset(r=-0.15) small_button_hole();
            linear_extrude(height=front_thickness, convexity=2) {
                square([8, 16], center=true);
                square([26, 8], center=true);
            }
        }
//        linear_extrude(height=4.4, convexity=2) offset(2) offset(-2) square([19, 9], center=true);
        translate([0, 0, -0.1]) small_button_positions() cylinder(r=small_button_radius+0.4, h=10);
        translate([0, 0, 1.4]) {
            linear_extrude(height=10, convexity=4) small_button_positions() offset(0.35) small_button_base();
        }
        translate([0, 0, 2]) linear_extrude(height=20, convexity=2) small_rubber();
    }

    difference() {
        translate([0, 0, 1]) linear_extrude(height=1.6, convexity=2) offset(-0.5) small_rubber();
        linear_extrude(height=10, convexity=2) small_button_positions() offset(0.35) small_button_base();
        //linear_extrude(height=10) offset(-1.5) small_rubber();

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
