
// The $fn parameter will influence all objects inside this module
// It can, optionally, be overridden when instantiating the module


module prism(l, w, h){
   polyhedron(
           points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
           faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
           );
   
 
   }
       
module Clip(length=50, $fn=100) {
    cube([12,length,2]);
    #translate([12,length, 2-0.001]){
        rotate([0,0,180]) {
                prism(12,5,3);
        }
    }
}

Clip(40);

echo(version=version());
