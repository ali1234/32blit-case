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



module mirrorf() {
    children();
    mirror([1, 0]) children();
    mirror([0, 1]) children();
    mirror([1, 0]) mirror([0, 1]) children();
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

        translate([0, 0, front_thickness]) cylinder(d=13, h=10);

        translate([0, 0, -0.1]) linear_extrude(height=20, convexity=2) dpad();
    }
}


dpad_insert();
