import SpriteKit

class SettingsScene: SKScene {
    
    var gameTimeSlider: UISlider?
    var bubbleNumberSlider: UISlider?
    var gameTimeValueLbl: SKLabelNode?
    var bubbleValueLbl: SKLabelNode?
    
    override func didMove(to view: SKView) {
        
        backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        
        addLabels()
        loadSlider()
    }
    
    func addLabels(){
        let highScoreLabel = SKLabelNode(text: "Settings")
        highScoreLabel.name = "highScore"
        highScoreLabel.fontName = "Noteworthy-Bold"
        highScoreLabel.fontSize = 40.0
        highScoreLabel.fontColor = UIColor.white
        highScoreLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 100)
        addChild(highScoreLabel)
        
        
        let gameTimeLbl = SKLabelNode(text: "Game Time (sec)")
        gameTimeLbl.name = "gameTimeLbl"
        gameTimeLbl.fontName = "Noteworthy-Bold"
        gameTimeLbl.fontSize = 20.0
        gameTimeLbl.fontColor = UIColor.white
        gameTimeLbl.position = CGPoint(x: frame.midX, y: frame.midY + 120)
        addChild(gameTimeLbl)
        
        if(gameTimeValueLbl == nil){
            gameTimeValueLbl = SKLabelNode(text: "\(UserDefaults.standard.integer(forKey: "gametime"))")
            gameTimeValueLbl?.name = "gameTimeValueLbl"
            gameTimeValueLbl?.fontName = "Noteworthy-Bold"
            gameTimeValueLbl?.fontSize = 20.0
            gameTimeValueLbl?.fontColor = UIColor.white
            gameTimeValueLbl?.position = CGPoint(x: frame.midX, y: frame.midY + 50)
            addChild(gameTimeValueLbl!)
        }
        
        
        let maxBubblesLbl = SKLabelNode(text: "Max Bubbles")
        maxBubblesLbl.name = "maxBubblesLbl"
        maxBubblesLbl.fontName = "Noteworthy-Bold"
        maxBubblesLbl.fontSize = 20.0
        maxBubblesLbl.fontColor = UIColor.white
        maxBubblesLbl.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        addChild(maxBubblesLbl)
        
        if(bubbleValueLbl == nil){
            bubbleValueLbl = SKLabelNode(text: "\(UserDefaults.standard.integer(forKey: "maximumBalls"))")
            bubbleValueLbl?.name = "bubbleValueLbl"
            bubbleValueLbl?.fontName = "Noteworthy-Bold"
            bubbleValueLbl?.fontSize = 20.0
            bubbleValueLbl?.fontColor = UIColor.white
            bubbleValueLbl?.position = CGPoint(x: frame.midX, y: frame.midY - 150)
            addChild(bubbleValueLbl!)
        }
        
        
        let goBackLabel = SKSpriteNode(imageNamed: "backbtn")
        goBackLabel.name = "goBack"
        goBackLabel.position = CGPoint(x: frame.midX, y: frame.minY + 100)
        addChild(goBackLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if touchedNode.name == "goBack" {
                
                let gameScene = MenuScene(size: view!.bounds.size)
                view!.presentScene(gameScene)
            }
        }
        
        
    }
    
    func loadSlider() {
        
        if(gameTimeSlider == nil){
            gameTimeSlider = UISlider()
            
            
            gameTimeSlider?.frame = CGRect(x: frame.minX + ((frame.width - 250) / 2), y: frame.midY - 100, width: 250, height: 35)
            
            
            gameTimeSlider?.minimumTrackTintColor = .red
            gameTimeSlider?.maximumTrackTintColor = .red
            gameTimeSlider?.thumbTintColor = .white
            
            gameTimeSlider?.maximumValue = 180
            gameTimeSlider?.minimumValue = 5
            gameTimeSlider?.setValue(Float(UserDefaults.standard.integer(forKey: "gametime")), animated: true)
            
            gameTimeSlider?.addTarget(self, action: #selector(SettingsScene.changeGameTimerValue(_:)), for: .valueChanged)
            
            
            
            view?.addSubview(gameTimeSlider!)
        }
        
        if(bubbleNumberSlider == nil){
            bubbleNumberSlider = UISlider()
            
            
            bubbleNumberSlider?.frame = CGRect(x: frame.minX + ((frame.width - 250) / 2), y: frame.midY + 100, width: 250, height: 35)
            
            
            bubbleNumberSlider?.minimumTrackTintColor = .red
            bubbleNumberSlider?.maximumTrackTintColor = .red
            bubbleNumberSlider?.thumbTintColor = .white
            
            bubbleNumberSlider?.maximumValue = 15
            bubbleNumberSlider?.minimumValue = 1
            bubbleNumberSlider?.setValue(Float( UserDefaults.standard.integer(forKey: "maximumBalls")), animated: true)
            
            bubbleNumberSlider?.addTarget(self, action: #selector(SettingsScene.changeMaxBubblesValue(_:)), for: .valueChanged)
            
            
            
            view?.addSubview(bubbleNumberSlider!)
        }
        
        
    }
    
    @objc func changeGameTimerValue(_ sender: UISlider){
        
        let value = Int(sender.value)
        let updatedTime = (value) - (value % 5)
        gameTimeSlider?.setValue(Float(updatedTime), animated: true)
        UserDefaults.standard.set(updatedTime,forKey: "gametime")
        gameTimeValueLbl?.text = String(updatedTime)
        
        
    }
    
    @objc func changeMaxBubblesValue(_ sender: UISlider){
        
        let updatedMaxBubbles = Int(sender.value)
        UserDefaults.standard.set(updatedMaxBubbles,forKey: "maximumBalls")
        bubbleValueLbl?.text = String(updatedMaxBubbles)
        
    }
    
    
    override func willMove(from view: SKView) {
        
        gameTimeSlider!.removeFromSuperview()
        bubbleNumberSlider!.removeFromSuperview()
    }
}
