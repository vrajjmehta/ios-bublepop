import SpriteKit
import UIKit

class MenuScene: SKScene, UITextFieldDelegate {
    
    var highScoreText: UITextField!
    var userNameErrorLbl : SKLabelNode?
    var themeColor = UIColor(red: 230/255, green: 172/255, blue: 0/255, alpha: 1.0)
    
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        
        addLabels(view: view)
        addDefaults()
        
    }
    
    //    func addLogo(){
    //        let logo = SKSpriteNode(imageNamed: "logo")
    //        logo.size = CGSize(width: frame.size.width/4, height: frame.size.width/4)
    //        logo.position = CGPoint(x: frame.midX, y: frame.midY + frame.size.height/4)
    //        addChild(logo)
    //    }
    
    func addLabels(view: SKView){
        
        let gameIcon = SKSpriteNode(imageNamed: "icon")
        gameIcon.name = "gameLogo"
        gameIcon.position = CGPoint(x: frame.midX, y: frame.maxY - 150)
        addChild(gameIcon)
      
        // Set Label Properties for Tap to Play
        let playLabel = SKLabelNode(text: "Tap to Play!")
        playLabel.name = "startGame"
        playLabel.fontName = "Marker Felt"
        playLabel.fontSize = 50.0
        playLabel.fontColor = themeColor
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY + 20)
        playLabel.zPosition = 10
        addChild(playLabel)
        animation(label: playLabel)
        
        // Set Label Properties for HighScore
        let highScoreLabel = SKLabelNode(text: "Highscore: " + "\(UserDefaults.standard.integer(forKey: "Highscore"))")
        highScoreLabel.name = "highScore"
        highScoreLabel.fontName = "Noteworthy-Bold"
        highScoreLabel.fontSize = 20.0
        highScoreLabel.fontColor = themeColor
        highScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highScoreLabel.frame.size.height*2)
        addChild(highScoreLabel)
        
        // Set Label Properties for RecentScores
        let recentScoreLabel = SKLabelNode(text: "Recentscore: " + "\(UserDefaults.standard.integer(forKey: "RecentScore"))")
        recentScoreLabel.name = "recent"
        recentScoreLabel.fontName = "Noteworthy-Bold"
        recentScoreLabel.fontSize = 20.0
        recentScoreLabel.fontColor = themeColor
        recentScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - recentScoreLabel.frame.size.height*5)
        addChild(recentScoreLabel)
        
        // Set Label Properties for Settings
        let settingsLabel = SKLabelNode(text: "Settings " )
        settingsLabel.name = "settings"
        settingsLabel.fontName = "Chalkduster"
        settingsLabel.fontSize = 20.0
        settingsLabel.fontColor = themeColor
        settingsLabel.position = CGPoint(x: frame.midX - 50, y: frame.minY + 100)
        addChild(settingsLabel)
        
        let scoreBoard = SKLabelNode(text: "Scores" )
        scoreBoard.name = "scoreBoard"
        scoreBoard.fontName = "Chalkduster"
        scoreBoard.fontSize = 20.0
        scoreBoard.fontColor = themeColor
        scoreBoard.position = CGPoint(x: frame.midX + 50 , y: frame.minY + 100)
        addChild(scoreBoard)
        
    }
    
    func addDefaults(){
//        UserDefaults.standard.removeObject(forKey: "scoreboard")
//        UserDefaults.standard.removeObject(forKey: "Highscore")
        if(UserDefaults.standard.integer(forKey: "gametime") == 0){
            UserDefaults.standard.set(60,forKey: "gametime")
            UserDefaults.standard.set(15,forKey: "maximumBalls")
        }
       
    }
    
    func animation(label: SKLabelNode){
        let fedOut = SKAction.fadeOut(withDuration: 0.5)
        let fedIn = SKAction.fadeIn(withDuration: 0.5)
        let sequence = SKAction.sequence([fedOut, fedIn])
        label.run(SKAction.repeatForever(sequence))
    }
    
    func showUsernameError(){
        if userNameErrorLbl == nil{
            userNameErrorLbl = SKLabelNode(text: "Please Enter a valid Player Name")
            userNameErrorLbl!.name = "userNameErrorLbl"
            userNameErrorLbl!.fontName = "Marker Felt"
            userNameErrorLbl!.fontSize = 10.0
            userNameErrorLbl!.fontColor = UIColor.red
            userNameErrorLbl!.position = CGPoint(x: frame.midX, y: frame.midY)
            addChild(userNameErrorLbl!)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
          
            if touchedNode.name == "startGame" {
                // Call the function here.
                
                
                let alert = UIAlertController(title: "Bubble PoP", message: "Please Enter your name", preferredStyle: .alert)
                
                
                alert.addTextField(configurationHandler: { (textField) -> Void in
                    textField.text = ""
                })
                
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    let textField = alert.textFields![0] as UITextField
                    
                    GameSettings.username = "\(textField.text!)"
                   
                    if(GameSettings.username != ""){
                        self.userNameErrorLbl?.removeFromParent()
                        let gameScene = GameScene(size: self.view!.bounds.size)
                        self.view!.presentScene(gameScene)
                    }else{
                        self.showUsernameError()
                    }
                    
                }))
                
                
                //                presentViewController(alert, animated: true, completion: nil)
                self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                
                
            }else if touchedNode.name == "scoreBoard" {
                // Call the function here.
                let highscoreScene = HighScoreScene(size: view!.bounds.size)
                view!.presentScene(highscoreScene)
            }else if touchedNode.name == "settings" {
                // Call the function here.
                let settingsScene = SettingsScene(size: view!.bounds.size)
                view!.presentScene(settingsScene)
            }
        }
        
        
    }
    
}
