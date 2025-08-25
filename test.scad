use <./one_grid.scad>

/* [ Global Variables ] */
$fa = 1;
$fs = 0.3;

/* [ Grid Settings ] */
// X, Y, Z. Set Z=0 for min plate height
Pitch = [42, 42, 7];

$pitch = Pitch;

baseplate_cell();
// translate([0, 42, 0]) baseplate_cell();

// cavity();