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
holeWallThickness = 5;
flipped = false;

keyedWidth = 2;
tol = 0.4;

// Other information
tactSwHeight = 5; // average tact switch height (top off tact button to bottom of base)


printedButtonFlangeThickness = 3;	// Shouldn't need to be adjusted
printedButtonLength = 2;
printedButtonWidth = 3;
height = tactSwHeight + printedButtonFlangeThickness;

type = "tactSwitch"; // [tactSwitch, 5mmLed, 3mmLed]


// Test it!
//pbMount(holeDia,height);
pbCap(holeDia, type);

module pbMount(holeDia, height, flipped = false)
{
	if(flipped == true)
		rotate([180,0,0])
			children();
		
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
module pbCap(holeDia, type = "tactSwitch")
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
						
						#translate([tactSwitchLegSpacing/2 * x, tactSwitchLegSpacing/2 * y,])
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