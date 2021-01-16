// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

w = 151;
h = 65;


// abxy and dpad holes
button_hole_diameter = 29;
// analog stick
analog_hole_diameter = 21;

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


module mirrorf() {
    children();
    mirror([1, 0]) children();
    mirror([0, 1]) children();
    mirror([1, 0]) mirror([0, 1]) children();
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
    offset(3) offset(-3) square([w, h], center=true);
}


module support() {
    scale(0.3) translate([-5, -9.5]) intersection() {
        cube(10);
        rotate([-45, 0, 0]) cube(20);
    }
}


module shell(height=7.6) {
    difference() {
        linear_extrude(height=height, convexity=2) difference() {
            offset(1.6) outline();
            offset(-0.05) outline();
        }
        translate([0, 0, height-1.6]) linear_extrude(height=height, convexity=2) {
            translate([20.8, 1, 0]) offset(1.1, $fn=2) offset(-1.1) square([39, h], center=true);
        }
    }
}


module dpad_pos() {
    translate([(w/2)-18.5, -8.75]) children();
}

module analog_pos() {
    translate([(w/2)-18.5, 20.25]) children();
}

module analog_supports() {
    translate([6.9, 9.28]) children();
    translate([-11.2, -6.68]) children();
}

module btn_pos() {
    translate([-57.9, 7.9]) children();
}

module smlbtn_pos() {
    translate([-57.9, -19.75]) children();
}

module led_pos() {
    translate([-57.9, 27]) {
        children();
    }
}

module led_individual_pos() {
    led_pos() {
        translate([3.9, 0]) children();
        //translate([0, 0]) children();
        translate([-3.9, 0]) children();
    }
}

module screw_pos(internal=true) {
    translate([0, 0.2, 0]) {
        translate([144/2, 0]) {
            translate([0, -29]) children();
            if (internal) translate([0, 0]) children();
            translate([0, 29]) rotate(90) children();
            if (internal) translate([-29, 0]) {
                translate([0, -29]) children();
                //translate([0, 0]) children();
                translate([0, 29]) children();
            }
        }
        translate([-145/2, 0]) {
            translate([0, -29]) rotate(270) children();
            if (internal) translate([0, 0]) children();
            translate([0, 29]) rotate(180) children();
            if (internal) translate([29, 0]) {
                translate([0, -29]) children();
                //translate([0, 0]) children();
                translate([0, 29]) children();
            }
        }
    }
}






