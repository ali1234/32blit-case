// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

w = 150.5;
h = 65;


// abxy and dpad holes
button_hole_diameter = 29;
// analog stick
analog_hole_diameter = 22.5;

button_radius = 8.4/2;
button_height = 4.5;

button_letters = ["A", "B", "X", "Y"];
button_rotations = [180, 90, 270, 0];
button_colours = [[1.0, 0.1, 0.1], [1, 0.8, 0], [0.1, 0.3, 1], [0, 0.8, 0]];


small_button_radius = 5.2/2;
small_button_height = 3.8;
small_button_letters = ["H", "M"];
small_button_rotations = [180, 0];


module twobytwo() {
    children();
    rotate(90) children();
    rotate(180) children();
    rotate(270) children();
}

module base_insert(thickness, extra=0) {
    translate([0, 0, -extra]) cylinder(d=button_hole_diameter-0.5, h=thickness+extra);
    linear_extrude(height=thickness, convexity=2) {
        square([7.9, 30], center=true);
        square([30, 7.9], center=true);
    }
    twobytwo() translate([6.9, 6.9, 0]) intersection() {
        cylinder(r=4.4, h=4.4);
        cube(10);
    }
    if (extra > 0) twobytwo() {
        translate([15, -4, -extra]) cube([1, 8, extra+2]);
    }
}

module outline() {
    offset(5) offset(-5) square([w, h], center=true);
}


module shell(height=7.6) {
    difference() {
        linear_extrude(height=height, convexity=2) difference() {
            offset(1.6) outline();
            outline();

        }
    }
}


module dpad_pos() {
    translate([(w/2)-17.5, -9]) children();
}

module analog_pos() {
    translate([(w/2)-16.75, 21.25]) children();
}

module btn_pos() {
    translate([18.7-(w/2), 10.4]) children();
}

module smlbtn_pos() {
    translate([18.7-(w/2), -17.5]) children();
}

module led_pos() {
    translate([-48.75, 30]) children();
    translate([-56.75, 30]) children();
    translate([-64.75, 30]) children();
}

module screw_pos(internal=true) {
    translate([0, 0.2, 0]) {
        translate([143.5/2, 0]) {
            translate([0, -29]) children();
            if (internal) translate([0, 0]) children();
            translate([0, 29]) children();
            if (internal) translate([-30, 0]) {
                //translate([0, -29]) children();
                translate([0, 0]) children();
                translate([0, 29]) children();
            }
        }
        translate([-144.5/2, 0]) {
            translate([0, -29]) children();
            if (internal) translate([0, 0]) children();
            translate([0, 29]) children();
            if (internal) translate([30, 0]) {
                translate([0, -29]) children();
                //translate([0, 0]) children();
                translate([0, 29]) children();
            }
        }
    }
}


// TODO: Remove these





