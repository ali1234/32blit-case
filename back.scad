// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

include <common.scad>;

RES = undef;

$fn = RES ? RES : 32;


back_depth=6.2;
back_thickness=1.0;
screw_thickness = 2.0;


debug_pos = (58 - (w/2));
reset_pos = ((w/2) - 68.7);
usb_pos = ((w/2) - 58.2);
sd_pos = ((w/2) - 43.4);


module back() {
    difference() {
        union() {
            shell(height=back_depth+back_thickness);
            difference() {
                union() {
                    screw_pos(false) cylinder(d=7.4, h=back_depth+back_thickness);
                    linear_extrude(height=back_thickness) outline();
                }

                translate([0, 0, 1.5]) screw_pos(false) cylinder(d=2.8, h=20);
                translate([0, 0, -screw_thickness]) screw_pos(false) cylinder(d=5.8, h=back_depth+back_thickness);
            }
            translate([usb_pos, h/2, back_depth-2.2]) cube([11, 3, 6.4], center=true);
            translate([reset_pos, h/2, back_depth-2.2]) cube([37.5, 3, 6.4], center=true);
            translate([sd_pos, h/2, back_depth-2.2]) cube([18, 3, 6.4], center=true);
            translate([debug_pos, h/2, back_depth-2.2]) cube([29.5, 3, 6.4], center=true);
            //translate([w/2 - 50.6, h/2, back_depth-2.2]) cube([1.2, 3, 6.4], center=true);
        }

        // usb
        translate([usb_pos, h/2, back_depth-0.5]) cube([8.5, 10, 3.1], center=true);

        // reset
        translate([reset_pos, h/2, back_depth+0.2]) cube([3, 10, 2.5], center=true);
        translate([reset_pos, (h/2)-1.1, back_depth+0.2]) cube([7, 4, 5], center=true);

        // SD
        translate([sd_pos, h/2, back_depth-0.1]) cube([14, 10, 2.3], center=true);
        translate([sd_pos-0.5, (h/2)-1.3, back_depth-0.1]) cube([16, 4, 2.3], center=true);

        // debug
        translate([debug_pos, h/2, back_depth-0.6]) cube([27, 10, 4.5], center=true);
    }

    mirrorf() {
        translate([w/2, h/6]) rotate(-90) support();
        translate([6*w/17, h/2]) support();
        translate([2*w/17, h/2]) support();

        scale([1, 1, 1.25]) translate([0, 0, 1]) {
            translate([w/4, h/6]) cube([w/2, 0.75, 1], center=true);
            translate([6*w/17, h/4]) cube([0.75, h/2, 1], center=true);
            translate([2*w/17, h/4]) cube([0.75, h/2, 1], center=true);
        }
    }

}

//intersection() {
    mirror([1, 0]) back();
//    union() {
//        translate([0, 76]) cube([300, 100, 100], center=true);
        //translate([100, 60]) cube([100, 100, 100], center=true);
//    }
//}
