// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

$fn = 64;


module outline(y) {
    cube([4.9, 2.9, y], center=true);
}

module lightpipe() {
    difference() {

        x=2.5;

        y=8.5;

        union() {
            difference() {
                outline(y);
                cube([3.9, 1.9, y-0.5], center=true);
                translate([0, -1, 4.25]) cube([3.9, 2.9, 6.5], center=true);

            }

            intersection() {
                outline(y);
                union() {
                    translate([0, 1.3, (y/2)+0.7]) rotate([45, 0, 0]) cube([4.9, 4.9, 4.8], center=true);
                    translate([x, 0, 4]) cube([4, 4, 7], center=true);
                    translate([x+1.43, 0, 0.47]) rotate([0, 45, 0]) cube([4.9, 4.9, 4.8], center=true);
                }
            }
        }
        translate([x, 0, 4]) cube([3, 3, 6], center=true);

        translate([0, -1.5, 2]) cube([5, 2, 2], center=true);
        translate([0, -2, 4]) cube([5, 2, 6], center=true);
    }
}

lightpipe();
