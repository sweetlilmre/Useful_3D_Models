// part resolution
$fn=100;
// total height of the part
$totalHeight = 28;
// height of the spring clip gap in the middle of the part
$clipGapHeight = 5;
// height of the retaining notch for the spring clip on the outer tube
$clipRetainHeight = 4;
// height of the end cap of the inner tube
$endCapHeight = 3;
// diameter of the screw hole in the end cap
$screwDiam = 5;
// diameter of the outer tube
$outerDiam = 16.4;
// diameter of the inner tube
$innerDiam = 14;
// wall thickness of the inner tube
$tubeTickness = 3.5;



// create the outer tube
difference()
{
  difference()
  {
    // create tube
    difference()
    {
      // outer cylinder
      cylinder(h=$totalHeight, d=$outerDiam, center=true);
      // inner cylinder cut out
      cylinder(h = $totalHeight + 1, d = $innerDiam, center = true);
    }
    translate([0,0,-1])
    {
      // cut out the clip retaining notch
      difference()
      {
        cylinder(h=$clipRetainHeight, d=$outerDiam+1, center=true);
        cylinder(h=$clipRetainHeight+1, d=$outerDiam-1.6, center=true);
      }
    }
  }
  // cut tube in half
  translate([0, -($outerDiam / 2) / 2, 0])
  {
    cube([$outerDiam, $outerDiam / 2, $totalHeight + 1], center=true);
  }
}

// create the inner tube with end cap, screw hole and spring clip notch
difference()
{
  difference()
  {
    // create inner tube with end cap
    difference()
    {
      cylinder(h = $totalHeight, d = $innerDiam, center = true);
      // leaving the end cap
      translate([0, 0, -$endCapHeight])
      {
        // cut out to make the tube
        cylinder(h = $totalHeight, d = ($innerDiam-$tubeTickness), center = true);
      }
    }
    // cut out the screw hole
    cylinder(h = $totalHeight + 1, d = $screwDiam, center = true);
  }

  // add the spring clip notch
  translate([0, -($outerDiam / 2) / 2, -1])
  {
    cube([$outerDiam, $outerDiam / 2, $clipGapHeight], center=true);
  }
}
