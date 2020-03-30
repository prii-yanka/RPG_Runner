//
//  GameScene.swift
//  EndlessWorlds
//
//  Created by Justin Dike on 5/20/15.
//  Copyright (c) 2015 CartoonSmart. All rights reserved.
//

import SpriteKit


enum BodyType:UInt32 {
    
    case player = 1
    case grassObject = 2
    case waterObject = 4
    case water = 8
    case grass = 16
    
    
}

enum MoveStates:Int {
    
    case n,s,e,w, ne,se,nw,sw, none
    
    
}

enum LevelType:UInt32 {
    
    case grass, water 
    
}


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    let swipeUpRec = UISwipeGestureRecognizer()
    let swipeDownRec = UISwipeGestureRecognizer()
    
    
   
    var levelUnitWidth:CGFloat = 0
    var levelUnitHeight:CGFloat = 0
    var initialUnits:Int = 9

    var screenWidth:CGFloat = 0
    var screenHeight:CGFloat = 0
    let worldNode:SKNode = SKNode()
    let thePlayer:Player = Player(imageNamed: "walknorth1")
    let shadow:SKSpriteNode = SKSpriteNode(imageNamed: "shadow")
    
    
    
    var levelUnitCurrentlyOn:LevelUnit?
    
    var isDead:Bool = false
    var clearOffscreenLevelUnits:Bool = false
    
    let startingPosition:CGPoint = CGPoint(x: 0, y: 0)
    
    var currentState = MoveStates.n
    
    var levelArray = [CGPoint]()
    
    
    
    
   // var nodeToMove:Object?
    // var moveInProgress:Bool = false
    
    
    
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        
        swipeRightRec.addTarget(self, action:#selector(GameScene.swipedRight))
        swipeRightRec.direction = .right
        self.view!.addGestureRecognizer(swipeRightRec)
        
        swipeLeftRec.addTarget(self, action: #selector(GameScene.swipedLeft))
        swipeLeftRec.direction = .left
        self.view!.addGestureRecognizer(swipeLeftRec)
        
        swipeUpRec.addTarget(self, action: #selector(GameScene.swipedUp))
        swipeUpRec.direction = .up
        self.view!.addGestureRecognizer(swipeUpRec)
        
        swipeDownRec.addTarget(self, action: #selector(GameScene.swipedDown))
        swipeDownRec.direction = .down
        self.view!.addGestureRecognizer(swipeDownRec)
        
        
        self.backgroundColor = SKColor.black
        screenWidth = self.view!.bounds.width
        screenHeight = self.view!.bounds.height
        
        levelUnitWidth = screenWidth
        levelUnitHeight = screenHeight
        
        physicsWorld.contactDelegate = self
        //physicsWorld.gravity = CGVector(dx:0.3, dy:0.0)
        
    
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
       
       addChild(worldNode)
        
        worldNode.addChild(thePlayer)
        thePlayer.position = startingPosition
        thePlayer.zPosition = 101
        
        worldNode.addChild(shadow)
        shadow.position = CGPoint( x: thePlayer.position.x,  y: thePlayer.position.y - 20)
        shadow.zPosition = 100
        
        createFirstLevelUnit()
        
       
    }
    
    
    @objc func swipedRight(){
        
        currentState = MoveStates.e
        thePlayer.startWalkEast()
        
        
    }
    
    @objc func swipedLeft(){
        
        currentState = MoveStates.w
         thePlayer.startWalkWest()
        
    }
    
    
    @objc func swipedDown(){
        
       currentState = MoveStates.s
         thePlayer.startWalkSouth()
        
    }
    
    
    @objc func swipedUp(){
        
        currentState = MoveStates.n
         thePlayer.startWalkNorth()
        
    }

    
    
    func resetLevel(){
        
        worldNode.enumerateChildNodes(withName: "levelUnit" ) {
            node, stop in
            
            node.removeFromParent()
            
            
        }
        
        
        createFirstLevelUnit()
        
        
    }
    
    
    func checkLevelUnitAroundLocation(_ theLocation:CGPoint, whereToPlace:MoveStates) {
        
        var xLocation:CGFloat = theLocation.x
        var yLocation:CGFloat = theLocation.y
        
        var createLevel:Bool  = true
        
        if ( whereToPlace == .n) {
            
            yLocation = theLocation.y + levelUnitHeight
            
        } else if ( whereToPlace == .s) {
            
            yLocation = theLocation.y - levelUnitHeight
            
        } else if ( whereToPlace == .e) {
            
            xLocation = theLocation.x + levelUnitWidth
            
        }  else if ( whereToPlace == .w) {
            
            xLocation = theLocation.x - levelUnitWidth
            
        } else if ( whereToPlace == .ne) {
            
            xLocation = theLocation.x + levelUnitWidth
            yLocation = theLocation.y + levelUnitHeight
            
        } else if ( whereToPlace == .se) {
            xLocation = theLocation.x + levelUnitWidth
            yLocation = theLocation.y - levelUnitHeight
            
        } else if ( whereToPlace == .sw) {
             xLocation = theLocation.x - levelUnitWidth
             yLocation = theLocation.y - levelUnitHeight
           
            
        }  else if ( whereToPlace == .nw) {
            xLocation = theLocation.x - levelUnitWidth
            yLocation = theLocation.y + levelUnitHeight
            
            
        }
        
        for item in levelArray {
            
            if (xLocation == item.x && yLocation == item.y) {
                
                createLevel = false
                print("level unit already exists here.")
            }
        
        }
        
        if (createLevel == true) {
            
            
            let levelUnit:LevelUnit = LevelUnit()
            worldNode.addChild(levelUnit)
            levelUnit.zPosition = -1
            levelUnit.levelUnitWidth = levelUnitWidth
            levelUnit.levelUnitHeight = levelUnitHeight
            levelUnit.setUpLevel()
            
            levelUnit.position = CGPoint( x: xLocation , y: yLocation)
            
            levelArray.append(levelUnit.position)
            
            //println(levelArray)
            
        }
        
        
        
    }
    
    
    
   
    
    func createFirstLevelUnit() {
        
      
        
        
        let levelUnit:LevelUnit = LevelUnit()
        worldNode.addChild(levelUnit)
        levelUnit.zPosition = -1
        levelUnit.levelUnitWidth = levelUnitWidth
        levelUnit.levelUnitHeight = levelUnitHeight
        levelUnit.setUpLevel()
        
        levelUnit.position = CGPoint( x: 0 , y: 0)
        
        levelArray.append(levelUnit.position)
        
      
        
        
    }
    
    
    
    
   
    
    func clearNodes(){
        
        
        var nodeCount:Int = 0
        
        worldNode.enumerateChildNodes(withName: "levelUnit") {
            node, stop in
            
            var removeTheItem:Bool = false
            
            let nodeLocation:CGPoint = self.convert(node.position, from: self.worldNode)
            
            if ( nodeLocation.x < -(self.screenWidth / 2) - self.levelUnitWidth ) {
                
                removeTheItem = true
               
                
            } else if ( nodeLocation.x > (self.screenWidth / 2) + self.levelUnitWidth ) {
                
                removeTheItem = true
                
                
            } else if ( nodeLocation.y > (self.screenHeight / 2) + self.levelUnitHeight ) {
                
                removeTheItem = true
                
                
            } else if ( nodeLocation.y < -(self.screenHeight / 2) - self.levelUnitHeight ) {
                
                removeTheItem = true
                
                
            } else {
                
                nodeCount += 1
                
                
            }
            
            
            if ( removeTheItem == true) {
                
                var i = 0
                for item in self.levelArray {
                    
                    if (node.position.x == item.x && node.position.y == item.y) {
                        
                        self.levelArray.remove(at: i)
                    }
                    
                    i += 1
                    
                }
                node.removeFromParent()
                
            }
            
            
        }
        
        print( "levelUnits in the scene is \(nodeCount)")
        
        
    }
    
    
   
    
    
    /*
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
       
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
          
            
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(worldNode)
            
          
        
        
        }
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
       
        
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        
    }

    */
    
    
   
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
        
        if (clearOffscreenLevelUnits == true) {
            
            
            clearNodes()
            
        }
        
        
        
        var xMove:CGFloat = 0
        var yMove:CGFloat = 0
        
        let baseSpeed:CGFloat = 5
        
        switch (currentState) {
            
        case .n:
                yMove = baseSpeed
                xMove = 0
            shadow.position = CGPoint( x: thePlayer.position.x,  y: thePlayer.position.y - 21)
        case .s:
                yMove = -baseSpeed
                xMove = 0
            shadow.position = CGPoint( x: thePlayer.position.x,  y: thePlayer.position.y - 35)
        case .e:
                yMove = 0
                xMove = baseSpeed
            shadow.position = CGPoint( x: thePlayer.position.x + 5,  y: thePlayer.position.y - 28)
        case .w:
                yMove = 0
                xMove = -baseSpeed
            shadow.position = CGPoint( x: thePlayer.position.x - 5,  y: thePlayer.position.y - 28)
        default:
                break
        
        }
        
        thePlayer.position = CGPoint(x: thePlayer.position.x + xMove, y: thePlayer.position.y + yMove)
            

        
    }
    
    
    override func didSimulatePhysics() {
        

        self.centerOnNode(thePlayer)
        
        if (levelUnitCurrentlyOn != nil) {
            
            checkIfNewLevelUnitsNeeded()
            
        }
        
        
    }
    
    
    
    func checkIfNewLevelUnitsNeeded() {
        
        
       // println(" Lets check for level units we might need")
        
        // pass the position into another function along with the compass direction of where to possibly make a new level unit
        
        
        checkLevelUnitAroundLocation(levelUnitCurrentlyOn!.position, whereToPlace:MoveStates.n)
        checkLevelUnitAroundLocation(levelUnitCurrentlyOn!.position, whereToPlace:MoveStates.s)
        checkLevelUnitAroundLocation(levelUnitCurrentlyOn!.position, whereToPlace:MoveStates.e)
        checkLevelUnitAroundLocation(levelUnitCurrentlyOn!.position, whereToPlace:MoveStates.w)
        checkLevelUnitAroundLocation(levelUnitCurrentlyOn!.position, whereToPlace:MoveStates.ne)
        checkLevelUnitAroundLocation(levelUnitCurrentlyOn!.position, whereToPlace:MoveStates.se)
        checkLevelUnitAroundLocation(levelUnitCurrentlyOn!.position, whereToPlace:MoveStates.sw)
        checkLevelUnitAroundLocation(levelUnitCurrentlyOn!.position, whereToPlace:MoveStates.nw)
        
        
    }
    
    
    
    func centerOnNode(_ node:SKNode) {
        
        let cameraPositionInScene:CGPoint = self.convert(node.position, from: worldNode)
        worldNode.position = CGPoint(x: worldNode.position.x - cameraPositionInScene.x , y:worldNode.position.y - cameraPositionInScene.y  )
        
      
        
    }
    
    
    
    
    
 
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        
       // let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        
        
        
        //// check on water
        
        if (contact.bodyA.categoryBitMask == BodyType.player.rawValue  && contact.bodyB.categoryBitMask == BodyType.water.rawValue ) {
            
            levelUnitCurrentlyOn = contact.bodyB.node!.parent as? LevelUnit
           
           
            
        } else if (contact.bodyA.categoryBitMask == BodyType.water.rawValue  && contact.bodyB.categoryBitMask == BodyType.player.rawValue ) {
            
            levelUnitCurrentlyOn = contact.bodyA.node!.parent as? LevelUnit
            
            
        }
        
        
        
       

        //// check on grass
        
        if (contact.bodyA.categoryBitMask == BodyType.player.rawValue  && contact.bodyB.categoryBitMask == BodyType.grass.rawValue ) {
         
           levelUnitCurrentlyOn = contact.bodyB.node!.parent as? LevelUnit
            
            
        } else if (contact.bodyA.categoryBitMask == BodyType.grass.rawValue  && contact.bodyB.categoryBitMask == BodyType.player.rawValue ) {
            
          
            levelUnitCurrentlyOn = contact.bodyA.node!.parent as? LevelUnit
            
        }
        
        
        
        
        
    }
    
    

    
    
    
    
    
    /*
    func didEndContact(contact: SKPhysicsContact) {
        
        
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch (contactMask) {
            
            
            
        case BodyType.waterObject.rawValue | BodyType.player.rawValue:
            
           
            
           
            
        default:
            return
            
            
        }
    }
*/
    
    
    func killPlayer() {
        
        
        if ( isDead == false) {
            
            isDead = true
            
            let fadeOut:SKAction = SKAction.fadeAlpha(to: 0, duration: 0.2)
            let move:SKAction = SKAction.move(to: startingPosition, duration: 0.2)
            let block:SKAction = SKAction.run(revivePlayer)
            let seq:SKAction = SKAction.sequence([fadeOut, move, block])
            
            thePlayer.run(seq)
            
            
        }
        
        
        
    }
    
    func revivePlayer() {
        
        isDead = false
     
        
        
        let fadeOut:SKAction = SKAction.fadeAlpha(to: 0, duration: 0.2)
        let block:SKAction = SKAction.run(resetLevel)
        let fadeIn:SKAction = SKAction.fadeAlpha(to: 1, duration: 0.2)
        let seq:SKAction = SKAction.sequence([fadeOut, block, fadeIn])
        worldNode.run(seq)
        
        let wait:SKAction = SKAction.wait(forDuration: 1)
        let fadeIn2:SKAction = SKAction.fadeAlpha(to: 1, duration: 0.2)
        let seq2:SKAction = SKAction.sequence([wait , fadeIn2])
        thePlayer.run(seq2)
        
    }
    
    
    
    
    
    
}











