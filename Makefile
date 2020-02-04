FILES = front.stl back.stl analog_insert.stl button_A.stl button_B.stl button_X.stl button_Y.stl button_blank.stl button_hole_A.stl button_hole_B.stl button_hole_X.stl button_hole_Y.stl button_hole_blank.stl button_insert.stl small_button_H.stl small_button_M.stl small_button_hole_H.stl small_button_hole_M.stl small_button_insert.stl dpad_insert.stl dpad_dpad.stl dpad_nub.stl lightpipe.stl
INCLUDES = common.scad
OPENSCAD = openscad
RES=64

all: $(FILES)


front.stl: front.scad $(INCLUDES)
	$(OPENSCAD) -D RES=$(RES) -o $@ $<

back.stl: back.scad $(INCLUDES)
	$(OPENSCAD) -D RES=$(RES) -o $@ $<

analog_%.stl: analog.scad $(INCLUDES)
	$(OPENSCAD) -D RES=$(RES) -o $@ $<

button_%.stl: buttons.scad $(INCLUDES)
	$(OPENSCAD) -D RES=$(RES) -D HOLE=false -D WHICH=\"$*\" -o $@ $<

button_hole_%.stl: buttons.scad $(INCLUDES)
	$(OPENSCAD) -D RES=$(RES) -D HOLE=true -D WHICH=\"$*\" -o $@ $<

small_button_%.stl: small_buttons.scad $(INCLUDES)
	$(OPENSCAD) -D RES=$(RES) -D HOLE=false -D WHICH=\"$*\" -o $@ $<

small_button_hole_%.stl: small_buttons.scad $(INCLUDES)
	$(OPENSCAD) -D RES=$(RES) -D HOLE=true -D WHICH=\"$*\" -o $@ $<

dpad_%.stl: dpad.scad $(INCLUDES)
	$(OPENSCAD) -D RES=$(RES) -D WHICH=\"$*\" -o $@ $<

lightpipe.stl: lightpipe.scad $(INCLUDES)
	$(OPENSCAD) -D RES=$(RES) -o $@ $<


clean:
	rm -f $(FILES)
