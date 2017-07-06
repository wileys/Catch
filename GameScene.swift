//
//  GameScene.swift
//  Catch
//
//  Created by Wiley Siler on 7/5/17.
//  Copyright © 2017 Wiley Siler. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ball: SKSpriteNode!
    var deathBar: SKSpriteNode!
    var timer: CFTimeInterval = 0
    var paddleTimer: CFTimeInterval = 0
    let fixedDelta: CFTimeInterval = 1.0 / 60.0
    var tapCount = 0
    var topWin: SKLabelNode!
    var bottomWin: SKLabelNode!
   
    var impulse = 300
    var impulseDown = -3
    
    
    override func didMove(to view: SKView) {
        ball = childNode(withName: "ball") as! SKSpriteNode
        deathBar = childNode(withName: "deathBar") as! SKSpriteNode
        topWin = childNode(withName:"topWin") as! SKLabelNode
        bottomWin = childNode(withName:"bottomWin") as! SKLabelNode
    
        topWin.isHidden = true
        bottomWin.isHidden = true
        
        physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx:0, dy:0)
        
        
    
    }
    
  
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        switch tapCount {
            case 5:
                impulse = 400
                impulseDown = -5
            case 10:
                impulse = 500
                impulseDown = -9
            case 15:
                impulse = 600
                impulseDown = -12
            case 20:
                impulse = 700
                impulseDown = -15
            default: break
        }
        
        
        self.physicsWorld.gravity = CGVector(dx:impulseDown, dy:0)
        let touch = touches.first!
        
        /* Get touch position in scene */
        let location = touch.location(in:self)
        
        
        if tapCount == 0 {
            /* Was touch on left/right hand of screen? */
            if location.y > size.height/2 && ball.position.y > size.height/2 {
                ball.physicsBody?.velocity = CGVector(dx:0, dy:0)
        
                
                /* Apply vertical impulse */
                ball.physicsBody?.applyImpulse(CGVector(dx: 100, dy: -impulse))
                tapCount += 1
                
            } else if location.y < size.height/2 && ball.position.y < size.height/2 {
                ball.physicsBody?.velocity = CGVector(dx:0, dy:0)
                
                /* Apply vertical impulse */
                ball.physicsBody?.applyImpulse(CGVector(dx: 100, dy: impulse))
                tapCount += 1
            }
        } else {
        
            if  ball.position.y < size.height/2 {
                
                if location.x < ball.position.x + 100 && location.y < ball.position.y + 100 {
                    if location.x > ball.position.x && location.y > ball.position.y {
                    
                        print("I worked")
                        ball.physicsBody?.velocity = CGVector(dx:0, dy:0)
                        
                        
                        /* Apply vertical impulse */
                        ball.physicsBody?.applyImpulse(CGVector(dx: 100, dy: -impulse))
                        tapCount += 1
                        
                }
                    
            } else if  ball.position.y < size.height/2 {
                    
                
                if location.x < ball.position.x + 100 && location.y < ball.position.y + 100 {
                    if location.x > ball.position.x && location.y > ball.position.y {
                        
                        print("I worked")
                    
                    ball.physicsBody?.velocity = CGVector(dx:0, dy:0)
                    
                    /* Apply vertical impulse */
                    ball.physicsBody?.applyImpulse(CGVector(dx: 100, dy: impulse))
                    tapCount += 1
                    }
                }
            }

        }
        
    }
}
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        timer += fixedDelta
        
//        if timer == 5 {
//            self.physicsWorld.gravity = CGVector(dx:-5, dy: 0)
//            print("Done")
//        }
//        if timer == 7 {
//            self.physicsWorld.gravity = CGVector(dx:-6, dy: 0)
//            ball.physicsBody?.applyImpulse(CGVector(dx: -50, dy: 0))
//            print("Done")
//
//        }
//        
//        if timer == 9 {
//            self.physicsWorld.gravity = CGVector(dx:-7, dy: 0)
//            ball.physicsBody?.applyImpulse(CGVector(dx: -50, dy: 0))
//            print("Done")
//
//
//        }
//        
//        if timer == 11 {
//            self.physicsWorld.gravity = CGVector(dx:-9, dy: 0)
//            ball.physicsBody?.applyImpulse(CGVector(dx: -50, dy: 0))
//            print("Done")
//
//        }
//        
//        if timer == 13 {
//            self.physicsWorld.gravity = CGVector(dx:-11, dy: 0)
//            ball.physicsBody?.applyImpulse(CGVector(dx: -50, dy: 0))
//            print("Done")
//
//
//        }
    
        
    }

    func didBegin (_ contact: SKPhysicsContact) {
        
        let pulse:SKAction = SKAction.init(named: "Pulse")!
        
        /* Hero touches anything, game over */
        
        /* Get references to bodies involved */
        let contactA = contact.bodyA
        let contactB = contact.bodyB
        
        /* Get references to the physics bodies */
        let nodeA = contactA.node!
        let nodeB = contactB.node!
        
        
        if nodeA.name == "deathBar" || nodeB.name == "deathBar" {
            
            ball.physicsBody?.velocity = CGVector(dx:0, dy:0)
            self.physicsWorld.gravity = CGVector(dx:0, dy:0)
            ball.run(pulse)
            self.view?.isUserInteractionEnabled = false
            
            
            if ball.position.y > size.height/2 {
                bottomWin.isHidden = false
                
            } else if ball.position.y < size.height/2 {
                topWin.isHidden = false

            }

            
            return


        }
    }
    
    
    
}
