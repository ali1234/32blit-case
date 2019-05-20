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
        translate([0, 0, -1]) linear_extrude(height=10, convexity=10) btn() circle(d=8.6);
        translate([0, 0, -0.15]) linear_extrude(height=1, convexity=10) btn() difference() {
            circle(d=11.35);
            translate([-10.1, 0, 0]) square(10, center=true);
            translate([10.35, 0, 0]) square(10, center=true);
        }

        translate([0, 0, 4.7]) hull() rotate_extrude() translate([11.3, 0]) circle(3.5);
        //translate([0, 0, 51.5]) sphere(r=50.5);

    }
    linear_extrude(height=1, convexity=10) btn() translate([-1.8, 0, 0]) {
            translate([0, 5.2, 0]) circle(d=0.8);
            translate([0, -5.2, 0]) circle(d=0.8);
    }


}


dpad_c();

//8.65x18.65
