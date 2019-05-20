$fn=64;

module twobytwo() {
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
    z = 28.75;

    a = x/2;
    b = y/2;
    c = (z-x)/2;
    d = (x-7.0)/2;

    hull() {
        twobytwo() elipse(a, b, c, d);
    }
}

module dpad_r() {

    linear_extrude(height=1.6) difference() {
        circle(d=32);
        offset(0.5) union() {
            dpad_half_r();
            rotate(90) dpad_half_r();
        }
    }

    linear_extrude(height=3.0) difference() {
        circle(d=28.2);
        offset(0.5) union() {
            dpad_half_r();
            rotate(90) dpad_half_r();
        }
    }

    twobytwo() translate([8.5, 8.5, 2.6]) sphere(d=1.8);
}


dpad_r();

//8.65x18.65
