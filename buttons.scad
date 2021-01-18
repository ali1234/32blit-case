// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

include <common.scad>;



module button_positions() {
    positions = [[16.8/2, 0], [0, -16/2], [0, 16/2],   [-16.8/2, 0]];
    for($which = [0:3]) translate(positions[$which]) children();
}


module rubber() {
    positions = [[16/2, 0], [0, -15.5/2], [0, 15.5/2],   [-16/2, 0]];
    hull() {
        for($which = [0, 3]) translate(positions[$which]) children();
    }
    hull() {
        for($which = [1, 2]) translate(positions[$which]) children();
    }

}



module button_base() {

    difference() {
        circle(d=10);
        rotate(button_rotations[$which]) {
            translate([9.5, 0, 0]) square(10, center=true);
            translate([-9.3, 0, 0]) square(10, center=true);

            translate([-2.3, 0, 0]) {
                    translate([0, 4.5, 0]) circle(d=1.5);
                    translate([0, -4.5, 0]) circle(d=1.5);
            }
        }
    }

}


module text_offset(amt) {
    offset(amt) offset(amt) offset(-amt) children();
}


module button_top(r, label="?") {
    difference() {
        scale([1, 1, 0.25]) sphere(r=r);
        if (label != " ") {
            translate([0, 0, r*0.08]) linear_extrude(height=10, convexity=4) text_offset(0.2*r/button_radius) text(label, size=4*r/button_radius, halign="center", valign="center");
            translate([0, 0, 5.75]) cube([10, 10, 10], center=true);
        }
    }
}


module button(letter=true, hole=false) {
    color(button_colours[$which]) {
        difference() {
            union() {
                linear_extrude(height=1.2) button_base();
                cylinder(r=button_radius, h=button_height);
                if (letter) {
                    translate([0, 0, button_height-0.0]) button_top(button_radius, button_letters[$which]);
                } else {
                    translate([0, 0, button_height-0.0]) button_top(button_radius, " ");
                }
            }
            if (hole) translate([0, 0, -0.01]) cylinder(d=1.8, h=3);
        }
    }
}

module buttons() {
    button_positions() button();
}


module button_insert() {
    front_thickness = 2;
    difference() {
        union() {
            base_insert(front_thickness);
            translate([0, 0, front_thickness]) linear_extrude(height=1.2, convexity=2) offset(1) rubber() button_base();
        }

        translate([0, 0, -5.1]) button_positions() cylinder(r=button_radius+0.4, h=20);
        translate([0, 0, 1.4]) {
            linear_extrude(height=10, convexity=4) button_positions() offset(0.35) button_base();
            translate([0, 0, 1.6]) cube([5.7, 4.8, 3], center=true);
        }
    }
}


RES = is_undef(RES) ? 1 : RES;

$fa = 8/RES; $fs = 2/RES;


WHICH = undef;
HOLE = undef;

if (WHICH == "A") {
    button(hole = HOLE, $which = 0);
}
else if (WHICH == "B") {
    button(hole = HOLE, $which = 1);
}
else if (WHICH == "X") {
    button(hole = HOLE, $which = 2);
}
else if (WHICH == "Y") {
    button(hole = HOLE, $which = 3);
}
else if (WHICH == "blank") {
    button(letter = false, hole = HOLE, $which = 0);
}
else if (WHICH == "insert") {
    button_insert();
}
else if (1) {
    translate([0, 0, 3]) rotate([0, 180, 0]) button_insert();
    button_positions() button();
}
