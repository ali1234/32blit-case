// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

include <common.scad>;

RES = is_undef(RES) ? 2 : RES;

$fa = 8/RES; $fs = 2/RES;


battery_thickness=8;
back_thickness=1.0;
screw_thickness = 2.0;


module rkeep(x) {
    rotate(x) children();
    children();
}


module flat_back(back_depth=6.2) {
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
                        led_pos() translate([-1.5, 0, back_depth+back_thickness-0.2]) cube([7, 7, 8], center=true);
                        difference() {
                            translate([0, 0, back_thickness]) linear_extrude(height=10) outline();

                            translate([-2.1, 0, 0]) led_pos() cube([10.4, 9, 20], center=true);
                        }
                    }
                }

                translate([0, 0, 1.5]) screw_pos(false) cylinder(d=2.8, h=20);
                translate([0, 0, -screw_thickness]) screw_pos(false) cylinder(d=5.8, h=back_depth+back_thickness);
            }
            translate([0, 0, 0.01]) 
                linear_extrude(height=back_depth+0.99, convexity=4) {
                translate([w/2 - 76.5, h/2]) square([1.2, 3], center=true);
                translate([w/2 - 59.6, h/2]) square([1.2, 3], center=true);
                translate([w/2 - 64.4, h/2]) square([1.2, 3], center=true);
                translate([w/2 - 93, h/2]) square([1.2, 3], center=true);
                translate([w/2 - 105.2, h/2]) square([18.4, 3], center=true);
                //translate([w/2 - 113.8, h/2]) square([1.2, 3], center=true);
                translate([w/2 - 50.6, h/2]) square([1.2, 3], center=true);
            }
        }

        // usb
        translate([w/2 - 55.1, h/2, back_depth-0.5]) cube([8.2, 10, 3.1], center=true);
        // reset
        //translate([w/2 - 70.1, h/2, 5.1]) cube([4.2, 10, 3.1], center=true);
        translate([w/2 - 70.1, h/2, back_depth-0.8]) rotate([90, 0, 0]) cylinder(d=1.5, h=10, center=true);

        // SD
        translate([w/2 - 83, h/2, back_depth-0.1]) cube([12, 10, 2.3], center=true);
        // debug
//        translate([w/2 - 104.75, h/2, 5.0]) cube([2.54*6.05, 10, 4.5], center=true);
        translate([w/2 - 105.25, h/2, back_depth-0.6]) cube([2.54*6.3, 10, 4.5], center=true);
        
        translate([-0.2, 0.2]) rkeep(180) {
            translate([67.1, -29.3, 10]) rotate([0, 25]) rotate(90) hull() {
                cube([5.92, 5, 5], center=true);
            }
        }
        
        translate([-0.1, 0.2]) mirror([0, 1])  {
            translate([65.8, -26, 8]) rotate([0, 7]) rotate(90) hull() {
                cube([6, 5.5, 7], center=true);
            }
        }
    }


    translate([w/2 - 55.1, h/2.1, back_depth - 2.6]) difference() {
        cylinder(d=10, h=3.6);
        cylinder(d=8.4, h=20, center=true);
        translate([-5, 0.1, -1]) cube(10);

    }


    translate([w/2 - 70.1, h/2, back_depth - 2.6]) difference() {
        cylinder(d=6, h=3.6);
        cylinder(d=4.7, h=20, center=true);
        translate([-10, 0.1, -1]) cube(20);
    }


    translate([w/2 - 84.7, h/2.1, back_depth - 2.6]) difference() {
        cylinder(d=17.3, h=3.6);
        cylinder(d=15.7, h=20, center=true);
        translate([-10, 0.1, -1]) cube(20);
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


module backo() {
    difference() {
        intersection() {
            back();
            cube([1000, 1000, 6], center=true);
        }
        translate([-35, 10, -10]) cube([80, 30, 20]);
    }
}

rotate([180, 0, 0]) mirror([1, 0]) back();
