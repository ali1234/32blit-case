// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

include <common.scad>;

$fn = 64;


module back() {
    color("lime") {
        shell();

        difference() {
            union() {
                screw_pos(false) cylinder(r=3.4, h=7.6);


                difference() {

                    linear_extrude(height=7.6, convexity=10) difference() {
                        outline();
                    }

                    led_pos() translate([-1, 1, 6.5]) cube([6, 8, 6], center=true);
                    difference() {
                        translate([0, 0, 1.0]) linear_extrude(height=10) outline();
                        translate([-1, 0, 0]) led_pos() cube([10, 10, 20], center=true);
                    }

                }
            }
            translate([0, 0, 1.5]) linear_extrude(height=20, convexity=10) screw_pos(false) circle(d=2.2);
            translate([0, 0, -1]) linear_extrude(height=7.6, convexity=10) screw_pos(false) circle(d=5.4);
        }
    }
}



mirror([1, 0]) back();

