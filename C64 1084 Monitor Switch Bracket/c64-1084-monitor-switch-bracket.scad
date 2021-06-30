$fn = 100;
fuzz = 0.1;

module prism(l, w, h){
  polyhedron(
    points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
    faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
  );
   
 
}
   
module screw_hole(diameter, xoffs)
{
    // screw hole
    translate([xoffs, 7, -1])
    {
        cylinder(8, d = diameter);
    }
}


module base_cutout(width, slotWidth, slotHeight)
{
    translate([(width-slotWidth) / 2, 2, -fuzz]) {
    cube([slotWidth, 11 + fuzz, slotHeight + (fuzz*2)]);
  }

/*    
        translate([(25-9.5) / 2, 4, 0])
        {
            cube([9.5, 6, 0.5]);
        }
*/    
}

module build_clip(width, height) {
  voidWidth = 13;
  holeDiameter = 2.6;
  slotHeight = 1;
  slotWidth = 9.5;

  difference() {
    
    cube([width, 13, height]);
    {
      // outer corner cutouts
      translate([-fuzz, -fuzz, -fuzz]) {
        cube([4 + fuzz, 1 + fuzz, 6 + (fuzz * 2)]);
      }
      translate([(width + fuzz) - 4, -fuzz, -fuzz]) {
        cube([4 + fuzz, 1 + fuzz, 6 + (fuzz * 2)]);
      }
        
      // main centre cutout lower
      translate([(width - voidWidth) / 2, 1, slotHeight]){
        cube([voidWidth, 12 + fuzz, 5.5]);
      }

      // make room for the hooks and cut out the additional
      // bit of the lower void
      translate([(width - voidWidth - 1) / 2, 12.5, slotHeight]){
        cube([voidWidth + 1, 12 + fuzz, 5.5]);
      }
      
      // main centre cutout upper
      translate([(width - (voidWidth  + 1)) / 2, 1, 4]){
        cube([voidWidth + 1, 12 + fuzz, 5.5]);
      }
        
      // screw hole 1
      screw_hole(holeDiameter, 3.25);
      // screw hole 2
      screw_hole(holeDiameter, width - 3.25);
        
      base_cutout(width, slotWidth, slotHeight);
    }
  }
  
  // special magic for the hooks, this is rubbish, but works
  translate([5.5, 13, 1])
  {
    rotate([0, 0, 180]){
      rotate([0, -90, 0]) {
        prism(3,1,1);
      }
    }
  }

  translate([18.5, 12, 1])
  {
    rotate([0, 0, 180]){
      rotate([90, -90, 0]) {
        prism(3,1,1);
      }
    }
  }
}

build_clip(25, 6);
// measure hole to hole, this is wrong atm
/*
translate([2.75, 6.5, 0])
{
    cube([18.5, 1, 1]);
}
*/



