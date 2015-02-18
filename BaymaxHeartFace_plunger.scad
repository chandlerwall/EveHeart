//!OpenSCAD

DRAFT = 1; // switch off for potentially higher quality final render
smooth = DRAFT == 1 ? 32 : 128;
nozzle_d = 0.4;
$fn = smooth;
pad = 0.01;

// Cookie cutter dimensions
base_h = 3;
feature_h = 2;
cut_base_h = 3;
plunger_h = 5;
page_offset = 3;
heart_w = 81.5 + page_offset;
heart_l = 68.9 + page_offset;

difference(){
union(){
    difference(){
        union()
        {
            hull()
            {
            linear_extrude(height=1)
            scale(0.25)
            translate([-heart_w/2 - page_offset/2, -heart_l/2 - page_offset/2])
            scale(0.1)
            import(file="BaymaxHeartFace.dxf", layer="Heart", center=true);

            translate([0,0,-plunger_h])
            cylinder(h=plunger_h, r=6, center=true);
            }

        linear_extrude(height=base_h)
            scale(0.25)
            translate([-heart_w/2 - page_offset/2, -heart_l/2 - page_offset/2])
            scale(0.1)
            import(file="BaymaxHeartFace.dxf", layer="Heart", center=true);
        }

    translate([0,0,base_h - feature_h + pad])
    linear_extrude(height=feature_h)
    scale(0.25)
    translate([-heart_w/2 - page_offset/2, -heart_l/2 - page_offset/2])
    scale(0.1)
    import(file="BaymaxHeartFace.dxf", layer="Face", center=true);
    }

translate([0,0,base_h - feature_h])
linear_extrude(height=feature_h/2)
scale(0.25)
translate([-heart_w/2 - page_offset/2, -heart_l/2 - page_offset/2])
scale(0.1)
import(file="BaymaxHeartFace.dxf", layer="Eyes", center=true);
}

#translate([0,0,-plunger_h])
cylinder(h=10, r=1.5, center=true);

#translate([0,0,-3.5])
rotate([90,0,90])
cylinder(h=12, r=1.5, center=true);

#translate([3,0,-4])
cube([2.4, 6.25, 10], center=true);
}