//
//  ViewController.swift
//  SpaceShooter
//
//  Created by Matthew Prockup on 11/19/14.
//  Copyright (c) 2014 Matthew Prockup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //ONLY IPHONE: make all views global
    var alien:UIView = UIView()
    var spaceship:UIView = UIView()
    var laserbeam:UIView = UIView()
    var fireButton:UIButton = UIButton()
    var movementTimer:NSTimer = NSTimer()
    var alienSpeed:Double = 0.1
    
    // 1.)  Create SpaceView
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.blackColor()
        setupAlienView() //ONLY IPHONE:
        setupSpaceshipView()
        setupLaserbeamView()
        setupButton() //ONLY IPHONE:
        startAlienMovement(alienSpeed) //ONLY IPHONE:
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ONLY IPHONE: function to set up the all of the views
    func setupAlienView()
    {
        // 3.)  Create Alien
        let aH:CGFloat = 35
        let aW:CGFloat = 35
        let aX:CGFloat = view.frame.width/2 - halfOf(aW)
        let aY:CGFloat = 35
        alien = UIView(frame: CGRectMake(aX, aY, aW, aH))
        alien.backgroundColor = UIColor.greenColor()
        view.addSubview(alien)
        //---------------------------------------------------------
        
        // 7.)  ADDING RESOUCE IMAGES
        //      Drag images into the ImageAssets folder that is displayed
        
        //add alien image resources
        let alienImage = UIImage(named:"green_alien")
        let alienImageView:UIImageView = UIImageView(frame: CGRectMake(0,0, aW, aH))
        alienImageView.image = alienImage
        alien.backgroundColor = UIColor.clearColor()
        alien.addSubview(alienImageView)
    }
    
    func setupSpaceshipView()
    {
        
        // 5.)  Create Spaceship
        let sH:CGFloat = 100
        let sW:CGFloat = 100
        let sX:CGFloat = centerObject(view.frame.width, smallerObject:sW)
        let sY:CGFloat = view.frame.height-sH
        spaceship = UIView(frame: CGRectMake(sX,sY, sW, sH))
        spaceship.backgroundColor = UIColor.grayColor()
        view.addSubview(spaceship)
        //---------------------------------------------------------
        
        //add alien image resources
        let spaceshipImage = UIImage(named:"space_ship")
        let spaceshipImageView:UIImageView = UIImageView(frame: CGRectMake(0,0, sW, sH))
        spaceshipImageView.image = spaceshipImage
        spaceship.backgroundColor = UIColor.clearColor()
        spaceship.addSubview(spaceshipImageView)
        //---------------------------------------------------------
        
    }
        
    
    func setupLaserbeamView()
    {
        // 8.)  Add laser beam
        let lW:CGFloat = 4
        let lH:CGFloat = view.frame.height-spaceship.frame.height
        let lX:CGFloat = centerObject(view.frame.width,smallerObject:lW)
        let lY:CGFloat = 0
        laserbeam = UIView(frame: CGRectMake(lX, lY, lW, lH))
        laserbeam.backgroundColor = UIColor.redColor()
        view.addSubview(laserbeam)
        laserbeam.hidden=true
    }
    
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
    
    //Make the laser turn on and off
    func toggleLaser()
    {
        laserbeam.hidden = !laserbeam.hidden
    }
    
    // 10.) Create function to move the alien Back and forth
    var moveDistance:CGFloat = 5 //move distance increment
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
        alien.frame.origin.y = alien.frame.origin.y + 1
        
        if((alien.frame.origin.y + alien.frame.height) > (spaceship.frame.origin.y+alien.frame.height))
        {
            self.movementTimer.invalidate()
            gameOver()
        }
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
    
    //ONLY IPHONE: function to set up the fire button
    func setupButton()
    {
        let bH:CGFloat = 50
        let bW:CGFloat = 50
        let bX:CGFloat = view.frame.width - bW
        let bY:CGFloat = view.frame.height - bH
        let buttonImage = UIImage(named: "fire_button") as UIImage?
        fireButton = UIButton(frame: CGRectMake(bX, bY, bW, bH))
        fireButton.setImage(buttonImage, forState: .Normal)
        //call function firePressed when the button is touched
        fireButton.addTarget(self, action: "firePressed:", forControlEvents:.TouchDown)
        view.addSubview(fireButton)
    }
    
    //ONLY IPHONE: call this function when the fire button is pressed
    func firePressed(sender:UIButton)
    {
        toggleLaser()
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("turnOffLaser"), userInfo: nil, repeats: false)
        if(laserHitAlien())
        {
            alien.hidden=true
            alienHit()
            
        }
    }
    func turnOffLaser() {
        toggleLaser()
    }
    
    
    //ONLY IPHONE: call this function to start the alien movement
    func startAlienMovement(speed:Double)
    {
        movementTimer = NSTimer.scheduledTimerWithTimeInterval(speed, target: self, selector: Selector("moveAlien"), userInfo: nil, repeats: true)
    }
    
    
    func gameOver()
    {
        let alertController = UIAlertController(title: "Game Over", message: "The alien got past your space ship! Defense Fail!", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "sad face", style: .Cancel) { (_) in
            self.movementTimer.invalidate()
            self.alien.removeFromSuperview()
            self.setupAlienView()
            self.alienSpeed = 0.5
            self.startAlienMovement(self.alienSpeed)
        }
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true){}
    }
    
    func alienHit()
    {
        let alertController = UIAlertController(title: "Mission Success!", message: "You got the alien. Get ready, the next one will move faster!", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "GO", style: .Cancel) { (_) in
            self.movementTimer.invalidate()
            self.alien.removeFromSuperview()
            self.setupAlienView()
            self.alienSpeed = self.alienSpeed/2
            self.startAlienMovement(self.alienSpeed)
        }
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true){}
    }
    
    
    
    
}

