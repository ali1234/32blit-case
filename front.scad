// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

include <common.scad>;

use <small_buttons.scad>;
use <light_pipe_insert.scad>;

RES = undef;

$fn = RES ? RES : 32;


module screen() {
    linear_extrude(height=5) translate([0, 0]) square([77.5, 65], center=true);
    linear_extrude(height=5, center=true) translate([0, 3]) square([72, 55], center=true);
}


module control_cutout(l) {
    translate([57, l?2.4:-2.8, 6.25]) {
        linear_extrude(height=10, center=true) offset(4) offset(-4) square([34, l ? 60.25 : 52], center=true);
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

    translate([0, (-h/2)-0.2, 1]) {
        translate([65, 0]) cylinder(r=1, h=6.6);
        translate([50, 0]) cylinder(r=1, h=6.6);
        translate([-65, 0]) cylinder(r=1, h=6.6);
        translate([-50, 0]) cylinder(r=1, h=6.6);
    }

    difference() {
        union() {
            screw_pos() cylinder(r=2, h=6.01);

            btn_pos() {
                cylinder(d=button_hole_diameter+2, h=3.5);
                support_ring(button_hole_diameter+2);
            }
            dpad_pos() {
                cylinder(d=button_hole_diameter+2, h=3.5);
                support_ring(button_hole_diameter+2);
            }

            analog_pos() {
                cylinder(d=23, h=3.0);
                translate([0, 0, 0.01]) support_ring(23);
                analog_supports() {
                    difference() {
                        cylinder(d=3.2, h=6.05);
                        translate([0, 0, 2]) cylinder(d=1.2, h=7);
                    }
                }
            }

            smlbtn_pos() {
                linear_extrude(height=3.5) offset(r=1) small_button_hole();
                scale([1.0, 0.72, 1.1]) support_ring(24.5);
            }

            difference() {
                linear_extrude(height=7.6) outline();

                light_pipe_insert(neg=true);

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
                translate([0, -0.2]) square([8, 31], center=true);
                square([31, 8], center=true);
            }
            dpad_pos() {
                square([8, 31], center=true);
                square([31, 8], center=true);
            }
            smlbtn_pos() {
                square([8, 16], center=true);
                square([28, 8], center=true);
            }
        }

        translate([0, 0, 1.25]) linear_extrude(height=20) {
            analog_pos() {
                square([8, 23], center=true);
                square([23, 8], center=true);
            }
        }
    }
}

//intersection() {
    front();
//    translate([-1, 26.7]) btn_pos() cube([41, 23, 30], center=true);
//}





