//include<thirdparty\fillets3d\fillets3d.scad>
//include<thirdparty\fillets3d\fillets2d.scad>
include<common.scad>

// First OpenSCAD script
// Pieced together from mutiple source.
// All units in mm.

//subdivisions. (Higher is smoother.)
$fn=100;


//Units: mm (Round up)
Upper_Pipe_OD=22;

//Units: mm (Round up)
Upper_Pipe_ID=16;

//Units: mm (Round up)
Lower_Pipe_OD=27;

//Units: mm (Round up)
Lower_Pipe_ID=21;

//Units: mm
Connector_Spacer=10;

//Units: mm
Connector_Height=50;

//Units: mm
Connector_Wall_Thickness=5;

//Units: mm 
Flange_Height=10;

//Units: mm 
//From Bottom of Connector.
//Zero is flush
Flange_Position=0;

//Units: mm 
Flange_Hole_ID=3;

//translate([
//    (5* Lower_Pipe_OD + (2* Connector_Wall_Thickness)),
//    0,
//    0])
//{
//    adapter_internal_void();
//}



difference()
{

    translate([0,0,-(Connector_Height/2)])
    {
        union()
        {
            cylinder(
                h=Connector_Height, 
                r=Lower_Pipe_OD/2 + Connector_Wall_Thickness, 
                r2=Upper_Pipe_OD/2 + Connector_Wall_Thickness,
                center=false);
            
            translate([0,0,Flange_Position])
            {
                flange();
            }
        }
    }

    adapter_internal_void();
    
}




module adapter_internal_void()
{
    
    union()
    {
		// cutouts from inside main body.
		
        // thru hole
        translate([0,0,-(Connector_Height+10)/2])
        {
            cylinder(
                h=Connector_Height+10, 
                r=Upper_Pipe_ID/2, 
                center=false);
        }

        // 1/2 pvc pipe reciever 
        translate([0,0,Connector_Spacer])
        {
            cylinder(
                h=Connector_Height + 10, 
                r=Upper_Pipe_OD/2,
                center=false);
        }
        
        
        // 3/4 pvc pipe reciever
        translate([0,0,-(Connector_Height)])
        {
            cylinder(
                h=(Connector_Height), 
                r=Lower_Pipe_OD/2, 
                center=false);
        }


        translate([0,0,-.01])
        {
            cylinder(
                h=Connector_Spacer/2+.01, 
                r=Lower_Pipe_ID/2, 
                r2=Upper_Pipe_ID/2, 
                center=false);
        }

        // fillet the 3/4 pcd pipe reciever stop so coax will not hang up.
    }
}





module flange()
{
    //topBottomFillet(0, Flange_Height, 2, 5, 1)
	//fillet2d(.25)
    {
    
        difference()
        {
            connectorOD = Lower_Pipe_OD + Connector_Wall_Thickness *2;
            //cylinder(h=10, r=30, center=false);

            // Three tab lugs.
            make_ring_of(connectorOD/2,3,0)
            {
                cylinder(h=Flange_Height, r=connectorOD/3, center=false);
            }

        
            translate([0,0,-1])
            {


                // guy wire holes with fillet.
                make_ring_of(connectorOD*.64,3,0)
                {
                    
                    cylinder(
                        h=Flange_Height+2, 
                        r=Flange_Hole_ID, 
                        center=false);
                    
                    translate([0,0,-2])
                    {
                        cylinder(
                            h=4, 
                            r=Flange_Hole_ID+3, 
                            r2=Flange_Hole_ID, 
                            center=false);

                    }

                    translate([0,0,10])
                    {
                        cylinder(
                            h=4, 
                            r=Flange_Hole_ID, 
                            r2=Flange_Hole_ID+3, 
                            center=false);

                    }
                    
                    
                }
                
                // cut out extra material.
                make_ring_of(connectorOD*1.2,3,180)
                {
                    cylinder(
                        h=Flange_Height+2, 
                        r=connectorOD*.77, 
                        center=false);
                }
                
                
            }
        }
    }
    
}







