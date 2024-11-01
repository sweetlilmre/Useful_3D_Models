// Parameters for the belt
outer_diameter = 22.5;  // Outer diameter of the belt in mm
thickness = 1.2;        // Thickness of the belt in mm
height = 1.2;          // Height of the belt in mm

// Derived dimensions
outer_radius = outer_diameter / 2;
inner_radius = outer_radius - thickness;

// Function to generate a smooth belt
module smooth_belt() {
    difference() {
        // Outer cylinder (belt outer shape)
        cylinder(h = height, r = outer_radius, $fn = 100);
        
        // Inner cylinder (cut-out for the inner part of the belt)
        translate([0, 0, -1])  // Slightly down to avoid surface artifacts
        cylinder(h = height + 2, r = inner_radius, $fn = 100);
    }
}

// Generate the belt model
smooth_belt();