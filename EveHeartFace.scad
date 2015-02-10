//!OpenSCAD

pad = 0.01;
base_h = 8;
feature_h = 3;
cut_base_h = 3;
cut_h = 25;
cut_w = 75;
w = cut_w + 10;

union(){
translate([0,0,cut_base_h-pad])
linear_extrude(height=cut_h)
import(file="EveHeartFace.dxf", layer="CutterOutline", center=true);
linear_extrude(height=cut_base_h)
import(file="EveHeartFace.dxf", layer="CutterBase", center=true);
}

translate([0,w,0])
union()
{
linear_extrude(height=base_h)
import(file="EveHeartFace.dxf", layer="Heart", center=true);

translate([0,0,base_h-pad])
linear_extrude(height=feature_h)
difference(){
import(file="EveHeartFace.dxf", layer="Face", center=true);
import(file="EveHeartFace.dxf", layer="Eyes", center=true);
}
}