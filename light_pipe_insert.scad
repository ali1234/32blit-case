// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

include <common.scad>;

RES = is_undef(RES) ? 1 : RES;

$fa = 8/RES; $fs = 0.2/RES;


module light_pipe_insert(neg=false) {
    offs = neg ? -0.1 : 0;
    translate([0, 0, 1.01]) {
        led_individual_pos() {
            //cube([5, 5, 6], center=true);
            //cube([4, 4, 50], center=true);
            cylinder(d=5-offs, h=3-offs, center=false);
            if (neg) cylinder(d=3, h=20, center=true);
        }
    }
    translate([0, 0, 4.76]) {
        led_pos() {
            intersection() {
                translate([0, 1.2, 0]) cube([24-offs, 10-offs, 2.5-offs], center=true);
                cube([24-offs, 10-offs, 2.5-offs], center=true);
                rotate(45) cube([20-offs, 20-offs, 3-offs], center=true);
            }
        }
    }
}

mirror([0, 0, 1]) difference() {
    light_pipe_insert();
    led_individual_pos() {
        cylinder(d=2.4, h=20, center=true);
        cylinder(d=3, h=5);
    }
};
