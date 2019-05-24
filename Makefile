FILES = front.stl back.stl analog_insert.stl button_A.stl button_B.stl button_X.stl button_Y.stl button_insert.stl small_button_H.stl small_button_M.stl small_button_insert.stl dpad_insert.stl dpad_dpad.stl dpad_nub.stl
INCLUDES = common.scad
OPENSCAD = openscad

all: $(FILES)


front.stl: front.scad $(INCLUDES)
	$(OPENSCAD) -D RES=64 -o $@ $<

back.stl: back.scad $(INCLUDES)
	$(OPENSCAD) -D RES=64 -o $@ $<

analog_%.stl: analog.scad $(INCLUDES)
	$(OPENSCAD) -D RES=64 -o $@ $<

button_%.stl: buttons.scad $(INCLUDES)
	$(OPENSCAD) -D RES=64 -D WHICH=\"$*\" -o $@ $<

small_button_%.stl: small_buttons.scad $(INCLUDES)
	$(OPENSCAD) -D RES=64 -D WHICH=\"$*\" -o $@ $<

dpad_%.stl: dpad.scad $(INCLUDES)
	$(OPENSCAD) -D RES=64 -D WHICH=\"$*\" -o $@ $<


clean:
	rm -f $(FILES)
