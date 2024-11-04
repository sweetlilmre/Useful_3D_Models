$fn=100;

// change this for a diffent size hinge pin
hingePinDiameter = 2;

latchBaseHeight = 2.5;
latchBaseLength = 60;
latchBaseWidth = 32;
hingeRadius = 3;

module slotNegative(length) {
  radius = 2;
  slotWidth = radius * 2;
  
  translate([0, - (length / 2) + radius, 0]) {
    cylinder(h = latchBaseHeight + 1, d = slotWidth, center=true);
  }
 
  cube([slotWidth, length - (slotWidth), latchBaseHeight + 1], center = true);
 
  translate([0, (length / 2) - radius, 0]) {
    cylinder(h = latchBaseHeight + 1, d = slotWidth, center=true);
  }
  
}

module hingeRest(right) {
  hingeWidth = 20;
  ytrans = right ? latchBaseWidth/2 : -latchBaseWidth/2;
  zrot = right ? -90 : 90;
  
  
  translate([0, ytrans, hingeRadius-latchBaseHeight/2]) {
    rotate([90, 0, zrot]) {
      linear_extrude(height = hingeWidth, center = true, convexity = 1, twist = 0) {
        polygon(points=[[0,0],[latchBaseWidth,0],[7.5,13]], paths=[[0,1,2]]);
      }
    }
  }
  translate([-hingeWidth / 2, -latchBaseWidth/2, latchBaseHeight/2]) {
    rotate([0,0,0]) {
      cube([hingeWidth, latchBaseWidth, 0.5]);
    }
  }
}

module latchBase(right, slotLength, slotWidth, slotOffset) {
  difference() {
    union() {
      cube([latchBaseLength, latchBaseWidth, latchBaseHeight], center=true);
      hingeRest(right);
    }      
    translate([-latchBaseLength/2 + (slotWidth/2) + 10, -latchBaseWidth/2+ (slotLength/2) + slotOffset, 0]) {
      slotNegative(slotLength);
    }
    translate([latchBaseLength/2 - (slotWidth/2) - 10, -latchBaseWidth/2+ (slotLength/2) + slotOffset, 0]) {
      slotNegative(slotLength);
    }
  }
}

module leftLatch() {

  difference() {
    latchBase(false, 18, 4, 8.5);

    // center hinge negative cut
    translate([0, latchBaseWidth / 2, hingeRadius-latchBaseHeight/2]) {
      rotate([0,90,0]) {
        cylinder(h = latchBaseLength - 30, r = hingeRadius + 0.5, center = true);
      }
    }
  }

  // left and right hinge part
  translate([0, latchBaseWidth / 2, hingeRadius-latchBaseHeight/2]) {
    rotate([0,90,0]) {
      difference() {
        cylinder(h = latchBaseLength, r = hingeRadius, center = true);
        cylinder(h = latchBaseLength - 30, r = hingeRadius + 0.1, center = true);
      }
    }
  }
}

module rightLatch() {
  difference() {
    latchBase(true, 10, 4, 13);
  
    // left hinge negative cut
    translate([latchBaseLength/2-7.75, -latchBaseWidth / 2, hingeRadius-latchBaseHeight/2]) {
      rotate([0,90,0]) {
        cylinder(h = 15.6, r = hingeRadius + 0.5, center = true);
      }
    }

    // right hinge negative cut
    translate([-latchBaseLength/2+7.75, -latchBaseWidth / 2, hingeRadius-latchBaseHeight/2]) {
      rotate([0,90,0]) {
        cylinder(h = 15.6, r = hingeRadius + 0.5, center = true);
      }
    }
  }
  
  // center hinge part
  translate([0, -latchBaseWidth / 2, hingeRadius-latchBaseHeight/2]) {
    rotate([0,90,0]) {
      cylinder(h = 29, r = hingeRadius, center = true);
    }
  }
}

difference() {
  union() {
    translate([0, -latchBaseWidth / 2, latchBaseHeight/2 - hingeRadius]) {
       leftLatch();
    }
    rotate([0,0,0]) {
      translate([0, latchBaseWidth / 2, latchBaseHeight/2 - hingeRadius]) {
         rightLatch();
      }
    }
  }
  translate([2,0,0]){
    rotate([0,90,0]) {
      cylinder(h = latchBaseLength, d = hingePinDiameter, center = true);
    }
  }
}

