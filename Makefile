FILES = front.stl back.stl analog_insert.stl button_A.stl button_B.stl button_X.stl button_Y.stl button_blank.stl button_insert.stl small_button_H.stl small_button_M.stl small_button_insert.stl dpad_insert.stl dpad_dpad.stl dpad_nub.stl
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
	$(OPENSCAD) -D RES=$(RES) -D WHICH=\"$*\" -o $@ $<

small_button_%.stl: small_buttons.scad $(INCLUDES)
	$(OPENSCAD) -D RES=$(RES) -D WHICH=\"$*\" -o $@ $<

dpad_%.stl: dpad.scad $(INCLUDES)
	$(OPENSCAD) -D RES=$(RES) -D WHICH=\"$*\" -o $@ $<


clean:
	rm -f $(FILES)
