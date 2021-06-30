$fn = 100;

module makeRim() {
    rimInnerD = 99;
    rimOuterD = 108;
    rimHeight = 4;

    translate([0,0,rimHeight / 2]) {
        
        difference() {
            cylinder(h=rimHeight, d=rimOuterD, center=true);
            cylinder(h=rimHeight + 2, d=rimInnerD, center=true);
        }
    }    
}

module makeClip() {
    translate([0,0,5]) {
       cube(size=[2,8,10], center=true);
    }
    
    translate([2,0,9]) {
       cube(size=[3,8,2], center=true);
    }
    
}

module setClip(deg) {
    rotate([0,0,deg]) {
        translate([105/2+2,0,0]) {
            makeClip();
        }
    }
}

makeRim();
//makeClip();
setClip(0);
setClip(360/3);
setClip(360/3*2);