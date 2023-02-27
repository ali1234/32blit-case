// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

RES = is_undef(RES) ? 2 : RES;

$fa = 8/RES; $fs = 2/RES;

module mirrorf() {
    children();
    mirror([1, 0]) children();
    mirror([0, 1]) children();
    mirror([1, 0]) mirror([0, 1]) children();
}

module elipse(a, b, c, d) {
    translate([a, b]) scale([c, d]) circle(r=1);
}

module dpad_half_r() {

    x = 14;
    y = 7;
    z = 24.2;

    a = x/2;
    b = y/2;
    c = (z-x)/2;
    d = (x-7.0)/2;

    hull() {
        mirrorf() elipse(a, b, c, d);
    }
}

module dpad_r() {
    linear_extrude(height=3.0) difference() {
        circle(d=28.2);
        offset(0.5) union() {
            dpad_half_r();
            rotate(90) dpad_half_r();
        }
    }

    twobytwo() translate([8.5, 8.5, 2.6]) sphere(d=1.9);
}


dpad_r();

//8.65x18.65
