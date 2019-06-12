// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

include <common.scad>;

use <small_buttons.scad>;

RES = undef;

$fn = RES ? RES : 32;


module screen() {
    linear_extrude(height=5) translate([0, 0]) square([77.5, 65], center=true);
    linear_extrude(height=5, center=true) translate([0, 3]) square([73, 56], center=true);
}


module control_cutout(l) {
    translate([57, l?0.75:-2, 6.25]) {
        linear_extrude(height=10, center=true) offset(4) offset(-4) square([34, l ? 63.5 : 58], center=true);
        //cube([26, 52, 10], center=true);
    }
}


module support_ring(d) {
    rotate(45) twobytwo() {
        translate([d/2, 0, 0]) rotate(90) support();
    }
}


module front() {
    shell();

    difference() {
        union() {
            screw_pos() cylinder(r=2, h=6);

            btn_pos() {
                cylinder(d=button_hole_diameter+2, h=3.5);
                support_ring(button_hole_diameter+2);
            }
            dpad_pos() {
                cylinder(d=button_hole_diameter+2, h=3.5);
                support_ring(button_hole_diameter+2);
            }

            analog_pos() {
                cylinder(d=24.5, h=5);
                translate([0, 0, 1]) support_ring(24.5);
            }

            smlbtn_pos() {
                linear_extrude(height=3.5) offset(r=1) small_button_hole();
                scale([1.0, 0.72, 1.1]) support_ring(24.5);
            }

            difference() {
                linear_extrude(height=7.6) outline();

                translate([0, 1, 3.5]) led_pos() {
                    cube([5, 3, 6], center=true);
                    translate([0.1, 0, 0]) cylinder(d=2, h=10, center=true);
                }
                translate([0, 0, 6.0]) linear_extrude(height=5) outline();
                translate([0, 0, 1.01]) screen();
                control_cutout(true);
                mirror([1, 0, 0]) control_cutout(false);
            }
        }
        translate([0, 0, 1.5]) screw_pos() cylinder(d=1.7, h=20);

        translate([0, 0, -1]) {
            btn_pos() cylinder(d=button_hole_diameter, h=20);
            dpad_pos() cylinder(d=button_hole_diameter, h=20);
            analog_pos() cylinder(d=analog_hole_diameter, h=20);
            smlbtn_pos() linear_extrude(height=20) small_button_hole();
        }

        translate([0, 0, 1.6]) linear_extrude(height=20, convexity=2) {
            btn_pos() {
                square([8, 32], center=true);
                square([32, 8], center=true);
            }
            dpad_pos() {
                square([8, 32], center=true);
                square([32, 8], center=true);
            }
            smlbtn_pos() {
                square([8, 20], center=true);
                square([32, 8], center=true);
            }
        }

        translate([0, 0, 3.6]) linear_extrude(height=20) {
            analog_pos() {
                translate([0, -6, 0]) square([8, 28], center=true);
                square([28, 8], center=true);
            }
        }
    }
}


front();





