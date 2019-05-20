include <controls.scad>;

$fn=64;

module twobytwo() {
    children();
    mirror([1, 0]) children();
    mirror([0, 1]) children();
    mirror([1, 0]) mirror([0, 1]) children();
}

module dpad_c() {
    difference() {
        union() {
            linear_extrude(height=3, convexity=10) circle(d=28.7);
            linear_extrude(height=1, convexity=10) {
                square([8, 30], center=true);
                square([30, 8], center=true);
            }
        }
        twobytwo() translate([8.5, 8.5, 0]) sphere(d=2.1);
        translate([0, 0, -1]) linear_extrude(height=10, convexity=10) btn() circle(d=8.1);;
        translate([0, 0, 4.7]) hull() rotate_extrude() translate([11.3, 0]) circle(3.5);
    }


}


dpad_c();

//8.65x18.65
