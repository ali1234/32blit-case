FILES = button_A.stl button_B.stl button_X.stl button_Y.stl button_holder.stl

all: $(FILES)


button_%.stl: buttons.scad
	/home/al/Source/openscad/openscad -D RES=64 -D WHICH=\"$*\" -o $@ $<





