use <./utilities.scad>
use <./baseplate_cell.scad>

module baseplate() {
    intersection() {
        for (x = [0 : $cells_x - 1]) {
        for (y = [0 : $cells_y - 1]) {
            translate([x * $pitch.x, y * $pitch.y, 0])
            baseplate_cell();
        }}
        x_width = $cells_x * $pitch.x;
        y_width = $cells_y * $pitch.y;
        translate([x_width/2, y_width/2, 0])
        rounded_cube([x_width, y_width, get_plate_height()], 4);
    }
}