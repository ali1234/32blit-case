// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

include <common.scad>;

RES = undef;

$fn = RES ? RES : 32;


back_depth=5.6;
back_thickness=1.0;
screw_thickness = 2.0;


module back() {
    difference() {
        union() {
            shell(height=back_depth+back_thickness);
            difference() {
                union() {
                    screw_pos(false) cylinder(d=7.4, h=back_depth+back_thickness);
                    difference() {
                        linear_extrude(height=back_depth+back_thickness) difference() {
                            outline();
                        }
                        led_pos() translate([-1, 1, back_depth+back_thickness-0.2]) cube([6, 8, 6], center=true);
                        difference() {
                            translate([0, 0, back_thickness]) linear_extrude(height=10) outline();

                            translate([-1, 0, 0]) led_pos() cube([10, 10, 20], center=true);
                        }
                    }
                }

                translate([0, 0, 1.5]) screw_pos(false) cylinder(d=2.8, h=20);
                translate([0, 0, -screw_thickness]) screw_pos(false) cylinder(d=5.8, h=back_depth+back_thickness);
            }
            translate([w/2 - 76.5, h/2, 3.4]) cube([1.2, 3, 6.4], center=true);
            translate([w/2 - 59.4, h/2, 3.4]) cube([1.2, 3, 6.4], center=true);
            translate([w/2 - 64.4, h/2, 3.4]) cube([1.2, 3, 6.4], center=true);
            translate([w/2 - 93, h/2, 3.4]) cube([1.2, 3, 6.4], center=true);
            translate([w/2 - 105.2, h/2, 3.4]) cube([18.4, 3, 6.4], center=true);
            //translate([w/2 - 113.8, h/2, 3.4]) cube([1.2, 3, 6.4], center=true);
            translate([w/2 - 50.8, h/2, 3.4]) cube([1.2, 3, 6.4], center=true);
        }

        // usb
        translate([w/2 - 55.1, h/2, 5.1]) cube([7.8, 10, 3.1], center=true);
        // reset
        //translate([w/2 - 70.1, h/2, 5.1]) cube([4.2, 10, 3.1], center=true);
        translate([w/2 - 70.1, h/2, 4.8]) rotate([90, 0, 0]) cylinder(d=1.5, h=10, center=true);

        // SD
        translate([w/2 - 83, h/2, 5.5]) cube([12, 10, 2.3], center=true);
        // debug
//        translate([w/2 - 104.75, h/2, 5.0]) cube([2.54*6.05, 10, 4.5], center=true);
        translate([w/2 - 105.25, h/2, 5.0]) cube([2.54*6.3, 10, 4.5], center=true);
    }


    translate([w/2 - 55.1, h/2.1, 0]) difference() {
        cylinder(d=9.6, h=6.6);
        cylinder(d=8, h=20, center=true);
        translate([-5, 0.1, -1]) cube(10);
        cube([10, 6, 5], center=true);
        cube([5, 10, 5], center=true);
    }


    translate([w/2 - 84.7, h/2.1, 0]) difference() {
        cylinder(d=17.3, h=6.6);
        cylinder(d=15.7, h=20, center=true);
        translate([-10, 0.1, -1]) cube(20);
        cube([20, 9, 7], center=true);
        translate([5, -10, 0]) cube([9, 9, 7], center=true);
        translate([-5, -10, 0]) cube([9, 9, 7], center=true);
    }


    mirrorf() {
        translate([w/2, h/4.5]) rotate(-90) support();
        translate([6*w/17, h/2]) support();
        translate([2*w/17, h/2]) support();

        scale([1, 1, 1.25]) translate([0, 0, 1]) {
            translate([w/4, h/4.5]) cube([w/2, 0.75, 1], center=true);
            translate([6*w/17, h/4]) cube([0.75, h/2, 1], center=true);
            translate([2*w/17, h/4]) cube([0.75, h/2, 1], center=true);
        }
    }

}


mirror([1, 0]) back();
