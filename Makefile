FILES = front.stl back.stl dpad_grip.stl dpad_cover.stl btn_grip.stl btn_cover.stl
INCLUDES = controls.scad positions.scad


all: $(FILES)

%.stl: %.scad $(INCLUDES)
	/home/al/Source/openscad/openscad -o $@ $<

