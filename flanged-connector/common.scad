// Modified version of the common make ring of subset... 
// Basically circular array.
// Added offsetDeg to allow for altering start location of pattern.
module make_ring_of (radius, count, offsetDeg)
{
    for (a = [0: count -1])
	{
        angle = (a * 360 /count) + offsetDeg;
        
        translate (radius * [sin(angle), -cos(angle), 0])
            rotate ([0, 0, angle])
                children ();
    }
}

module linear_array(start, offset, count)
{
	translate(start)
	{
		for (a = [0: count -1])
		{
			translate([a*offset[0], a*offset[1], a*offset[2]])
				children();
		}
	}
}