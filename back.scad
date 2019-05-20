// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

include <common.scad>;

$fn = 64;


back_depth=5.6;
back_thickness=1.0;
screw_thickness = 1.0;


module back() {
    color("lime") {
        shell(height=back_depth+back_thickness);

        difference() {
            union() {
                screw_pos(false) cylinder(d=6.8, h=back_depth+back_thickness);


                difference() {

                    linear_extrude(height=back_depth+back_thickness, convexity=10) difference() {
                        outline();
                    }

                    led_pos() translate([-1, 1, back_depth+back_thickness-0.2]) cube([6, 8, 6], center=true);
                    difference() {
                        translate([0, 0, back_thickness]) linear_extrude(height=10) outline();
                        translate([-1, 0, 0]) led_pos() cube([10, 10, 20], center=true);
                    }

                }
            }
            translate([0, 0, 1.5]) linear_extrude(height=20, convexity=10) screw_pos(false) circle(d=2.2);
            translate([0, 0, -screw_thickness]) linear_extrude(height=back_depth+back_thickness, convexity=10) screw_pos(false) circle(d=5.4);
        }
    }
}



mirror([1, 0]) back();

