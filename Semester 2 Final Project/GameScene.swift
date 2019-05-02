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
    
    var scoreLabel: SKEmitterNode!
    var score: Int = 0 {
        didSet {
        //    scoreLabel.text = "Score: \(score)"
        }
    }
    var character = SKSpriteNode()
    

    var ground = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        character = self.childNode(withName: "Character") as! SKSpriteNode
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        createGrounds()

        // Score
        
//        scoreLabel = SKLabelNode(text: "Score: 0")
//        scoreLabel
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveGrounds()
    }
    
    func createGrounds() {
        
        
        
        
        for i in 0...3 {
            let ground = SKSpriteNode(imageNamed: "background1")
            ground.name = "background"
            ground.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
            ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            ground.position = CGPoint(x: CGFloat(i) * ground.size.width, y: -(self.frame.size.height / 3000))
       
            self.addChild(ground)
        }
    }
    func moveGrounds() {
        self.enumerateChildNodes(withName: "background", using: ({
            (node,error) in
    
            node.position.x -= 2
            
            if node.position.x < -((self.scene?.size.width)!){
                node.position.x += (self.scene?.size.width)! * 3
            }
        }))
    }
    

}
