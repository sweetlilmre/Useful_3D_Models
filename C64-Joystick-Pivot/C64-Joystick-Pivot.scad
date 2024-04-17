$fn=100;

$mainH = 14.5;
$mainD = 18;
$wall = 2;

$nubD = 7;
$nubH = 11.5;

module tube(height, diam, top, wall) {
  difference() {
    cylinder(h=height, d=diam);
    translate([0,0,-top]) {
      cylinder(h=height, d=diam-wall);
    }  
  }
}

tube($mainH, $mainD, 1, $wall);

translate([0,0,$mainH]) {
  $nubHsphere = $nubH - ($nubD / 2);
  tube($nubHsphere, $nubD, 2, $wall);
  translate([0,0,$nubHsphere]) {
    sphere(d = $nubD);
  }
}
