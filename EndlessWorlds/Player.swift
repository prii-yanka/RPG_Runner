//
//  Player.swift
//  JoyStickControls
//
//  Created by Justin Dike on 5/4/15.
//  Copyright (c) 2015 CartoonSmart. All rights reserved.
//

import Foundation
import SpriteKit



class Player: SKSpriteNode {
    
   
    var walkSouth:SKAction?
    var walkNorth:SKAction?
    var walkEast:SKAction?
    var walkWest:SKAction?
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init (imageNamed:String) {
        
        let imageTexture = SKTexture(imageNamed: imageNamed)
        super.init(texture: imageTexture, color:SKColor.clear, size: imageTexture.size() )
        
        let body:SKPhysicsBody = SKPhysicsBody(circleOfRadius: imageTexture.size().width / 2 )
        body.isDynamic = true
        body.affectedByGravity = false
        body.allowsRotation = false
        body.restitution = 0.3
        body.categoryBitMask = BodyType.player.rawValue
        body.contactTestBitMask = BodyType.grassObject.rawValue | BodyType.waterObject.rawValue | BodyType.water.rawValue | BodyType.grass.rawValue
        body.collisionBitMask = BodyType.grassObject.rawValue
        body.friction = 0.9 //0 is like glass, 1 is like sandpaper to walk on
        self.physicsBody = body
        
        
        setUpWalkEast()
        setUpWalkWest()
        setUpWalkNorth()
        
        setUpWalkSouth()
        
        startWalkNorth()
        
        
    }
    
    func update() {
        
        
        
    }
    
    func setUpWalkNorth() {
        
        let atlas = SKTextureAtlas (named: "Girl")
        
        var array = [String]()
        
        //or setup an array with exactly the sequential frames start from 1 to 4
        
        for i in 1 ... 4 {
      
            
            let nameString = String(format: "walknorth%i", i)
            array.append(nameString)
            
        }
        
        //create another array this time with SKTexture as the type (textures being the .png images)
        var atlasTextures:[SKTexture] = []
        
        for i in 0 ..< array.count  {
            
            let texture:SKTexture = atlas.textureNamed( array[i] )
            atlasTextures.insert(texture, at:i)
            
        }
        
        let atlasAnimation = SKAction.animate(with: atlasTextures, timePerFrame: 1.0/10, resize: true , restore:false )
        walkNorth =  SKAction.repeatForever(atlasAnimation)
        
        
        
    }
    
    
    func setUpWalkSouth() {
        
        let atlas = SKTextureAtlas (named: "Girl")
        
        var array = [String]()
        
        //or setup an array with exactly the sequential frames start from 1 to 4
        
       for i in 1 ... 4 {
            
            let nameString = String(format: "walksouth%i", i)
            array.append(nameString)
            
        }
        
        //create another array this time with SKTexture as the type (textures being the .png images)
        var atlasTextures:[SKTexture] = []
        
        for i in 0 ..< array.count  {
            
            let texture:SKTexture = atlas.textureNamed( array[i] )
            atlasTextures.insert(texture, at:i)
            
        }
        
        let atlasAnimation = SKAction.animate(with: atlasTextures, timePerFrame: 1.0/10, resize: true , restore:false )
        walkSouth =  SKAction.repeatForever(atlasAnimation)
        
        
        
    }
    
    func setUpWalkEast() {
        
        let atlas = SKTextureAtlas (named: "Girl")
        
        var array = [String]()
        
        //or setup an array with exactly the sequential frames start from 1 to 4
        
        for i in 1 ... 4 {
            
            let nameString = String(format: "walkeast%i", i)
            array.append(nameString)
            
        }
        
        //create another array this time with SKTexture as the type (textures being the .png images)
        var atlasTextures:[SKTexture] = []
        
        for i in 0 ..< array.count  {
            
            let texture:SKTexture = atlas.textureNamed( array[i] )
            atlasTextures.insert(texture, at:i)
            
        }
        
        let atlasAnimation = SKAction.animate(with: atlasTextures, timePerFrame: 1.0/10, resize: true , restore:false )
        walkEast =  SKAction.repeatForever(atlasAnimation)
        
        
        
    }
    
    func setUpWalkWest() {
        
        let atlas = SKTextureAtlas (named: "Girl")
        
        var array = [String]()
        
        //or setup an array with exactly the sequential frames start from 1 to 4
        
       
        
        for i in 1 ... 4 {
            
            let nameString = String(format: "walkwest%i", i)
            array.append(nameString)
            
        }
        
        //create another array this time with SKTexture as the type (textures being the .png images)
        var atlasTextures:[SKTexture] = []
        
        for i in 0 ..< array.count  {
            
            let texture:SKTexture = atlas.textureNamed( array[i] )
            atlasTextures.insert(texture, at:i)
            
        }
        
        let atlasAnimation = SKAction.animate(with: atlasTextures, timePerFrame: 1.0/10, resize: true , restore:false )
        walkWest =  SKAction.repeatForever(atlasAnimation)
        
        
        
    }
    
    
    
    
    func startWalkNorth(){
        
        self.run(walkNorth!)
        
    }
    func startWalkWest(){
        
        self.run(walkWest!)
        
    }
    func startWalkSouth(){
        
        self.run(walkSouth!)
        
    }
    func startWalkEast(){
        
        self.run(walkEast!)
        
    }
    
    
    
}















