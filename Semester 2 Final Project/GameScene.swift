//
//  GameScene.swift
//  Semester 2 Final Project
//
//  Created by Molly Mendez on 4/30/19.
//  Copyright © 2019 Molly Mendez. All rights reserved.
//

import SpriteKit
import GameplayKit

let tokenCategory: UInt32 = 2
let characterCategory: UInt32 = 1

class GameScene: SKScene, SKPhysicsContactDelegate {

    var token = SKSpriteNode(imageNamed: "coin")
    var counter = 0
    var player: SKSpriteNode!
    
    var scoreLabel: SKLabelNode!
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var character = SKSpriteNode()
    
    var ground = SKSpriteNode()
    
    var availableTokens = ["coin", "token1", "token2"]
    
//    var token = SKSpriteNode()
    
        //    token contact code

        func didBegin(_ contact: SKPhysicsContact) {
            if contact.bodyA.categoryBitMask == tokenCategory {
                changeToken(node: token)
            }
            if contact.bodyA.categoryBitMask == tokenCategory {
                counter += 1
                scoreLabel.text = "\(counter)"
            }
        }
        func changeToken(node:SKSpriteNode){
            node.removeAllActions()
            node.removeFromParent()
        }
    
    override func didMove(to view: SKView) {
                    token = self.childNode(withName: "token") as! SKSpriteNode
        character.physicsBody?.categoryBitMask = characterCategory
                    token.physicsBody?.categoryBitMask = tokenCategory
        character.physicsBody?.contactTestBitMask = tokenCategory
        createGestureRecognizer()
        //        character = self.childNode(withName: "Character") as! SKSpriteNode
        createGrounds()
        
        let playerCenter = CGPoint(x: -376, y: -65)
        player = SKSpriteNode(imageNamed: "bunny")
        player.position = playerCenter
        self.addChild(player)
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 157, height: 142), center: playerCenter)
        
        
        //**** Random Tokens *****

        func addToken () {
            availableTokens = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: availableTokens) as! [String]
            let token = SKSpriteNode(imageNamed: availableTokens[0])
            
            let randomTokenSpawn = GKRandomDistribution(lowestValue: -200, highestValue: 200)
            let position = CGFloat(randomTokenSpawn.nextInt())
            
            token.position = CGPoint(x: frame.size.width + token.size.width/2, y: position)
            //            token.physicsBody = SKPhysicsBody(rectangleOf: token.size)
            //            token.physicsBody?.isDynamic = true
            //            token.physicsBody?.collisionBitMask = 0
            //
            
            
            self.addChild(token)
            
            let duration:TimeInterval = 6
            var actionArray = [SKAction]()
            
            actionArray.append(SKAction.run(addToken))
            actionArray.append(SKAction.move(to: CGPoint(x: -token.size.width, y: position), duration: duration))
            actionArray.append(SKAction.removeFromParent())
            token.run(SKAction.sequence(actionArray))
            self.addChild(token)
        }
        
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
            }
            
                }
                
                addToken()
                
//                let playerCenter = CGPoint(x: -376, y: -65)
//                player = SKSpriteNode(imageNamed: "bunny")
//                player.position = playerCenter
//                self.addChild(player)
//                player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 157, height: 142), center: playerCenter)
//
//                run(SKAction.repeatForever(
//                    SKAction.sequence([
//                        SKAction.run(addToken),
//                        SKAction.wait(forDuration: 1.0)
//                        ])
//                ))
                
            }
    
    override func update(_ currentTime: TimeInterval) {
        moveGrounds()
    }
    
    
    //    *** Background ***
    func createGrounds() {
        
        
        for i in 0...3 {
            let ground = SKSpriteNode(imageNamed: "city")
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
        
        let upGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(whenSwiped(gesture:)))
        upGestureRecognizer.direction = .up
        self.view?.addGestureRecognizer(upGestureRecognizer)
    }
    
    @objc func whenSwiped(gesture: UISwipeGestureRecognizer) {
        print("Jump")
        if player.physicsBody?.velocity == CGVector(dx: 0, dy: 0) {
            //            player.physicsBody?.velocity.dy = 50
            //            let jump = CGVector(dx: 0, dy: 5)
            //            player.physicsBody?.applyForce(jump)
        }
    }
    
    
    
    
    
}
