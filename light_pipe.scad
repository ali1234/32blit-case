// print in vase mode!

RES = is_undef(RES) ? 1 : RES;

$fa = 8/RES; $fs = 0.8/RES;

module light_pipe() {
    cylinder(d=2.95, h=5, center=true);
}

light_pipe();
