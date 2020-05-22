// --------Important INFO--------------
//This project is programmed using SpriteKit & GamePlayKit
//There are No Standard View Controllers as such, various "Scenes" make up the View Controller
//Also, In Storyboard you wont be able to see different views
//The views are dynamically created using SprikeKit

import SpriteKit

class HighScoreScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        labelsAdd()
    }
    
    func labelsAdd(){
        let labelHighScore = SKLabelNode(text: "HighScore  ")
        labelHighScore.name = "highScore"
        labelHighScore.fontName = "Noteworthy-Bold"
        labelHighScore.fontSize = 40.0
        labelHighScore.fontColor = UIColor(red: 230/255, green: 172/255, blue: 0/255, alpha: 1.0)
        labelHighScore.position = CGPoint(x: frame.midX, y: frame.maxY - labelHighScore.frame.size.height*2)
        addChild(labelHighScore)
        
        // Back button
        let labelBack = SKSpriteNode(imageNamed: "backbtn")
        labelBack.name = "goBack"
        labelBack.position = CGPoint(x: frame.midX, y: frame.minY + labelBack.frame.size.height)
        addChild(labelBack)
        
        let framePosition = frame.width / 6
        
        // Label for Rank
        let labelScoreIndex = SKLabelNode(text: "Rank")
        labelScoreIndex.name = "labelScoreIndex"
        labelScoreIndex.fontName = "Noteworthy-Bold"
        labelScoreIndex.fontSize = 20.0
        labelScoreIndex.fontColor = UIColor(red: 230/255, green: 172/255, blue: 0/255, alpha: 1.0)
        labelScoreIndex.position = CGPoint(x: framePosition, y: frame.maxY - labelHighScore.frame.size.height*3 )
        addChild(labelScoreIndex)
        
        // Label for Name
        let labelPlayerName = SKLabelNode(text: "Player Name")
        labelPlayerName.name = "labelPlayerName"
        labelPlayerName.fontName = "Noteworthy-Bold"
        labelPlayerName.fontSize = 20.0
        labelPlayerName.fontColor = UIColor(red: 230/255, green: 172/255, blue: 0/255, alpha: 1.0)
        labelPlayerName.position = CGPoint(x: framePosition*3, y: frame.maxY - labelHighScore.frame.size.height*3 )
        addChild(labelPlayerName)
        
        // Label for Score
        let scoreLbl = SKLabelNode(text: "Score")
        scoreLbl.name = "labelPlayerName"
        scoreLbl.fontName = "Noteworthy-Bold"
        scoreLbl.fontSize = 20.0
        scoreLbl.fontColor = UIColor(red: 230/255, green: 172/255, blue: 0/255, alpha: 1.0)
        scoreLbl.position = CGPoint(x: framePosition*5, y: frame.maxY - labelHighScore.frame.size.height*3 )
        addChild(scoreLbl)
        
        let headerYPosition = frame.maxY - labelHighScore.frame.size.height*4
        //get current string for scoreboard
        let currentScoreBoardObj = UserDefaults.standard.object(forKey: "scoreboard")
        
        if(currentScoreBoardObj != nil){
            if let decoded = UserDefaults.standard.object(forKey: "scoreboard") as? NSData {
                do {
                let array = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded as Data) as! [Scoreboard]
                
                //                var userScores : [Scoreboard] = array
                let sortedScores = array.sorted(by: { $0.playerScore > $1.playerScore })
                var index = 1
                for score in sortedScores {
                    generateLabelsForScore(index: index, name: score.playerName,score: score.playerScore, headerYPosition: headerYPosition)
                    index += 1
                    
                    if(index > 10){
                        break
                    }
                }
                }catch {
                    print("Error in Loading scoreboard data")
                }
            }
        }
    }
    
    func generateLabelsForScore(index: Int, name: String, score: Int, headerYPosition: CGFloat){
        let framePosition = frame.width / 6
        let scoreIndexValue = SKLabelNode(text: "\(index)")
        scoreIndexValue.name = "scoreIndexValue_\(index)"
        scoreIndexValue.fontName = "Noteworthy-Bold"
        scoreIndexValue.fontSize = 15.0
        scoreIndexValue.fontColor = UIColor.white
        scoreIndexValue.position = CGPoint(x: framePosition, y: headerYPosition -  CGFloat(Float((index*40))) )
        addChild(scoreIndexValue)

        let playerNameValue = SKLabelNode(text: "\(name)")
        playerNameValue.name = "playerNameValue_\(index)"
        playerNameValue.fontName = "Noteworthy-Bold"
        playerNameValue.fontSize = 15.0
        playerNameValue.fontColor = UIColor.white
        playerNameValue.position = CGPoint(x: framePosition*3, y:headerYPosition -  CGFloat(Float((index*40))) )
        addChild(playerNameValue)
        
        let scoreValue = SKLabelNode(text: "\(score)")
        scoreValue.name = "scoreValue_\(index)"
        scoreValue.fontName = "Noteworthy-Bold"
        scoreValue.fontSize = 15.0
        scoreValue.fontColor = UIColor.white
        scoreValue.position = CGPoint(x: framePosition*5, y: headerYPosition -  CGFloat(Float((index*40))) )
        addChild(scoreValue)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if touchedNode.name == "goBack" {
                
                let gameScene = MainScreen(size: view!.bounds.size)
                view!.presentScene(gameScene)
            }
        }
    }
}
