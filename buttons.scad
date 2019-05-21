// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

include <util.scad>;
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


module text_offset() {
    amt = 0.15;
    offset(amt) offset(amt) offset(-amt) children();

}


module button_top() {
    difference() {
        //hull() rotate_extrude() translate([button_radius-1, 0]) circle(r=1);
        scale([1, 1, 0.25]) sphere(r=button_radius);
        translate([0, 0, button_radius*0.10]) linear_extrude(height=10, convexity=10) text_offset() text(button_letters[$which], size=4, halign="center", valign="center");
    }
}


module button() {
    color(button_colours[$which]) {
        difference() {
            union() {
                linear_extrude(height=1.2, convexity=10) button_base();
                linear_extrude(height=button_height, convexity=10) circle(r=button_radius);
                translate([0, 0, button_height-0.01]) button_top();
            }
            //translate([0, 0, -0.01]) cylinder(r1=2.8, r2=2.5, h=0.55);
        }

    }
}

module buttons() {
    button_positions() button();
}



module button_insert() {

    front_thickness = 1.2;

    translate([0, 0, front_thickness]) difference() {
        union() {
//            cylinder(d=button_hole_diameter-0.3, h=1);
            linear_extrude(height=1.6, convexity=10) offset(1) rubber() button_base();
        }

        translate([0, 0, -0.1])linear_extrude(height=10, convexity=10) button_positions() offset(0.4) button_base();
//        twobytwo() translate([8.5, 8.5, 0]) cylinder(d=2.1, h=10);
        translate([0, 0, 1.45]) cube([5.7, 4.8, 3], center=true);
    }

    difference() {
        union() {
            cylinder(d=button_hole_diameter-0.3, h=front_thickness);
            linear_extrude(height=front_thickness, convexity=10) {
                square([8, 30], center=true);
                square([30, 8], center=true);
            }
        }
        translate([0, 0, -0.1]) linear_extrude(height=10, convexity=10) button_positions() offset(0.4) circle(r=button_radius);
    }
}





WHICH = undef;
RES = undef;

$fn = RES ? RES : 16;
if (WHICH == "A") {
    button($which = 0);
}
else if (WHICH == "B") {
    button($which = 1);
}
else if (WHICH == "X") {
    button($which = 2);
}
else if (WHICH == "Y") {
    button($which = 3);
}
else if (WHICH == "insert") {
    button_insert();
}
else if (1) {
    translate([0, 0, -10]) rotate([0, 180, 0]) button_insert();
    button_positions() button();
}
