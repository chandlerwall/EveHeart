//!OpenSCAD

pad = 0.01;
base_h = 8;
feature_h = 3;
cut_base_h = 3;
cut_h = 25;
cut_w = 75;
w = cut_w + 10;

smooth = 16;
$fn = smooth;

difference(){
resize(newsize=[20,0,0], auto=true)
union(){
    difference(){
        union()
        {
            hull()
            {
            linear_extrude(height=1)
            import(file="EveHeartFace.dxf", layer="Heart", center=true);

            translate([40,35,-15])
            cylinder(h=30, r=25, center=true);
            }

        linear_extrude(height=base_h)
        import(file="EveHeartFace.dxf", layer="Heart", center=true);
        }

    translate([0,0,base_h - feature_h + pad])
    linear_extrude(height=feature_h)
    import(file="EveHeartFace.dxf", layer="Face", center=true);
    }

translate([0,0,base_h - feature_h])
linear_extrude(height=feature_h/2)
import(file="EveHeartFace.dxf", layer="Eyes", center=true);
}

#translate([10.5,9.25,-5])
cylinder(h=10, r=1.5, center=true);

#translate([5,9.25,-3.5])
rotate([90,0,90])
cylinder(h=12, r=1.5, center=true);

#translate([7,9.25,-4])
cube([2.4, 6.25, 10], center=true);
}