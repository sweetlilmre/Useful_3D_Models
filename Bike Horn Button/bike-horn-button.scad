// part resolution
$fn=200;
$totalHeight = 4.75;
$outerTubeDiam = 9.6;
$outerTubeWidth = 2;
$endCapHeight = 1.8;
$innerTubeDiam = 5.4;
$innerTubeInnerDiam = 3.4;
$sphereRadius = 15;

module tube(height, outerDiam, innerDiam, endCapHeight = 0, alignCenter = true)
{
  difference()
  {
    // outer cylinder
    cylinder(h=height, d=outerDiam, center = alignCenter);
    translate([0, 0, -endCapHeight])
    {
      // inner cylinder cut out
      cylinder(h = height + 1, d = innerDiam, center = alignCenter);
    }
  }
}

module button()
{
  union()
  {
    tube($totalHeight, $outerTubeDiam, $outerTubeDiam - $outerTubeWidth, $endCapHeight);
    tube($totalHeight, $innerTubeDiam, $innerTubeInnerDiam);
  }
}

difference()
{
  button();
  translate([0, 0, 16.8])
  {
    #sphere($sphereRadius);
  }
}