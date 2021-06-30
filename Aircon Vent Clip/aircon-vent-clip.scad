$fn=100;

module clip(height, diam)
{
    #translate([diam+3/2-1, 0, -((height - 2)/2)]){
        cube([3,3,2], center=true);
    }
    difference() {
        cylinder(height,diam,diam, center=true);
        cube([5,3,height + 2], center=true);
    }
}

clip(8,4);