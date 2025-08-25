$fa = 1;
$fs = 0.3;


outer_radius = 4;
first_lip_height = 2.15;
shelf_height = 1.8;
second_lip_height = 0.7;

shelf_radius = outer_radius - first_lip_height;
bottom_radius = outer_radius - (first_lip_height + second_lip_height);

side_length = 42;
plate_height = 4.64;

single_grid_plate();

module single_grid_plate() {
    difference() {
        outer_profile();
        cutout();
    }
}

module outer_profile() {
    translate([outer_radius, outer_radius, 0]) 
    hull()
    cornercopy(d = outer_radius)
    cylinder(h=plate_height, r=outer_radius);
}

module cutout() {
    union() {
        hull() {
            // extend top to avoid z fighting
            translate([0,0,plate_height]) outer_profile();

            // first lip
            translate([0, 0, plate_height-first_lip_height]) first_lip();
        }

        hull() {
            // shelf
            translate([0, 0, plate_height-shelf_height]) shelf();

            // second lip
            translate([0, 0, plate_height-first_lip_height-shelf_height-second_lip_height]) second_lip();
        }
    }
}
// cutout();

module first_lip() {
    translate([outer_radius, outer_radius, 0])
    hull()
    cornercopy(d = outer_radius)
    cylinder(r1=shelf_radius, r2=outer_radius, h=first_lip_height);
}
// first_lip();

module shelf() {
    translate([outer_radius, outer_radius, 0])
    hull()
    cornercopy(d=outer_radius)
    cylinder(h=plate_height, r=shelf_radius);
}
// shelf();


module second_lip() {
    translate([outer_radius, outer_radius, 0])
    hull()
    cornercopy(d = outer_radius)
    cylinder(r1=bottom_radius, r2=shelf_radius, h=second_lip_height);
}
// second_lip();

module cornercopy(d) {
    for (xx=[0, 1], yy=[0, 1]) {
        xpos = xx * (side_length - 2 * d);
        ypos = yy * (side_length - 2 * d);
        translate([xpos, ypos, 0]) children();
    }
}