//
//  GameScene.swift
//  Grappling Hook
//
//  Created by mitchell hudson on 7/4/16.
//  Copyright (c) 2016 mitchell hudson. All rights reserved.
//


/*
 
A possible solution to creating a grapplig hook mechanic for a game. 

This solution uses physics only for contact detection and all bodies are 
 dynamic false. So physics is not used in the example. I setup physics 
 bodies for possible future use. 
 
 The example presented here uses actions to move the rope target aand player object 
 to a target position on the screen. Using Actions provides a few advantages
 
    1. Actions are easily configured to set the time/speed and easing. 
    2. You could easily add other actions add other features to the animation. 
    3. Using actions allows the player easily follow the hook. In other words the 
        hook moves to the target before the player starts to follow. This may or may not 
        be a desired effect, using Actions gives great control here.
 
 The possible downsides to this system:
 
    1. Since objects are animated outside of physics you can not use physics collisions
        and "natural" physics motions. You can however use physics contacts. 
    2. To attach the hook to a moving target would difficult or impossible.
 
*/

import SpriteKit

class GameScene: SKScene {
    
    var player: SKSpriteNode!       // Player object moves to the target
    var rope: SKShapeNode!          // Draws a line between player and target
    var ropeTarget: SKSpriteNode!   // target object imagine this as the grappling hook
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // Edge loop
        // This is not used in the example you might use this to detect if objects enter or leave 
        // the screen.
        physicsBody = SKPhysicsBody(edgeLoopFromRect: view.frame)
        
        
        // Player
        let playerSize = CGSize(width: 30, height: 30)
        player = SKSpriteNode(color: UIColor.redColor(), size: playerSize)
        addChild(player)
        player.position.x = 200
        player.position.y = 100
        player.physicsBody = SKPhysicsBody(rectangleOfSize: playerSize)
        player.physicsBody?.allowsRotation = false
        // The player is a dynamic object so it will not collide with other objects
        player.physicsBody?.dynamic = false
        
        
        // Rope
        rope = SKShapeNode()
        addChild(rope)
        
        // Rope Target
        let ropeTargetSize = CGSize(width: 10, height: 10)
        ropeTarget = SKSpriteNode(color: UIColor.blueColor(), size: ropeTargetSize)
        addChild(ropeTarget)
        ropeTarget.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        // The rope target is dynamic false and as such will collide with other objects
        ropeTarget.physicsBody?.dynamic = false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        // Get the location of the touch
        let touch = touches.first!
        let location = touch.locationInNode(self)
        
        // Set up some actions that will move the target to the touch location
        let launchHook = SKAction.moveTo(location, duration: 0.25)
        ropeTarget.runAction(launchHook)
        // Setup an action that will move the player to the location of the touch
        // This time add a wait so the player follows a moment later.
        let wait = SKAction.waitForDuration(0.5)
        let movePlayer = SKAction.moveTo(location, duration: 0.25)
        let playerAction = SKAction.sequence([wait, movePlayer])
        player.runAction(playerAction)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        let ropePath = UIBezierPath()
        ropePath.moveToPoint(player.position)
        // ropePath.addLineToPoint(ropeTarget.position)
        let x = player.position.x // - (player.position.x - ropeTarget.position.x) / 2
        let y = ropeTarget.position.y
        let cPoint = CGPoint(x: x, y: y)
        ropePath.addQuadCurveToPoint(ropeTarget.position, controlPoint: cPoint)
        
        rope.path = ropePath.CGPath
        rope.strokeColor = UIColor.orangeColor()
        rope.glowWidth = 3
        rope.lineWidth = 4
        rope.lineCap = .Round
    }
}
