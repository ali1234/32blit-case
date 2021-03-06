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
    offset(2.75) offset(-2.75) square([19.1, 9], center=true);

}


module small_button_base() {
    difference() {
        offset(0.5) offset(-0.5) square(5.9, center=true);
    }
}


module small_button_top(r, label="?") {
    difference() {
        scale([1, 1, 0.25]) sphere(r=r);
        translate([0, 0, r*0.05]) linear_extrude(height=10, convexity=4) {
            if (label == 0) {
                difference() {
                    intersection() {
                        translate([0, 0.25]) square([2.2, 2.5], center=true);
                        translate([0, -1.5]) rotate(45) square(4.3, center=true);
                    }
                    offset(-0.4)intersection() {
                        translate([0, 0.25]) square([2.2, 2.5], center=true);
                        translate([0, -1.5]) rotate(45) square(4.3, center=true);
                    }
                }
            } else {
                square([2.2, 0.4], center=true);
                translate([0, 0.9]) square([2.2, 0.4], center=true);
                translate([0, -0.9]) square([2.2, 0.4], center=true);
            }
        }
        translate([0, 0, 5.45]) cube([10, 10, 10], center=true);
    }
}


module small_button(hole=false) {
    color("lightgrey") {
        difference() {
            union() {
                linear_extrude(height=1.2) small_button_base();
                cylinder(r=small_button_radius, h=small_button_height);
                // for letters
                //translate([0, 0, small_button_height-0.0]) button_top(small_button_radius, small_button_letters[$which]);
                // for icons
                translate([0, 0, small_button_height-0.0]) small_button_top(small_button_radius, $which);
            }
            if (hole) translate([0, 0, -0.01]) cylinder(d=1.8, h=3);
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
        translate([0, 0, 1]) linear_extrude(height=2.2, convexity=2) offset(-0.8) small_rubber();
        linear_extrude(height=10, convexity=2) small_button_positions() offset(0.35) small_button_base();
        //linear_extrude(height=10) offset(-1.5) small_rubber();

    }
}


RES = is_undef(RES) ? 1 : RES;

$fa = 8/RES; $fs = 0.8/RES;


WHICH = undef;
HOLE = undef;

if (WHICH == "H") {
    small_button(hole = HOLE, $which = 0);
}
else if (WHICH == "M") {
    small_button(hole = HOLE, $which = 1);
}
else if (WHICH == "insert") {
    small_button_insert();
}
else if (1) {
    translate([0, 0, -10]) rotate([0, 180, 0]) small_button_insert();
    small_button_positions() small_button();
}
