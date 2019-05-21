// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

include <common.scad>;

$fn=64;

module analog() {
    circle(d=15);
}

module analog_insert() {
    linear_extrude(height=1.4) difference() {
        union() {
            circle(d=analog_hole_diameter-0.3);
            translate([0, -1, 0]) square([8, analog_hole_diameter], center=true);
            square([analog_hole_diameter+1, 8], center=true);
        }
        analog();
    }

}


analog_insert();