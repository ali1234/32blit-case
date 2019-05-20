FILES = button_A.stl button_B.stl button_X.stl button_Y.stl button_holder.stl front.stl back.stl
INCLUDES = common.scad util.scad


all: $(FILES)


front.stl: front.scad $(INCLUDES)
	/home/al/Source/openscad/openscad -D RES=64 -o $@ $<

back.stl: back.scad $(INCLUDES)
	/home/al/Source/openscad/openscad -D RES=64 -o $@ $<

button_%.stl: buttons.scad
	/home/al/Source/openscad/openscad -D RES=64 -D WHICH=\"$*\" -o $@ $<

clean:
	rm -f *.stl
