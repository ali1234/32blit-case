// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

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
