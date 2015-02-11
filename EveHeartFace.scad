//!OpenSCAD

DRAFT = 1; // switch off for potentially higher quality final render
smooth = DRAFT == 1 ? 32 : 128;
pad = 0.01;
$fn = smooth;

// Cookie cutter dimensions
base_h = 3;
feature_h = 3;
cut_base_h = 3;
cut_h = 20;
cut_w = 80;
cut_l = 70;

// Nail dimensions
nail_head_h = 0.75;
nail_head_d = 8;
nail_head_r = nail_head_d / 2;
nail_shaft_d = 3.25;
nail_shaft_r = nail_shaft_d / 2;

// Cutter (heart outline with "tall" outline)
union()
{
    translate([0,0,cut_base_h-pad])
    linear_extrude(height=cut_h)
    import(file="EveHeartFace.dxf", layer="CutterOutline", center=true);
    linear_extrude(height=cut_base_h)
    import(file="EveHeartFace.dxf", layer="CutterBase", center=true);
}

// Features (heart shape with Eve's face)
translate([0,cut_l,0])
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

// Circular "patch" to cover/secure nail head to cookie cutter feature plate
!translate([cut_w / 2, - nail_head_r * 2 - 5, 0])
difference()
{
    cylinder(h=2, r=nail_head_r * 2, center=true);
    #cylinder(h=2+pad, r=nail_shaft_r, center=true);
    translate([0,0,nail_head_h])cylinder(h=nail_head_h+pad, r=nail_head_r, center=true);
}
