//
//  LevelUnit.swift
//  EndlessWorlds
//
//  Created by Justin Dike on 5/27/15.
//  Copyright (c) 2015 CartoonSmart. All rights reserved.
//

import Foundation
import SpriteKit

class LevelUnit:SKNode {
    
    var imageName:String = ""
    var backgroundSprite:SKSpriteNode = SKSpriteNode()
    var levelUnitWidth:CGFloat = 0
    var levelUnitHeight:CGFloat = 0
    var theType:LevelType = LevelType.grass
    
    var xAmount:CGFloat = 1  //essentially this is our speed
    var direction:CGFloat = 1 //will be saved as either 1 or -1
    var numberOfObjectsInLevel:UInt32 = 0
    var offscreenCounter:Int = 0 //anytime an object goes offscreen we add to this, for resetting speed purposes
    var topSpeedgrass:UInt32 = 5
    var topSpeedWater:UInt32 = 2
    var maxObjectsInLevelUnit:UInt32 = 5
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init () {
        
        super.init()
        
        

    }
    
    func setUpLevel(){
        
        let diceRoll = arc4random_uniform(2)
        
        if (diceRoll == 0) {
            imageName = "Water_Background"
            theType = LevelType.water
            
        } else if (diceRoll == 1) {
            imageName = "Grass_Background"
            theType = LevelType.grass
            
        }
        
        
    
        let theSize:CGSize = CGSize(width: levelUnitWidth, height: levelUnitHeight)
        let tex:SKTexture = SKTexture(imageNamed: imageName)
        backgroundSprite = SKSpriteNode(texture: tex, color: SKColor.clear, size: theSize)
        
        
        // backgroundSprite = SKSpriteNode(texture: nil, color:SKColor.blueColor(), size:theSize)
        
        self.addChild(backgroundSprite)
        self.name = "levelUnit"
        
        self.position = CGPoint(x: backgroundSprite.size.width / 2, y: 0)
        
        if (theType == LevelType.water) {
            
            backgroundSprite.physicsBody = SKPhysicsBody(rectangleOf: backgroundSprite.size)
            
            backgroundSprite.physicsBody!.categoryBitMask = BodyType.water.rawValue
            backgroundSprite.physicsBody!.contactTestBitMask = BodyType.water.rawValue
            backgroundSprite.physicsBody!.isDynamic = false
            
        } else if (theType == LevelType.grass){
            
            backgroundSprite.physicsBody = SKPhysicsBody(rectangleOf: backgroundSprite.size)
            
            backgroundSprite.physicsBody!.categoryBitMask = BodyType.grass.rawValue
            backgroundSprite.physicsBody!.contactTestBitMask = BodyType.grass.rawValue
            backgroundSprite.physicsBody!.isDynamic = false
            
        }

        
        createObstacle()
    }
    
    func createObstacle() {
        
      
       
        
        numberOfObjectsInLevel = arc4random_uniform(maxObjectsInLevelUnit)
        numberOfObjectsInLevel = numberOfObjectsInLevel + 1 // so it can't be 0
        
        
        
       
        
        
        if (theType == LevelType.grass) {
            
            for _ in 0 ..< Int(numberOfObjectsInLevel) {
            
           
                
                let randomX = arc4random_uniform(  UInt32 (backgroundSprite.size.width) )
                let randomY = arc4random_uniform(  UInt32 (backgroundSprite.size.height) )
                
                let obstacle:Object = Object()
                
                obstacle.xAmount = xAmount
                obstacle.theType = LevelType.grass
                
                
                obstacle.createObject()
                addChild(obstacle)
                
                
                obstacle.position = CGPoint(x: -(backgroundSprite.size.width / 2) + CGFloat(randomX) , y: -(backgroundSprite.size.height / 2) + CGFloat(randomY) )
                
            }
            
            
           
            
            
        } else if (theType == LevelType.water) {
            
            //was...
            //for (var i = 0; i < Int(numberOfObjectsInLevel); i += 1) {
            
            for _ in 0 ..< Int(numberOfObjectsInLevel) {
                
                
                let randomX = arc4random_uniform(  UInt32 (backgroundSprite.size.width) )
                let randomY = arc4random_uniform(  UInt32 (backgroundSprite.size.height) )
                
                let obstacle:Object = Object()
                
                obstacle.xAmount = xAmount
                obstacle.theType = LevelType.water
                
                obstacle.createObject()
                addChild(obstacle)
                
                
                obstacle.position = CGPoint(x: -(backgroundSprite.size.width / 2) + CGFloat(randomX) , y: -(backgroundSprite.size.height / 2) + CGFloat(randomY) )
                
            }
            
            
        }
        
        
       
        
    }
    
    
    
    
    
    
    
}













