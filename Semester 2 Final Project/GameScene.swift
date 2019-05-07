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
    
    var scoreLabel: SKLabelNode!
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var character = SKSpriteNode()
    

    var ground = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
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
            }
            
        }
        createGestureRecognizer()
        
        
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
    
            node.position.x -= 10
            
            if node.position.x < -((self.scene?.size.width)!){
                node.position.x += (self.scene?.size.width)! * 3
            }
        }))
    }
    
    func createGestureRecognizer() {
        
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        gestureRecognizer.direction = .up
        self.view?.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        print("Jump")
    }
    
}
