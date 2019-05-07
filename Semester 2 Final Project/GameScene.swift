//
//  GameScene.swift
//  Semester 2 Final Project
//
//  Created by Molly Mendez on 4/30/19.
//  Copyright © 2019 Molly Mendez. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    var player: SKSpriteNode!
    
     var scoreLabel: SKLabelNode!
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var character = SKSpriteNode()
    

    var ground = SKSpriteNode()
    
    override func didMove(to view: SKView) {
//        character = self.childNode(withName: "Character") as! SKSpriteNode
        createGrounds()

        // Score
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: -400, y: 240)
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = .black
     
       self.addChild(scoreLabel)
        
        // add/subtract score
        func collisionBetween(character: SKNode, object: SKNode) {
            if object.name == "token" {
                score += 1
            } else if object.name == "enemy" {
                score -= 1
                
                
                
                player = SKSpriteNode(imageNamed: "bunny")
                player.position = CGPoint(x: -376, y: -65)
                self.addChild(player)
                
                run(SKAction.repeatForever(
                    SKAction.sequence([
                        SKAction.run(addToken),
                        SKAction.wait(forDuration: 1.0)
                        ])
                ))
                
        }
    }
    }
    //**** Random Tokens *****
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addToken () {
        let token = SKSpriteNode(imageNamed: "Token")
        let actualY = random(min: token.size.height/2, max: size.height - token.size.height/2)
         token.position = CGPoint(x: size.width + token.size.width/2, y: actualY)
 //       let randomTokenPosition = GKRandomDistribution(lowestValue: 0, highestValue: 400)
//        let position = CGFloat(randomTokenPosition.nextInt())
        self.addChild(token)
        token.zPosition = 1
        
        
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
                let actionMove = SKAction.move(to: CGPoint(x: -token.size.width/2, y: actualY),
        duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        token.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        moveGrounds()
    }
    
    
//    *** Background ***
    func createGrounds() {
        for i in 0...3 {
            let ground = SKSpriteNode(imageNamed: "background1")
            ground.name = "background"
            ground.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
            ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            ground.position = CGPoint(x: CGFloat(i) * ground.size.width, y: -(self.frame.size.height / 3000))
             ground.zPosition = -1
            self.addChild(ground)
        }
    }
    func moveGrounds() {
        self.enumerateChildNodes(withName: "background", using: ({
            (node,error) in
    
            node.position.x -= 10
            
            if node.position.x < -((self.scene?.size.width)!){
                node.position.x += (self.scene?.size.width)! * 3
            }
        }))
    }

//    ***** Gesture Recognizer *****
    func createGestureRecognizer() {
//        let jumpGestureRecognizer = UITapGestureRecognizer(target: self
//            , action: #selector(tap))
//
//        view?.addGestureRecognizer(jumpGestureRecognizer)
        
        
   //     let upSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swiped:"))
//        upSwipeRecognizer.direction = .up
//        self.view?.addGestureRecognizer(upSwipeRecognizer)
    }
    
    
//    @objc func swiped (upSwipeRecognizer: UIGestureRecognizer) {
//        print("Jump")
//    }
    
    
    
    
    
    
    
    
    
    
}
