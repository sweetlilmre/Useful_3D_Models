$fn=100;

module MakeClip(pos, deg, clipHeight, ringHeight) {
    clipY = (ringHeight / 2) + (clipHeight / 2);
    echo(clipY);
    
    color("Green") {
        rotate([0, 0, deg]) {
            translate([pos, 0, clipY - 0.001]) {
                
                cube(size=[5, 5, clipHeight], center=true);
            }
        }
    };
}


module AntiProtect(diam, width, ringHeight, clipHeight, $fn=100) {
    // Temporary variables
    ring = diam + width;
    clipPos = (diam + (width/2)) / 2;

    difference() {
        cylinder(ringHeight, d=ring, center=true);
        cylinder(ringHeight+2, d=diam, center=true);
    }
    
    for (deg = [0: 360 / 3: 359]) {
        MakeClip(clipPos, deg, clipHeight, ringHeight);
    }
}

AntiProtect(105, 10, 5, 10);

echo(version=version());
