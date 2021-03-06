//
//  GameScene.swift
//  Semester 2 Final Project
//
//  Created by Molly Mendez on 4/30/19.
//  Copyright © 2019 Molly Mendez. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

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
            scoreLabel.fontName = "Verdana-Bold"
            scoreLabel.position = CGPoint(x: -500, y: 240)
        }
    }
    var character = SKSpriteNode()
    var ground = SKSpriteNode()
    var audioPlayer: AVAudioPlayer!
    
    //code for token to disappear and make score go up
    func didBegin(_ contact: SKPhysicsContact){
        let bodyAName = contact.bodyA.node?.name
        let bodyBName = contact.bodyB.node?.name
        
        if bodyAName == "character" && bodyBName == "coin" || bodyAName == "coin" && bodyBName == "character"{
            if bodyAName == "coin"{
                audioPlayer.play()
                contact.bodyA.node?.removeFromParent()
                score += 1
            } else if bodyBName == "coin"{
                audioPlayer.play()
                contact.bodyB.node?.removeFromParent()
                score += 1
            }
        }
        
    }
    var availableTokens = ["coin", "token1", "token2"]
    
    override func didMove(to view: SKView) {
       
        //    character code
        createGestureRecognizer()
        character = self.childNode(withName: "character") as! SKSpriteNode
        self.physicsWorld.contactDelegate = self
       
           createGrounds()
        let playerCenter = CGPoint(x: -376, y: -65)
        player = SKSpriteNode(imageNamed: "bunny")
        player.position = playerCenter
        self.addChild(player)
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 157, height: 142), center: playerCenter)
        
        let urlPath = Bundle.main.url(forResource: "coinSoundEffect", withExtension: "wav")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: urlPath!)
            audioPlayer.prepareToPlay()
        } catch {
            print("Error!")
        }
       
        //**** Random Tokens *****
//        func addToken () {
//            availableTokens = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: availableTokens) as! [String]
//            let token = SKSpriteNode(imageNamed: availableTokens[0])
//            let token.name = "coin"
//
//            let randomTokenSpawn = GKRandomDistribution(lowestValue: 0, highestValue: 200)
//            let position = CGFloat(randomTokenSpawn.nextInt())
//
//            token.position = CGPoint(x: frame.size.width + token.size.width/2, y: position)
//            self.addChild(token)
//
//            let moveDuration:TimeInterval = 6
//            var actionArray = [SKAction]()
//
//            actionArray.append(SKAction.wait(forDuration: 3))
//            actionArray.append(SKAction.run(addToken))
//            actionArray.append(SKAction.move(to: CGPoint(x: -550.00, y: position), duration: moveDuration))
//            actionArray.append(SKAction.wait(forDuration: 5))
//            actionArray.append(SKAction.removeFromParent())
//            token.run(SKAction.sequence(actionArray))
//        }
        
        // Score
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.fontName = "Verdana-Bold"
        scoreLabel.position = CGPoint(x: -500, y: 240)
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = .blue
        
        self.addChild(scoreLabel)
        
        // add/subtract score
        func collisionBetween(character: SKNode, object: SKNode) {
            if object.name == "coin" {
                score += 1
            } else if object.name == "enemy" {
                score -= 1
            }
        }
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
    
    let upGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(whenSwiped(gesture: )))
    upGestureRecognizer.direction = .up
    self.view?.addGestureRecognizer(upGestureRecognizer)
    
}

@objc func whenSwiped(gesture: UISwipeGestureRecognizer) {
    print("Jump")
    //        print(character)
    let jump = CGVector(dx: 0, dy: 1000)
          character.physicsBody?.velocity = jump
    character = SKSpriteNode(imageNamed: "jumpingKangaroo")
    
    if character.physicsBody?.velocity.dy == 0 {
        character.physicsBody?.velocity = jump
        print("Not Moving")
    } else {
        print("Moving")
    }
}


}








