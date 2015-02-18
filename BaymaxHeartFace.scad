//!OpenSCAD

DRAFT = 0; // switch off for potentially higher quality final render
smooth = DRAFT == 1 ? 32 : 128;
nozzle_d = 0.4;
$fn = smooth;
pad = 0.01;

// Cookie cutter dimensions
base_h = 3;
feature_h = 2;
cut_base_h = 3;
cut_h = 12;
page_offset = 3;
cut_w = 81.5 + page_offset;
cut_l = 68.9 + page_offset;

// Nail dimensions
nail_head_h = 1;
nail_head_h2 = 1.5;
nail_head_d = 8.25;
nail_head_r = nail_head_d / 2;
nail_shaft_d = 3.25;
nail_shaft_r = nail_shaft_d / 2;
nail_shaft_d2 = 3.5;
nail_shaft_r2 = nail_shaft_d2 / 2;

patch_h = 2.5;
guide_h = 7;

// Cutter (heart outline with "tall" outline)
union()
{
    translate([0,0,cut_base_h-pad])
    linear_extrude(height=cut_h)
    scale(0.1)import(file="BaymaxHeartFace.dxf", layer="Outline", center=true);
    linear_extrude(height=cut_base_h)
    difference(){
        scale(0.1)import(file="BaymaxHeartFace.dxf", layer="Base", center=true);
        #translate([(cut_w+page_offset)/2, 7+(cut_l+page_offset)/2])circle(r=nail_shaft_r, center=true);
    }
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
translate([cut_w, cut_w, patch_h/2])
difference()
{
    cylinder(h=patch_h, r=nail_head_r * 2, center=true);
    translate([0,0,-(patch_h - nail_head_h2 + pad)/2])cylinder(h=nail_head_h2, r1=nail_shaft_r, r2=nail_shaft_r2, center=true);
    translate([0,0,0])cylinder(h=nail_head_h2/2, r1=nail_shaft_r2, r2=nail_head_r, center=true);
    translate([0,0,(patch_h - nail_head_h + pad)/2])cylinder(h=nail_head_h, r=nail_head_r, center=true);
}

// Conical guide to ensure that the feature presser moves straight
translate([cut_w + nail_head_r * 5, cut_w, guide_h/2])
difference()
{
    cylinder(h=guide_h, r1=nail_head_r, r2=nail_shaft_r + nozzle_d*4, center=true);
    #translate([0,0,0])cylinder(h=guide_h+pad, r=nail_shaft_r, center=true);
}
