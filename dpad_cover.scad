// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

include <controls.scad>;

$fn=64;

module twobytwo() {
    children();
    mirror([1, 0]) children();
    mirror([0, 1]) children();
    mirror([1, 0]) mirror([0, 1]) children();
}

module dpad_c() {
    difference() {
        union() {
            linear_extrude(height=3, convexity=10) circle(d=28.7);
            linear_extrude(height=1, convexity=10) {
                square([8, 30], center=true);
                square([30, 8], center=true);
            }
        }
        twobytwo() translate([8.5, 8.5, 0]) sphere(d=2.3);
        translate([0, 0, -1]) linear_extrude(height=10, convexity=10) dpad();
        translate([0, 0, 51]) sphere(r=50.5);
    }


}


dpad_c();

//8.65x18.65
