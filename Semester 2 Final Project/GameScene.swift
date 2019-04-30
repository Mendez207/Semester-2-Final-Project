//
//  GameScene.swift
//  Semester 2 Final Project
//
//  Created by Molly Mendez on 4/30/19.
//  Copyright © 2019 Molly Mendez. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    let background = SKSpriteNode(imageNamed: "background1")
    let background2 = SKSpriteNode(imageNamed: "background1")
    
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.blue
        
        background.anchorPoint =
        background.position =
        background.zPosition =
        addChild(background)
}
}
