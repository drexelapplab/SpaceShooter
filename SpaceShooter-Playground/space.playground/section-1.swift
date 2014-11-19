// Playground - noun: a place where people can play
import UIKit
import XCPlayground
import SpriteKit


////////////////////////////////
// CREATE ALL THE VEIWS
////////////////////////////////

// 1.)  Create SpaceView: all coordinates are relative to the upper left corner
let view:UIView = UIView(frame: CGRectMake(0, 0, 320, 460))
view.backgroundColor = UIColor.blackColor()
//---------------------------------------------------------


// 2.)  Show the space view in the playground
XCPShowView("SpaceView", view)
//---------------------------------------------------------


// 4.)  Create simple devide by 2 function
func halfOf(number:CGFloat)->CGFloat
{
    return number/2
}
//---------------------------------------------------------


// 6.)  Create function to center a smaller object inside a larger one, returning the coordinate of the upper left corner
func centerObject(largerObject:CGFloat, smallerObject:CGFloat)->CGFloat
{
    let newPosition = halfOf(largerObject) - halfOf(smallerObject)
    return newPosition
}
//---------------------------------------------------------


// 3.)  Create Alien
let aH:CGFloat = 100
let aW:CGFloat = 100
let aX:CGFloat = view.frame.width/2 - halfOf(aW)
let aY:CGFloat = 0
var alien:UIView = UIView(frame: CGRectMake(aX, aY, aW, aH))
alien.backgroundColor = UIColor.greenColor()
view.addSubview(alien)
//---------------------------------------------------------


// 5.)  Create Spaceship
let sH:CGFloat = 100
let sW:CGFloat = 100
let sX:CGFloat = centerObject(view.frame.width,sW)
let sY:CGFloat = view.frame.height-sH
var spaceship:UIView = UIView(frame: CGRectMake(sX,sY, sW, sH))
spaceship.backgroundColor = UIColor.grayColor()
view.addSubview(spaceship)
//---------------------------------------------------------


// 7.)  ADDING RESOUCE IMAGES
//      Open File inspector and click the resource path arrow
//      Drag images into the Resources folder that is displayed

//add alien image resources
let alienImage = UIImage(named:"green_alien")
let alienImageView:UIImageView = UIImageView(frame: CGRectMake(0,0, aW, aH))
alienImageView.image = alienImage
alien.backgroundColor = UIColor.clearColor()
alien.addSubview(alienImageView)

//add alien image resources
let spaceshipImage = UIImage(named:"space_ship")
let spaceshipImageView:UIImageView = UIImageView(frame: CGRectMake(0,0, sW, sH))
spaceshipImageView.image = spaceshipImage
spaceship.backgroundColor = UIColor.clearColor()
spaceship.addSubview(spaceshipImageView)
//---------------------------------------------------------


// 8.)  Add laser beam
let lW:CGFloat = 4
let lH:CGFloat = view.frame.height-spaceship.frame.height
let lX:CGFloat = centerObject(view.frame.width,lW)
let lY:CGFloat = 0
var laserbeam:UIView = UIView(frame: CGRectMake(lX, lY, lW, lH))
laserbeam.backgroundColor = UIColor.redColor()
view.addSubview(laserbeam)

//Make the laser turn on and off a few times
func toggleLaser()
{
    laserbeam.hidden = !laserbeam.hidden
}

toggleLaser()
toggleLaser()
//---------------------------------------------------------



////////////////////////////////
// VIEW INTERACTION
////////////////////////////////

// 9.)  create function to move the alien Left
func moveAlienLeft()
{
    alien.frame.origin.x = alien.frame.origin.x-20
}
//move it a few times
moveAlienLeft()
moveAlienLeft()
moveAlienLeft()
//---------------------------------------------------------

// 10.) Create function to move the alien Back and forth
var moveDistance:CGFloat = 20 //move distance increment
//move the alien
func moveAlien()
{
    //get new x position
    var newAlienX:CGFloat = alien.frame.origin.x+moveDistance
    
    //if new x is outside the frame, change directions
    if (newAlienX+alien.frame.width>view.frame.width) || (newAlienX < 0)
    {
        moveDistance = moveDistance * -1
        newAlienX = alien.frame.origin.x+moveDistance
    }
    
    //set the new frame x
    alien.frame.origin.x = newAlienX
}


//Move the alien a few times to see if it bounces off of the frame boundaries
moveAlien()
moveAlien()
moveAlien()
moveAlien()

//make the alien move a defined number of times
var numberOfTimesToMove = 4
for i in 1...numberOfTimesToMove
{
    moveAlien()
}
//---------------------------------------------------------

// 10.) check to see if alien and laser intersect
func laserHitAlien()->Bool
{
    //get position of alien
    var aX = alien.frame.origin.x
    var aW = alien.frame.width
    
    //get position of laser
    var lX = laserbeam.frame.origin.x
    var lW = laserbeam.frame.width
    
    //alien to far to the right
    if aX > lX+lW
    {
        return false
    }
    // alien to far to the left
    else if (aX + aW) < lX
    {
        return false
    }
    // alien is hit
    else
    {
        return true
    }
}


//see if laser hit alien
laserHitAlien()

//make the alien move a defined number of times
numberOfTimesToMove = 4
for i in 1...numberOfTimesToMove
{
    moveAlien()
}
laserHitAlien()
//---------------------------------------------------------





