// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

include <common.scad>;

RES = is_undef(RES) ? 2 : RES;

$fa = 8/RES; $fs = 2/RES;

module dpad_outline() {
    offset(r=0.5) offset(r=-0.5) offset(r=-0.5) offset(r=0.5) union() {
        square([6.5, 19], center=true);
        square([19, 6.5], center=true);
    }
}


module elipse(a, b, c, d) {
    translate([a, b]) scale([c, d]) circle(r=1);
}

module dpad_half_r() {

    x = 14;
    y = 7;
    z = 24.2;

    a = x/2;
    b = y/2;
    c = (z-x)/2;
    d = (x-7.0)/2;

    hull() {
        mirrorf() elipse(a, b, c, d);
    }
}

module dpad_rubber() {
    dpad_half_r();
    rotate(90) dpad_half_r();
}



module dpad_insert() {
    front_thickness = 2;

    difference() {
        union() {
            base_insert(front_thickness);
            linear_extrude(height=front_thickness+0.2, convexity=2) offset(-1.2) dpad_rubber();
            linear_extrude(height=front_thickness+0.3, convexity=2) difference() {
                offset(-1.2) dpad_rubber();

                offset(-1.4) dpad_rubber();
            }
        }

        translate([0, 0, front_thickness-0.2]) cylinder(d=13, h=10);

        translate([0, 0, -0.1]) linear_extrude(height=20, convexity=2) dpad_outline();
    }
}


module dpad() {

    height_before_rounding = 7;

    difference() {
        union() {
            intersection() {
                linear_extrude(height=height_before_rounding, convexity=2, scale=0.93) offset(0.4) offset(-0.75) dpad_outline();
                linear_extrude(height=height_before_rounding, convexity=2, scale=1) offset(0.4) offset(-0.8) dpad_outline();
            }
            cylinder(d=12, h=0.5);
        }
        translate([0, 0, height_before_rounding]) scale([1.7, 1.7, 0.3]) sphere(d=20);
        translate([0, 0, -1]) cylinder(d=2.7, h=4);
    }
}


module dpad_nub() {

    //cylinder(d=3.9, h=2.4);
    cylinder(d=2.4, h=2.4);
    hull() {
        translate([0, 0, 2.4]) sphere(d=2.4);
        translate([0, 0, 3.4]) sphere(d=2);
    }

}



WHICH = undef;
if (WHICH == "insert") {
    dpad_insert();
}
else if (WHICH == "dpad") {
    dpad();
}
else if (WHICH == "nub") {
    dpad_nub();
}
else {
    dpad_insert();
    translate([0, 0, 10]) dpad();
    translate([0, 0, 20]) dpad_nub();
}


