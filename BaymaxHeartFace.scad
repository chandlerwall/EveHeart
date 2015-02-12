//!OpenSCAD

DRAFT = 1; // switch off for potentially higher quality final render
smooth = DRAFT == 1 ? 32 : 128;
pad = 0.01;
$fn = smooth;

// Cookie cutter dimensions
base_h = 3;
feature_h = 2;
cut_base_h = 3;
cut_h = 20;
cut_w = 80;
cut_l = 70;

// Nail dimensions
nail_head_h = 0.75;
nail_head_h2 = 1.5;
nail_head_d = 8.25;
nail_head_r = nail_head_d / 2;
nail_shaft_d = 2.85;
nail_shaft_r = nail_shaft_d / 2;
nail_shaft_d2 = 3;
nail_shaft_r2 = nail_shaft_d2 / 2;

// Cutter (heart outline with "tall" outline)
union()
{
    translate([0,0,cut_base_h-pad])
    linear_extrude(height=cut_h)
    scale(0.1)import(file="BaymaxHeartFace.dxf", layer="Outline", center=true);
    linear_extrude(height=cut_base_h)
    scale(0.1)import(file="BaymaxHeartFace.dxf", layer="Base", center=true);
}

// Features (heart shape with Baymax's face)
translate([0,cut_l,0])
union()
{
    linear_extrude(height=base_h)
    scale(0.1)import(file="BaymaxHeartFace.dxf", layer="Heart", center=true);

    translate([0,0,base_h-pad])
    linear_extrude(height=feature_h)
    scale(0.1)
    difference(){
        import(file="BaymaxHeartFace.dxf", layer="Face", center=true);
        import(file="BaymaxHeartFace.dxf", layer="Eyes", center=true);
    }
}

// Circular "patch" to cover/secure nail head to cookie cutter feature plate
translate([cut_w, cut_w, 1])
difference()
{
    cylinder(h=2, r=nail_head_r * 2, center=true);
    translate([0,0,-(2 - nail_head_h2 + pad)/2])cylinder(h=nail_head_h2, r1=nail_shaft_r, r2=nail_shaft_r2, center=true);
    translate([0,0,0])cylinder(h=nail_head_h2 - nail_head_h, r1=nail_shaft_r2, r2=nail_head_r, center=true);
    translate([0,0,(2 - nail_head_h + pad)/2])cylinder(h=nail_head_h, r=nail_head_r, center=true);
}
