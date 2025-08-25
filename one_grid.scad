outer_radius = 4;
top_bevel_height = 2.15;
shelf_height = 1.8;
bottom_bevel_height = 0.7;
min_height = top_bevel_height + shelf_height + bottom_bevel_height;

shelf_radius = outer_radius - top_bevel_height;
bottom_radius = outer_radius - (top_bevel_height + bottom_bevel_height);

side_length = $pitch[0];
plate_height = $pitch[2];  // TODO: adjust plate height to be at least min_height

module baseplate_cell() {
    difference() {
        outer_profile();
        cavity();
    }
}

module outer_profile() {
    // TODO: put the corners back in and create a rounded mask for the full plate
    translate([0,0, plate_height/2])
    hull()
    cornercopy(d=outer_radius)
    cylinder(h=plate_height, r=outer_radius, center=true);
}

module cavity() {
    union() {
        hull() {
            // extend top to avoid z fighting
            translate([0,0, plate_height]) outer_profile();

            // first lip
            translate([0, 0, plate_height-top_bevel_height]) top_bevel();
        }

        hull() {
            // shelf
            translate([0, 0, plate_height-top_bevel_height-shelf_height]) shelf();

            // second lip
            translate([0, 0, plate_height-top_bevel_height-shelf_height-bottom_bevel_height]) bottom_bevel();
        }
    }
}

module top_bevel() {
    hull()
    cornercopy(d = outer_radius)
    cylinder(r1=shelf_radius, r2=outer_radius, h=top_bevel_height);
}

module shelf() {
    hull()
    cornercopy(d=outer_radius)
    cylinder(h=plate_height/2, r=shelf_radius);
}


module bottom_bevel() {
    hull()
    cornercopy(d = outer_radius)
    cylinder(r1=bottom_radius, r2=shelf_radius, h=bottom_bevel_height);
}

module cornercopy(d) {
    for (xx=[-1, 1], yy=[-1, 1]) {
        xpos = xx * (side_length/2 - d);
        ypos = yy * (side_length/2 - d);
        // echo(xpos, ypos);
        translate([xpos, ypos, 0]) children();
    }
}