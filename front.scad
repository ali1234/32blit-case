// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

include <common.scad>;

RES = undef;

$fn = RES ? RES : 16;


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


module front() {
    shell();

    difference() {
        union() {
            screw_pos() cylinder(r=2, h=6);

            linear_extrude(height=3.5) {

                btn_pos() circle(d=button_hole_diameter+2);
                dpad_pos() circle(d=button_hole_diameter+2);

                smlbtn_pos() offset(r=5) hull() smlbtn() circle(d=5.2);
            }

            analog_pos() cylinder(d=24.5, h=5);

            difference() {

                linear_extrude(height=7.6) difference() {
                    outline();
       /*             btn_pos() circle(d=29);
                    smlbtn_pos() offset(r=4) hull() smlbtn() circle(d=5.2);
                    dpad_pos() circle(d=29);
                    analog_pos() circle(d=22);*/
                }

                led_pos() translate([0, 1, 3.5]) cube([5, 3, 6], center=true);
                translate([0, 0, 6.0]) linear_extrude(height=5) outline();
                translate([0, 0, 1.01]) screen();

                control_cutout(true);
                mirror([1, 0, 0]) control_cutout(false);
            }
        }
        translate([0, 0, 1.5]) linear_extrude(height=20) screw_pos() circle(d=1.7);

        translate([0, 0, -1]) linear_extrude(height=20) {
            btn_pos() circle(d=button_hole_diameter);
            dpad_pos() circle(d=button_hole_diameter);

            smlbtn_pos() offset(r=4) hull() smlbtn() circle(d=5.2);
            analog_pos() circle(d=analog_hole_diameter);
        }

        translate([0, 0, 1.6]) linear_extrude(height=20) {
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
                translate([0, -6, 0]) square([8, 30], center=true);
                square([32, 8], center=true);
            }
        }
    }
}


front();





