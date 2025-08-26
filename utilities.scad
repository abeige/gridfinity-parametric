function mm_to_cells(mm, pitch) = mm / pitch;

module rounded_cube(size, radius) {
    hull() {
        cornercopy(x_distance=size.x/2-radius, y_distance=size.y/2-radius)
        cylinder(h=size.z, r=radius);
    }
}

module cornercopy(x_distance, y_distance) {
    for (xx = [-1, 1], yy=[-1, 1]) {
        xpos = xx * x_distance;
        ypos = yy * y_distance;
        translate([xpos, ypos, 0])
        children();
    }
}