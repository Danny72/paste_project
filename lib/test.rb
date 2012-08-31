require "auto_click"

mouse_move(500,60)
double_click
left_click
sleep 0.5
type("WASDFGH")
key_stroke("tab")
sleep 0.1
key_down(0x11)
key_stroke("v")
key_up(0x11)