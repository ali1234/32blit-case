// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

module dpad() {
    offset(r=0.5) offset(r=-0.5) offset(r=-0.5) offset(r=0.5) union() {
        square([6.5, 19], center=true);
        square([19, 6.5], center=true);
    }
}

module btn() {
    translate([0, 15.5/2]) rotate(270) children(); //circle(d=8.1);
    translate([0, -15.5/2]) rotate(90) children();

    translate([16/2, 0]) rotate(180) children();
    translate([-16/2, 0]) rotate(0) children();

}

module smlbtn() {
    translate([9.5/2, 0]) children(); //circle(d=5.2);
    translate([-9.5/2, 0]) children();

}

module analog() {
    circle(d=15);
}
