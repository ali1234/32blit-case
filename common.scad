// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

w = 150.5;
h = 65;


button_radius = 8.4/2;
button_height = 4.5;

// the case cutout
button_hole_diameter = 29;



button_letters = ["A", "B", "X", "Y"];
button_rotations = [180, 90, 270, 0];
button_colours = ["red", "yellow", "lightblue", "lightgreen"];





module outline() {
    offset(5) offset(-5) square([w, h], center=true);
}


module shell() {
    difference() {
        linear_extrude(height=7.6, convexity=10) difference() {
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


module dpad() {
    offset(r=0.5) offset(r=-0.5) offset(r=-0.5) offset(r=0.5) union() {
        square([6.5, 19], center=true);
        square([19, 6.5], center=true);
    }
}

module smlbtn() {
    translate([9.5/2, 0]) children(); //circle(d=5.2);
    translate([-9.5/2, 0]) children();

}

module analog() {
    circle(d=15);
}
