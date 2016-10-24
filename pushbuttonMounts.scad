/* 
	pushbuttonMounts.scad	
	3D printed button with tact switches library
	or indicators
	October 2016
	Albert Phan

	desc:

*/

$fn = 100;


holeDia = 15;




// Things that should only be tweaked if you know what you're doing

tactSwHeight = 5; // average tact switch height (top off tact button to bottom of base)

holeWallThickness = 5;
keyedWidth = 2;
tol = 0.4;
printedButtonFlangeThickness = 3;
printedButtonLength = 2;
printedButtonWidth = 3;
height = tactSwHeight + printedButtonFlangeThickness;
//ledHeight = x; 

type = "tactSwitch"; // [tactSwitch, 5mmLed, 3mmLed]


// Test it!
// User should be able to make whatever size button they want plus just choose type and not need to worry about smaller details
// Also able to do a custom hole if needed (but shouldn't need to make a custom one)

//pbMount(holeDia, type, flipped = false);
pbCap(holeDia, type, flipped = false);

module pbMount(holeDia, type, flipped)
{
	if( type == "tactSwitch")
	{
		pbCustomMount(holeDia, height, flipped);
	}
	else if(type == "5mm led")
	{
		
	}
	else if(type =="3mm led")
	{
		
	}
}

module pbCap(holeDia, type, flipped = false)
{
	if( type == "tactSwitch")
	{
		pbCustomCap(holeDia,height, type);
	}
	else if(type == "5mm led")
	{
		
	}
	else if(type =="3mm led")
	{
		
	}
	
}

module pbCustomMount(holeDia, height, type, flipped = false)
{
	if(flipped == true)
		rotate([180,0,0])
			children();	// not sure if works
		
	difference()
	{
		cylinder(d = holeDia + holeWallThickness * 2, h = height);
		translate([0,0,-0.01])
			cylinder(d = holeDia, h = height + 0.02);
		
		// cut out keyed part for printed button
		intersection()
		{
			translate([-50,-100,0])
				cube([100,100,100]);
			cylinder(d = holeDia + holeWallThickness, h = height + 0.02);
		}
	}
}

// Creates the bottom cap which contains the tact switch or led
module pbCustomCap(holeDia, height, type = "tactSwitch")
{
	bottomPlateThickness = 1.6;
	sideThickness = 1;
	tactSwitchLegSpacing = 4.50;
	
	translate([0,0,height])
	{
		difference()
		{
			// bottom
			cylinder(d = holeDia + holeWallThickness * 2 + sideThickness * 2, h = bottomPlateThickness);
			if(type == "tactSwitch")
			{
				// Tact switch leg holes
				for(x = [1, -1])
				{
					for(y = [1, -1])				{
						
						translate([tactSwitchLegSpacing/2 * x, tactSwitchLegSpacing/2 * y,])
							cylinder(d = 1, h = bottomPlateThickness + 0.01);
					}

				}
			}
			else if(type == "5mm led")
			{
				// 5mm led holes
				
			}
			else if(type == "3mm led")
			{
				// 3mm led holes
			}
				
		}
		
		difference()
		{	
			// Side walls
			translate([0,0,-height])
				cylinder(d = holeDia + holeWallThickness * 2 + sideThickness * 2, h = height);
			translate([0,0,-height - 0.01])
				cylinder(d = holeDia + holeWallThickness * 2, h = height + 0.01);
			
			
		}
	}
}