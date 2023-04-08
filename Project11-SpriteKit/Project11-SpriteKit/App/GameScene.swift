//
//  GameScene.swift
//  Project11-SpriteKit
//  https://www.hackingwithswift.com/read/11/6/scores-on-the-board-sklabelnode
//  Created by Frank Chu on 3/7/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            self.scoreLabel.text = "Score: \(score)"
        }
    }
    
    var editLabel: SKLabelNode!
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                self.editLabel.text = "Done"
            } else {
                self.editLabel.text = "Edit"
            }
        }
    }
    
    override func didMove(to view: SKView) {
        
        // MARK: - background
        self.makeBackground(at: CGPoint(x: 512, y: 384))
        
        // MARK: - Slot
        for slotXPosition in stride(from: 128, through: 896, by: 256) {
            let isGood = slotXPosition == 128 || slotXPosition == 640
            self.makeSlot(at: CGPoint(x: slotXPosition, y: 0), isGood: isGood)
        }
        
        // MARK: - Bouncer
        for xPosition in stride(from: 0, through: 1024, by: 256) {
            self.makeBouncer(at: CGPoint(x: xPosition, y: 0))
        }
        
        // MARK: - ScoreLabel
        self.initScoreLabel(at: CGPoint(x: 980, y: 700))
        
        // MARK: - EditLabel
        self.initEditLabel(at: CGPoint(x: 80, y: 700))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            let objects = nodes(at: location)
            
            if objects.contains(self.editLabel) {
                self.editingMode.toggle()
            } else {
                if self.editingMode {
                    // create a box
                    makeBox(at: location)
                } else {
                    self.makeRedBall(at: location)
                }
            }
        }
        
    }
    
    func makeBox(at location: CGPoint) {
        let size = CGSize(width: Int.random(in: 16...128), height: 16)
        let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
        box.zRotation = CGFloat.random(in: 0...3)
        box.position = location
        
        box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
        box.physicsBody?.isDynamic = false
        self.addChild(box)
    }
    
    func makeRedBall(at location: CGPoint) {
        let ball = SKSpriteNode(imageNamed: Assets.Ball.randomBall().description)
        ball.position = location
        
        // img @2x 88 x 88 ==> 44 x 44 ==> dimensions = 22
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
        
        // This property is used to determine how much energy the physics body loses
        // when it bounces off another object. The property must be a value between 0.0 and 1.0. The default value is 0.2.
        ball.physicsBody?.restitution = 0.4
        
        // 通常情况下，将球体的 contactTestBitMask 属性设置为其 collisionBitMask 属性的值是一个常见的做法，
        // 这样可以确保球体能够检测到所有与其发生碰撞的物理体，并在必要时触发接触事件。
        ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
        
        ball.name = NameEnum.ball.description
        self.addChild(ball)
    }
    
    func initEditLabel(at position: CGPoint) {
        self.editLabel = SKLabelNode(fontNamed: "Chalkduster")
        self.editLabel.text = "Edit"
        self.editLabel.position = position
        
        self.addChild(self.editLabel)
    }
    
    func initScoreLabel(at position: CGPoint) {
        self.scoreLabel = SKLabelNode(fontNamed: Assets.fontChalkduster.description)
        self.scoreLabel.text = "Score: 0"
        
        // 将 scoreLabel 的水平对齐方式设置为右对齐。这意味着，scoreLabel 的位置会被固定在其父视图的右侧，而不是左侧或中心位置。
        self.scoreLabel.horizontalAlignmentMode = .right
        self.scoreLabel.position = position
        
        self.addChild(self.scoreLabel)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == NameEnum.ball.description {
            collisionBetween(ball: nodeA, object: nodeB)
        } else if nodeB.name == NameEnum.ball.description {
            collisionBetween(ball: nodeB, object: nodeA)
        }
    }
    
    func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == NameEnum.good.description {
            destory(ball: ball)
            self.score += 1
        } else if object.name == NameEnum.bad.description {
            destory(ball: ball)
            self.score -= 1
        }
    }
    
    func destory(ball: SKNode) {
//        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
//            fireParticles.position = ball.position
//            self.addChild(fireParticles)
//        }
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        else {
            print("No")
            print(Assets.fireParticles.description)
        }
        ball.removeFromParent()
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
    
        if isGood {
            slotBase = SKSpriteNode(imageNamed: Assets.slotBaseGood.description)
            slotGlow = SKSpriteNode(imageNamed: Assets.slotGlowGood.description)
            slotBase.name = NameEnum.good.description
        } else {
            slotBase = SKSpriteNode(imageNamed: Assets.slotBaseBad.description)
            slotGlow = SKSpriteNode(imageNamed: Assets.slotGlowBad.description)
            slotBase.name = NameEnum.bad.description
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        self.addChild(slotGlow)
        self.addChild(slotBase)
        
        let spin: SKAction = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever: SKAction = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    /// add bouncer to screen
    /// - Parameter position: position of bouncer
    func makeBouncer(at position: CGPoint) {
        let bouncer: SKSpriteNode = SKSpriteNode(imageNamed: Assets.bouncer.description)
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.physicsBody?.isDynamic = false
        self.addChild(bouncer)
    }
    
    /// set background picture and physical edge
    /// - Parameter position: background center position
    func makeBackground(at position: CGPoint) {
        // bgAsset
        let background = SKSpriteNode(imageNamed: Assets.background.description)

        // https://developer.apple.com/design/human-interface-guidelines/foundations/layout#platform-considerations
        // Remember, unlike UIKit SpriteKit positions things based on their center
        // – i.e., the point 0,0 refers to the horizontal and vertical center of a node.
        // iPad 9.7 inch screen size: 1024x768
        // https://www.ios-resolution.com/
        // var position: CGPoint { get set } .position The default value is (0.0,0.0).
        background.position = position
        
        // The blend mode used to draw the sprite into the parent’s framebuffer.
        // The source color replaces the destination color.
        // The .replace option means "just draw it, ignoring any alpha values,"
        // 在 SpriteKit 中，将混合模式设置为 .replace 可以使节点的颜色完全替换其下方的内容。
        // 这意味着，无论在其下方有什么，节点的颜色都会覆盖它。此外，将混合模式设置为 .replace 还可以提高渲染性能，因为它不需要执行任何颜色混合计算。
        background.blendMode = .replace
        
        background.zPosition = -1

        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsWorld.contactDelegate = self
        
        // Adds a node to the end of the receiver’s list of child nodes.
        self.addChild(background)
    }
    
}
