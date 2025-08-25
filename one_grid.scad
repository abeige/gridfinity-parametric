outer_radius = 4;
top_bevel_height = 2.15;
shelf_height = 1.8;
bottom_bevel_height = 0.7;

shelf_radius = outer_radius - top_bevel_height;
bottom_radius = outer_radius - (top_bevel_height + bottom_bevel_height);
side_length = $pitch[0];

min_height = top_bevel_height + shelf_height + bottom_bevel_height - 0.005;
function get_plate_height() = $pitch.z < min_height ? min_height : $pitch.z;
plate_height = get_plate_height();

module baseplate_cell() {
    difference() {
        outer_profile();
        cavity();
    }
}

module outer_profile() {
    translate([0,0, plate_height/2])
    cube([$pitch.x, $pitch.y, plate_height], center=true);
}

module cavity() {
    union() {
        hull() {
            // extend top to avoid z fighting
            translate([0,0, plate_height]) cap();

            // top bevel
            translate([0, 0, plate_height-top_bevel_height]) top_bevel();
        }

        hull() {
            // shelf
            translate([0, 0, plate_height-top_bevel_height-shelf_height]) shelf();

            // bottom bevel
            translate([0, 0, plate_height-top_bevel_height-shelf_height-bottom_bevel_height]) bottom_bevel();
        }
    }
}

module cap() {
    translate([0, 0, plate_height/2])
    hull()
    cornercopy(d=outer_radius)
    cylinder(h=0.005, r=outer_radius, center=true);
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
        xpos = xx * ($pitch.x/2 - d);
        ypos = yy * ($pitch.y/2 - d);
        // echo(xpos, ypos);
        translate([xpos, ypos, 0]) children();
    }
}
