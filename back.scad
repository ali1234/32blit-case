// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

include <common.scad>;

RES = undef;

//$fn = RES ? RES : 32;
$fs=0.5;
$fa=2;

battery_thickness=8;
back_thickness=1;
screw_thickness = 2.0;


debug_pos = (58 - (w/2));
reset_pos = ((w/2) - 68.7);
usb_pos = ((w/2) - 58.2);
sd_pos = ((w/2) - 43.4);


module flat_back(back_depth=6.2) {
    difference() {
        union() {
            shell(height=back_depth+back_thickness);
            difference() {
                union() {
                    linear_extrude(height=back_depth+back_thickness) intersection() {
                        offset(1) outline();
                        screw_pos(false) {
                            circle(d=7.4);
                            square(3.7);
                            rotate(-90) square(3.7);
                            rotate(-180) square(3.7);
                        }
                    }
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
        //translate([w/2, h/6]) rotate(-90) support();
        //translate([6*w/17, h/2]) support();
        //translate([2*w/17, h/2]) support();
        scale([46, 1, 1]) translate([0, h/2]) support();
/*
        scale([1, 1, 1]) translate([0, 0, 1]) {
            translate([w/4, h/6]) cube([w/2, 0.75, 1], center=true);
            translate([6*w/17, h/4]) cube([0.75, h/2, 1], center=true);
            translate([2*w/17, h/4]) cube([0.75, h/2, 1], center=true);
        }*/
    }

}

module profile_helper_x(x=2) {
    translate([55.3, 0]) children();
    translate([-55.3, 0]) children();
}

module profile_x(offs=0) {
    translate([0, 0, 5]) rotate([90, 0, 0]) linear_extrude(height=59, center=true) 
    offset(offs) hull() {
        translate([0, 10]) profile_helper_x() scale([2, 1]) circle(r=6.9);
        translate([0, 4]) profile_helper_x() scale([2.5, 0.65]) circle(r=6.9);
        //translate([0, 25]) profile_helper(4) circle(r=30);
    }
}


module profile(offs=0){
    minkowski() {
        profile_x(offs);
        sphere(4.6);
    }
}

module curved_back(back_depth) {
    intersection() {
        flat_back(back_depth=back_depth);
        profile(0);
    }

    difference() {
        intersection() {
            difference() {
                profile(0);
                profile(-1.4);
            }
            
            linear_extrude(height=battery_thickness+1, convexity=8) difference() {
                outline();
                screw_pos(internal=false) circle(d=6.1);
            }
        }
    }
}

       
module back() {
    depth = battery_thickness;
    difference() {
        translate([0, 0, -depth-1]) curved_back(depth);
        //translate([0, 0, -depth-2]) linear_extrude(height=10) square(26, center=true);
    }
}

rotate([180, 0, 0]) mirror([1, 0]) back(); 
linear_extrude(height=3) intersection() {
    translate([-41, -32]) square([73.5, 10]);
    union() {
        translate([-41, -46]) difference() {
            offset(3.9) offset(-4) square([73.25, 20]);
            offset(2.8) offset(-4) square([73.25, 20]);
        }
        translate([-23.3, -46.5])square([1.5, 20]);
        translate([-12.3, -46.5])square([1.5, 20]);
        translate([0, -46.5])square([1.5, 20]);
    }
}
//mirror([0, 0, 1]) shell();