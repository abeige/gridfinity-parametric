use <./baseplate.scad>

/* [ Global Variables ] */

$fa = 1;
$fs = 0.3;


/* [ Grid Settings ] */

// X, Y, Z. Set Z=0 for min plate height
Pitch = [42, 42, 7];


/* [ Baseplate Settings ] */

// Number of cells in X direction
Cells_X = 1; 
// Minimum X dimension in mm
Minimum_X_width = 0;
// Maximum X dimension in mm (0 for no limit)
Maximum_X_width = 0;

// Number of cells in Y direction
Cells_Y = 1; 
// Minimum Y dimension in mm
Minimum_Y_width = 0;
// Maximum Y dimension in mm (0 for no limit)
Maximum_Y_width = 0;

// set globals
$pitch = Pitch;
$cells_x = Cells_X;
$min_x = Minimum_X_width;
$max_x = Maximum_X_width;
$cells_y = Cells_Y;
$min_y = Minimum_Y_width;
$max_y = Maximum_Y_width;

/* [ Render ] */

baseplate();
