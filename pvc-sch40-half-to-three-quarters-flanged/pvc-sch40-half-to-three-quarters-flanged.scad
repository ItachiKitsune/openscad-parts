

$fn=100;
adapter();

translate([0,0,-25])
{
    flange();
}



module adapter()
{

difference()
{
    
    translate([0,0,-25])
    {
        cylinder(h=50, r=35/2, r2=30/2, center=false);
    }

    union()
    {
        // thru hole
        translate([0,0,-30])
        {
            cylinder(h=60, r=16/2, center=false);
        }

        // 1/2 pvc pipe
        translate([0,0,5])
        {
            cylinder(h=30, r=22/2, center=false);
        }
        
        // 3/4 pvc pipe
        translate([0,0,-35])
        {
            cylinder(h=30, r=27/2, center=false);
        }

        // ramp
        translate([0,0,-8])
        {
            cylinder(h=5, r=27/2, r2=16/2, center=false);
        }

        
    }

    
}
}



module flange()
{
    difference()
    {
        
        //cylinder(h=10, r=30, center=false);

        make_ring_of(15,3,0)
        {
            cylinder(h=10, r=14, center=false);
        }

    
        translate([0,0,-1])
        {

            cylinder(h=12, r=30/2, center=false);

            make_ring_of(22,3,0)
            {
                cylinder(h=12, r=3, center=false);

                // bottem 
                translate([0,0,-1])
                {
                    cylinder(h=5, r=5, r2=1, center=false);
                }
                
                translate([0,0,8])
                {
                    cylinder(h=5, r=1, r2=5, center=false);
                }
                
            }
            
            make_ring_of(45,3,180)
            {
                cylinder(h=12, r=28, center=false);
            }
            
            
        }
    }
    
}

module make_ring_of (radius, count, offsetDeg)
{
    for (a = [0: count -1]){
        angle = (a * 360 /count) + offsetDeg;
        
        translate (radius * [sin(angle), -cos(angle), 0])
            rotate ([0, 0, angle])
                children ();
    }
}





