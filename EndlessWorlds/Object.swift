//
//  Object.swift
//  JoyStickControls
//
//  Created by Justin Dike on 5/4/15.
//  Copyright (c) 2015 CartoonSmart. All rights reserved.
//

import Foundation
import SpriteKit

class Object: SKNode {
    
    var objectSprite:SKSpriteNode = SKSpriteNode()
    var imageName:String = ""
    var xAmount :CGFloat = 1
    var theType:LevelType = LevelType.grass
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init () {
        
        super.init()
        
        
    }
    
    func createObject() {
        

        
        if (theType == LevelType.grass) {
            
             let diceRoll = arc4random_uniform(6)
            
            if ( diceRoll == 0) {
                
                imageName = "ground_object1"
                
            } else if ( diceRoll == 1) {
                
                imageName = "ground_object2"
                
            } else if ( diceRoll == 2) {
                
                imageName = "ground_object3"
                
            } else if ( diceRoll == 3) {
                
                imageName = "ground_object4"
                
            } else if ( diceRoll == 4) {
                
                imageName = "ground_object5"
                
            } else if ( diceRoll == 5) {
                
                imageName = "ground_object6"
                
            }

            
        } else if (theType == LevelType.water) {
            
            let diceRoll = arc4random_uniform(5)
            
            if ( diceRoll == 0) {
                
                imageName = "water_plant1"
                
            } else if ( diceRoll == 1) {
                
                imageName = "water_plant2"
                
            } else if ( diceRoll == 2) {
                
                imageName = "water_plant3"
                
            } else if ( diceRoll == 3) {
                
                imageName = "water_plant4"
                
            } else if ( diceRoll == 4) {
                
                imageName = "water_plant5"
                
            }
            
        }
        
        objectSprite = SKSpriteNode(imageNamed:imageName)
        
        
        
        self.addChild(objectSprite)
        
        if (theType == LevelType.grass) {
            
            if ( imageName == "ground_object6") {
                
                objectSprite.physicsBody = SKPhysicsBody(circleOfRadius: objectSprite.size.width / 1.8, center:CGPoint(x: 0, y: -20) )
                
            } else {
                
                objectSprite.physicsBody = SKPhysicsBody(circleOfRadius: objectSprite.size.width / 1.8)
                
            }
            
            
            objectSprite.physicsBody!.categoryBitMask = BodyType.grassObject.rawValue
            objectSprite.physicsBody!.contactTestBitMask = BodyType.grassObject.rawValue
            self.zPosition = 102
            
        } else if (theType == LevelType.water) {
            
            objectSprite.physicsBody = SKPhysicsBody(circleOfRadius: objectSprite.size.width / 2)
            objectSprite.physicsBody!.categoryBitMask = BodyType.waterObject.rawValue
            objectSprite.physicsBody!.contactTestBitMask = BodyType.waterObject.rawValue
            
            self.zPosition = 91
            
        }
        
        
        objectSprite.physicsBody!.friction = 1
        objectSprite.physicsBody!.isDynamic = false
        objectSprite.physicsBody!.affectedByGravity = false
        objectSprite.physicsBody!.restitution = 0.0
        objectSprite.physicsBody!.allowsRotation = false
        
        self.name = "obstacle"
       
        
        self.position = CGPoint(x: objectSprite.size.width / 2 ,  y: 0)
        
        if (xAmount > 0) {
            
            
            objectSprite.xScale = -1
        }
        
        
        
    }
    
    
   
    
    
    
}





