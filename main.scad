// Copyright 2019 a.j.buxton@gmail.com
// CC BY-NC-ND 4.0

$fn = 64;


w = 150.5;
h = 65;



module dpad() {
    offset(r=0.5) offset(r=-0.5) offset(r=-0.5) offset(r=0.5) union() {
        square([6.5, 19], center=true);
        square([19, 6.5], center=true);
    }
}

module btn() {
    translate([0, 16/2]) circle(d=8.1);
    translate([0, -16/2]) circle(d=8.1);

    translate([17/2, 0]) circle(d=8.1);
    translate([-17/2, 0]) circle(d=8.1);

}

module smlbtn() {
    translate([9.5/2, 0]) circle(d=5.2);
    translate([-9.5/2, 0]) circle(d=5.2);

}

module analog() {
    circle(d=15);
}

// btn 8.3 diameter

// smlbtn 5.2 diameter

//dpad();




module dpad_pos() {
    translate([(w/2)-16.75, -9.25]) children();
}

module analog_pos() {
    translate([(w/2)-16.75, 17.5]) children();
}

module btn_pos() {
    translate([18.5-(w/2), 10]) children();
}

module smlbtn_pos() {
    translate([18.5-(w/2), -17.5]) children();
}

module led_pos() {
    translate([-48.75, 30]) children();
    translate([-56.75, 30]) children();
    translate([-64.75, 30]) children();
}

module screw_pos() {
    translate([143.5/2, 0]) {
        translate([0, -29]) children();
        translate([0, 0]) children();
        translate([0, 29]) children();
        translate([-30, 0]) {
            //translate([0, -29]) children();
            translate([0, 0]) children();
            translate([0, 29]) children();
        }
    }
    translate([-143.5/2, 0]) {
        translate([0, -29]) children();
        translate([0, 0]) children();
        translate([0, 29]) children();
        translate([30, 0]) {
            translate([0, -29]) children();
            //translate([0, 0]) children();
            translate([0, 29]) children();
        }
    }
}

module screen() {
    linear_extrude(height=5) translate([0, 0]) square([77.5, 65], center=true);
    linear_extrude(height=5, center=true) translate([0, 2]) square([73, 56], center=true);
}


module outline() {
    offset(5) offset(-5) square([150.5, 65], center=true);
}




module front() {
    difference() {
        linear_extrude(height=6.5, convexity=10) difference() {
            offset(2) outline();


        }
        translate([0, 0, 3.0]) linear_extrude(height=5) outline();
        translate([0, 0, 1.505]) screen();
        dpad_pos() translate([0, 0, -43]) sphere(r=45);
        btn_pos() translate([0, 0, -53]) sphere(r=55);
        analog_pos() translate([0, 0, 0]) scale([1, 1, 0.3]) sphere(d=25);
    }
}


module shell() {
    difference() {
        linear_extrude(height=7.6, convexity=10) difference() {
            offset(1.8) outline();
            outline();

        }
    }
}

module control_cutout() {

    translate([56.75, -1, 7]) {
        cube([32, 58, 10], center=true);
        //cube([26, 52, 10], center=true);
    }

}

module front2() {
    shell();

    difference() {
        union() {
            screw_pos() cylinder(r=2, h=6);
            difference() {

                linear_extrude(height=7.6, convexity=10) difference() {
                    outline();

                    btn_pos() circle(d=28);
                    smlbtn_pos() offset(r=2) hull() smlbtn();
                    dpad_pos() circle(d=26);
                    analog_pos() circle(d=20);



                }

                led_pos() translate([0, 1, 4]) cube([4, 3, 6], center=true);
                translate([0, 0, 6.0]) linear_extrude(height=5) outline();
                translate([0, 0, 1.05]) screen();

                control_cutout();
                mirror([1, 0, 0]) control_cutout();
            }
        }
        translate([0, 0, 2]) linear_extrude(height=20) screw_pos() circle(d=1.4);
    }


}



color("lime") {
    //projection(cut=true) translate([0, 0, -2])
        front2();
}


color("lightgrey") {
    btn_pos() btn();
    smlbtn_pos() smlbtn();
    dpad_pos() dpad();
    analog_pos() analog();
}
