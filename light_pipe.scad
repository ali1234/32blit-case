// print in vase mode!

RES = undef;

$fn = RES ? RES : 32;

module light_pipe() {
    cylinder(d=2.95, h=5, center=true);
}

light_pipe();
