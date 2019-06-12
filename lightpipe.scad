// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

$fn = 64;

cube([4.8, 2.8, 5.5], center=true);
translate([0.1, 0, 4]) cylinder(d=1.8, h=5.5, center=true);

translate([-0.6, -0.4, -3]) cube([3.6, 2, 4], center=true);
