// --------Important INFO--------------
//This project is programmed using SpriteKit & GamePlayKit
//There are No Standard View Controllers as such, various "Scenes" make up the View Controller
//Also, In Storyboard you wont be able to see different views
//The views are dynamically created using SprikeKit

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var bubbles: [SKSpriteNode] = []
    var bubbleTypes: [Bubble] = []
    var previousBubble = ""
    var isGameOver = false
    var previousPoppedType: Bubble?
    var scoreLblVal : SKLabelNode?
    var timeLeftVal : SKLabelNode?
    var highScoreVal : SKLabelNode?
    var welcomeTimeLbl : SKLabelNode?
    var welcomePanel : SKSpriteNode?
    var gameTimer : Timer?
    var bubbleTimer : Timer?
    var welcomeTimer : Timer?
    var previousPoppedScore = 0
    var gameTime = 0
    var timerCount = 0
    var welcomeTime = 3
    var score :Double = 0.0
    var highScore = 0
    var refreshRate = 1.0
    let animateScore = SKAction.sequence([SKAction.scale(to: 2.0, duration: 0.05), SKAction.wait(forDuration: 0.05), SKAction.scale(to: 1.0, duration: 0.50)])
    let animateBall = SKAction.sequence([SKAction.scale(to: 1.5, duration: 0.05), SKAction.wait(forDuration: 0.05), SKAction.scale(to: 0.8, duration: 0.00)])
    let welcomeTimerAnimate = SKAction.sequence([SKAction.fadeOut(withDuration: 0.0), SKAction.fadeIn(withDuration: 1.00)])
    let defaultColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
    
    override func didMove(to view: SKView) {
        backgroundColor = defaultColor
        initaliseBubble()
        displayWelcomeScreen()
        startCountdown()
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self as? SKPhysicsContactDelegate
        
    }
    
    // Show welcome Panel with count down
    func displayWelcomeScreen(){
        if welcomeTimeLbl == nil{
            welcomeTimeLbl = SKLabelNode(text: "\(welcomeTime)")
            welcomeTimeLbl!.name = "welcomeTimeLbl"
            welcomeTimeLbl!.fontName = "Helvetica"
            welcomeTimeLbl!.fontSize = 40.0
            welcomeTimeLbl!.fontColor = UIColor(red: 230/255, green: 172/255, blue: 0/255, alpha: 1.0)
            welcomeTimeLbl!.position = CGPoint(x:frame.midX, y: frame.midY)
            welcomeTimeLbl!.zPosition = 10
            welcomeTimeLbl!.run(welcomeTimerAnimate)
        }
        addChild(welcomeTimeLbl!)
    }
   
    // Start Game after welcome timer.
    // Initiate game timer and bubble timer
    // Create Labels
    func startGame(){
        labelsAdd()
        initaliseGameTimer()
        bubbleGameTimer()
        gameTime = UserDefaults.standard.integer(forKey: "gametime")
        highScore = UserDefaults.standard.integer(forKey: "Highscore")
        updateTimer()
        generateNewBubble()
    }
    
    // Add top labels such as Timer, score and highscore
    func labelsAdd(){
        
        let framePosition = frame.width / 6
        
        let timeLeftLbl = SKLabelNode(text: "Time Left")
        timeLeftLbl.name = "timeLeftLbl"
        timeLeftLbl.fontName = "Chalkduster"
        timeLeftLbl.fontSize = 15.0
        timeLeftLbl.fontColor = UIColor(red: 230/255, green: 172/255, blue: 0/255, alpha: 1.0)
        timeLeftLbl.zPosition = 5
        timeLeftLbl.position = CGPoint(x: framePosition, y: frame.maxY - timeLeftLbl.frame.size.height*4 )
        addChild(timeLeftLbl)
        
        if timeLeftVal == nil{
            timeLeftVal = SKLabelNode(text: "00:00")
            timeLeftVal!.name = "timeLeftVal"
            timeLeftVal!.fontName = "Marker Felt"
            timeLeftVal!.fontSize = 25.0
            timeLeftVal!.fontColor = UIColor(red: 230/255, green: 172/255, blue: 0/255, alpha: 1.0)
            timeLeftVal!.zPosition = 5
            timeLeftVal!.position = CGPoint(x:framePosition, y: frame.maxY - timeLeftLbl.frame.size.height*6 )
            addChild(timeLeftVal!)
        }
        
        let scoreLbl = SKLabelNode(text: "Score")
        scoreLbl.name = "scoreLbl"
        scoreLbl.fontName = "Chalkduster"
        scoreLbl.fontSize = 15.0
        scoreLbl.fontColor = UIColor(red: 230/255, green: 172/255, blue: 0/255, alpha: 1.0)
        scoreLbl.zPosition = 5
        scoreLbl.position = CGPoint(x: framePosition*3, y: frame.maxY - timeLeftLbl.frame.size.height*4 )
        addChild(scoreLbl)
        
        if scoreLblVal == nil {
            scoreLblVal = SKLabelNode(text: "\(Int(score))")
            scoreLblVal!.name = "scoreLblVal"
            scoreLblVal!.fontName = "Marker Felt"
            scoreLblVal!.fontSize = 25.0
            scoreLblVal!.fontColor = UIColor(red: 230/255, green: 172/255, blue: 0/255, alpha: 1.0)
            scoreLblVal!.zPosition = 5
            scoreLblVal!.position = CGPoint(x: framePosition*3, y: frame.maxY - timeLeftLbl.frame.size.height*6)
            addChild(scoreLblVal!)
        }
        
        let highScoreLbl = SKLabelNode(text: "High Score")
        highScoreLbl.name = "scoreLbl"
        highScoreLbl.fontName = "Chalkduster"
        highScoreLbl.fontSize = 15.0
        highScoreLbl.fontColor = UIColor(red: 230/255, green: 172/255, blue: 0/255, alpha: 1.0)
        highScoreLbl.zPosition = 5
        highScoreLbl.position = CGPoint(x: framePosition*5, y: frame.maxY - timeLeftLbl.frame.size.height*4 )
        addChild(highScoreLbl)
        
        if highScoreVal == nil {
            highScoreVal = SKLabelNode(text: "\(UserDefaults.standard.integer(forKey: "Highscore"))")
            highScoreVal!.name = "highScoreVal"
            highScoreVal!.fontName = "Marker Felt"
            highScoreVal!.fontSize = 25.0
            highScoreVal!.fontColor = UIColor(red: 230/255, green: 172/255, blue: 0/255, alpha: 1.0)
            highScoreVal!.zPosition = 5
            highScoreVal!.position = CGPoint(x: framePosition*5, y: frame.maxY - timeLeftLbl.frame.size.height*6 )
            addChild(highScoreVal!)
        }
    }
    
   // Method returns UIColor of the bubble
   func getUIColor(strColor: String) -> UIColor{
       switch strColor {
       case "Green":
           return  UIColor.green
       case "Blue":
           return  UIColor.blue
       case "Black":
           return  UIColor.black
       case "Red":
           return UIColor.red
       case "Pink":
           return UIColor(red: 255/255, green: 0/255, blue: 144/255, alpha: 1.0)
       default:
           return  UIColor.white
       }
   }
       
    // Initiate Bubbles
    func initaliseBubble()  {
        bubbleTypes.append(Bubble(bubbleType: "Pink",bubbleValue: BubbleTypeScore.Pink,bubbleImgName: "bubble-pink"))
        bubbleTypes.append(Bubble(bubbleType: "Red",bubbleValue: BubbleTypeScore.Red,bubbleImgName: "bubble-red"))
        bubbleTypes.append(Bubble(bubbleType: "Black",bubbleValue: BubbleTypeScore.Black,bubbleImgName: "bubble-black"))
        bubbleTypes.append(Bubble(bubbleType: "Green",bubbleValue: BubbleTypeScore.Green,bubbleImgName: "bubble-green"))
        bubbleTypes.append(Bubble(bubbleType: "Blue",bubbleValue: BubbleTypeScore.Blue,bubbleImgName: "bubble-blue"))
    }
    
    
    // Start game timer
    // Calls gameTimeUpdate each interval (1 sec)
    func startCountdown(){
        if welcomeTimer == nil {
            welcomeTimer = Timer.scheduledTimer(
                timeInterval: 1.0,
                target: self,
                selector: #selector(GameScene.welcomeTimeUpdate),
                userInfo: nil,
                repeats: true
            )
        }
    }
    
    
    // Start game timer
    // Calls gameTimeUpdate each interval (1 sec)
    func initaliseGameTimer(){
        if gameTimer == nil {
            gameTimer = Timer.scheduledTimer(
                timeInterval: 1.0,
                target: self,
                selector: #selector(GameScene.gameTimeUpdate),
                userInfo: nil,
                repeats: true
            )
        }
    }
    
    
    // Bubble game timer method called gameBubbleUpdate
    // Method to check bubble's location. Calls in (0.01 ) intervals
    func bubbleGameTimer(){
        if bubbleTimer == nil {
            bubbleTimer = Timer.scheduledTimer(
                timeInterval: 0.01,
                target: self,
                selector: #selector(GameScene.gameBubbleUpdate),
                userInfo: nil,
                repeats: true
            )
        }
    }
    
    // Method updates count down timer when game starts
    @objc func welcomeTimeUpdate(){
        welcomeTime -= 1
        if(welcomeTime > 0){
            welcomeTimeLbl?.text = "\(welcomeTime)"
        }else if(welcomeTime == 0){
            welcomeTimeLbl?.text = "Go"
        }else{
            stopWelcomeTimer()
            startGame()
        }
        welcomeTimeLbl?.run(welcomeTimerAnimate)
    }
    
    // Stop game timer and bubble timer when the game is over
    func stopTimer() {
        if gameTimer != nil {
            gameTimer!.invalidate()
            gameTimer = nil
        }
        if bubbleTimer != nil {
            bubbleTimer!.invalidate()
            bubbleTimer = nil
        }
    }
    
    // Stop welcome timer and hides welcome panel
    func stopWelcomeTimer(){
        if welcomeTimer != nil {
            welcomeTimer!.invalidate()
            welcomeTimer = nil
        }
        welcomeTimeLbl?.removeFromParent()
    }
    
    // Function checks the bubble location can removes if it is out of the screen.
    @objc func gameBubbleUpdate(){
        for b in bubbles{
            if(frame.maxY < b.frame.maxY || frame.minY > b.frame.minY ){
                b.removeFromParent()
            }
            if(frame.maxX < b.frame.maxX  || frame.minX > b.frame.minX){
                b.removeFromParent()
            }
        }
    }
    
    // Function updates Game time
    // Set highscore and scoreboard after game is over
    @objc func gameTimeUpdate(){
        if(timerCount % Int(refreshRate) == 0 ){
            removeRandomBubbles()
            generateNewBubble()
        }
        timerCount += 1
        
        if(gameTime <= 0){
            isGameOver = true
            stopTimer()
            
            UserDefaults.standard.set(Int(score), forKey: "RecentScore")
            if Int(score) > UserDefaults.standard.integer(forKey: "Highscore"){
                UserDefaults.standard.set(Int(score), forKey: "Highscore")
            }
            if(Int(score) > 0 ){
                addScoreToScoreBoard()
            }
            //Game over
            showScore()
        }else{
            gameTime -= 1
            updateTimer()
        }
    }
    
    // Function to add score to the scoreboard list
    func addScoreToScoreBoard(){
        let userScore = Scoreboard(name: GameSettings.username, score: Int(score))
        var currentScoreBoard: [Scoreboard]!
        //get current string for scoreboard
        let currentScoreBoardObj = UserDefaults.standard.object(forKey: "scoreboard")
        
        // Error handling if score not being able to load
        if(currentScoreBoardObj != nil){
            if let decoded = UserDefaults.standard.object(forKey: "scoreboard") as? NSData {
                do {
                    let array = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded as Data) as! [Scoreboard]
                    currentScoreBoard = array
                }catch {
                    print("Error in loading scoreboard data")
                    let bubbleArray: [Scoreboard] = []
                    currentScoreBoard = bubbleArray
                }
            }
        }else{
            let bubbleArray: [Scoreboard] = []
            currentScoreBoard = bubbleArray
        }
        currentScoreBoard.append(userScore)
        do {
            try UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: currentScoreBoard!,requiringSecureCoding:false), forKey: "scoreboard")
        }
        catch{
            print("Error in saving scoreboard ")
        }
    }
    
    // Update the timer to the current time
    func updateTimer(){
        timeLeftVal!.text = "\(gameTime)"
        
        if(gameTime <= 5){
            timeLeftVal!.fontColor = UIColor.red
            timeLeftVal!.run(animateScore)
        }
    }
    
    // Check the current score compared to high score
    func checkHighScore(){
        if(Int(score) > highScore){
            highScoreVal!.text = "\(Int(score))"
            highScore = Int(score)
            
        }
    }
    
    // Show game over panel with the final score
    func showScore(){
        
        let gameOverPanel = SKSpriteNode()
        gameOverPanel.size = CGSize(width: frame.width - frame.width*0.1, height: frame.height - frame.height*0.3)
        gameOverPanel.name = "gameOverPanel"
        gameOverPanel.position = CGPoint(x: frame.midX, y: frame.midY)
        gameOverPanel.zPosition = 10
        gameOverPanel.color = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.85)
        
        let gameOverLbl = SKLabelNode(text: "Game Over!")
        gameOverLbl.name = "gameOverLbl"
        gameOverLbl.fontName = "Marker Felt"
        gameOverLbl.fontSize = 50.0
        gameOverLbl.fontColor = defaultColor
        gameOverLbl.position = CGPoint(x:0.0, y: 150.0)
        gameOverLbl.zPosition = 10
        gameOverPanel.addChild(gameOverLbl)
        
        let gameOverScore = SKLabelNode(text: "Your Score : \(Int(score))")
        gameOverScore.name = "gameOverScore"
        gameOverScore.fontName = "Noteworthy-Bold"
        gameOverScore.fontSize = 20.0
        gameOverScore.fontColor = defaultColor
        gameOverScore.position = CGPoint(x: 0.0, y: 150.0 - gameOverLbl.frame.size.height)
        gameOverScore.zPosition = 10
        gameOverPanel.addChild(gameOverScore)
        
        let HighScoreEndLbl = SKLabelNode(text: "High Score")
        HighScoreEndLbl.name = "HighScoreEndLbl"
        HighScoreEndLbl.fontName = "Noteworthy-Bold"
        HighScoreEndLbl.fontSize = 20.0
        HighScoreEndLbl.fontColor = defaultColor
        HighScoreEndLbl.position = CGPoint(x: 0.0, y: 150.0 - gameOverLbl.frame.size.height*4)
        HighScoreEndLbl.zPosition = 10
        gameOverPanel.addChild(HighScoreEndLbl)
        
        //three high scores
        
        //get current string for scoreboard
        let currentScoreBoardObj = UserDefaults.standard.object(forKey: "scoreboard")
        
        if(currentScoreBoardObj != nil){
            if let decoded = UserDefaults.standard.object(forKey: "scoreboard") as? NSData {
                do {
                    let array = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded as Data) as! [Scoreboard]
                    
                    let currentScoreBoard = array.sorted(by: { $0.playerScore > $1.playerScore })
                    var highscoreIndex = 0
                    for i in currentScoreBoard{
                        if(highscoreIndex >= 3){
                            break
                        }
                        let HighScoreVal = SKLabelNode(text: "\(i.playerName)  \(i.playerScore)")
                        HighScoreVal.name = "\(HighScoreVal)_\(highscoreIndex)"
                        HighScoreVal.fontName = "Noteworthy"
                        HighScoreVal.fontSize = 20.0
                        HighScoreVal.fontColor = defaultColor
                        HighScoreVal.position = CGPoint(x: 0.0, y: 150.0 - CGFloat(Float((highscoreIndex*25))) - (gameOverLbl.frame.size.height*5))
                        HighScoreVal.zPosition = 10
                        gameOverPanel.addChild(HighScoreVal)
                        highscoreIndex += 1
                        
                    }
                }catch {
                    print("Error in loading the scoreboard")
                }
            }
        }
        
        let labelBack = SKSpriteNode(imageNamed: "backbtn")
        labelBack.name = "goBack"
        labelBack.position = CGPoint(x: 0.0, y: -150.0 )
        gameOverPanel.addChild(labelBack)
        addChild(gameOverPanel)
        
    }
    
    // Get Random bubble color according to probability
   func getRandomBubbleType() -> Bubble{
       let randomNo = Int.random(in: 0..<101)
       
       if(randomNo < 40){
           return getColorForBubble(color: "red")
       }else if(randomNo > 40 && randomNo < 70){
           return getColorForBubble(color: "pink")
       }else if(randomNo > 70 && randomNo < 85){
           return getColorForBubble(color: "green")
       }else if(randomNo > 85 && randomNo < 95){
           return getColorForBubble(color: "blue")
       }else {
           return getColorForBubble(color: "black")
       }
   }
       
    // Get the bubble color
    func getColorForBubble(color: String) -> Bubble{
       for type in bubbleTypes{
           if(color == type.bubbleType.lowercased()){
               return type
           }
       }
       return Bubble(bubbleType: "Red", bubbleValue: 1, bubbleImgName: "bubble-pink")
    }
    
    // Choose and remove a random bubble
    func removeRandomBubbles(){
        
        if(bubbles.count > 5){
            
            //get number of bubbles to remove
            let noToRemove = Int.random(in: 0...5)
            
            var removeIndex: [Int] = []
            //get random Indexes for remove bubbles
            for _ in 0...noToRemove{
                removeIndex.append(Int.random(in: 0...bubbles.count))
            }
            //remove the bubbles of the randomly generated indexes
            for i in removeIndex{
                if(bubbles.count > 0 && bubbles.indices.contains(i)){
                    removeBubble(bubbleName: bubbles[i].name!)
                }
                
            }
        }
    }
    
    // Generate new bubble and add it to the Game Screen
    func generateNewBubble(){
        
        let numberOfBubbles = Int.random(in: 0...UserDefaults.standard.integer(forKey: "maximumBalls"))
        
        for num in 0..<numberOfBubbles{
            
            // Randomly select pixel location for the bubble to be created
            let randomPixelX = Double.random(in: Double(frame.minX+70)...Double(frame.maxX-70))
            let randomPixelY = Double.random(in: Double(frame.minY+100)...Double(frame.maxY-200))
            let bubbleType = getRandomBubbleType()
            let bubble = SKSpriteNode(imageNamed: bubbleType.getBubbleImgName())
            bubble.size = CGSize(width: 70, height: 70)
            let miliSecDate = Date()
            let timeInMiliSec = Int (miliSecDate.timeIntervalSince1970 * 1000)
            
            bubble.name = "Ball_\(num)_\(bubbleType)_\(timeInMiliSec)"
            bubble.position = CGPoint(x:randomPixelX, y: randomPixelY)
            bubble.zPosition = ZPositions.ball
            bubble.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory
            bubble.physicsBody?.collisionBitMask = PhysicsCategories.ballCategory
            
            bubble.physicsBody = SKPhysicsBody(rectangleOf: bubble.size)
            bubble.physicsBody?.isDynamic = true
            bubble.physicsBody?.affectedByGravity = false;
            bubble.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory
            bubble.physicsBody?.contactTestBitMask = PhysicsCategories.ballCategory
            bubble.physicsBody?.applyImpulse(CGVector(dx: 100.0, dy: 100.0))
            bubble.alpha = 0.0
            
            bubble.physicsBody?.usesPreciseCollisionDetection = true;
            

            if checkOverlapBubble(nextBubble: bubble) {
                bubbles.append(bubble)
                
                let durationPerc = ((gameTime*100) / (UserDefaults.standard.integer(forKey: "gametime")))
                var pixelX = Double.random(in: -1000.0...1000.0)
                var pixelY = Double.random(in: -1000.0...1000.0)
                
                if(durationPerc > 25 && durationPerc < 35){
                    pixelX = Double.random(in: -1000.0...1000.0)
                    pixelY = Double.random(in: -1000.0...1000.0)
                }else if(durationPerc > 10 && durationPerc < 25){
                    pixelX = Double.random(in: -800.0...800.0)
                    pixelY = Double.random(in: -800.0...800.0)
                }else if(durationPerc < 10){
                    pixelX = Double.random(in: -100.0...100.0)
                    pixelY = Double.random(in: -100.0...100.0)
                }
                
                addChild(bubble)
                bubble.run(SKAction.fadeIn(withDuration: 0.10))
                bubble.run(SKAction.move(by: CGVector(dx: pixelX, dy: pixelY), duration: TimeInterval(gameTime)))
            }
        }
    }
    
    // Check if the bubble does not overlap with other bubbles
    func checkOverlapBubble(nextBubble: SKSpriteNode) -> Bool{
        for bubble in bubbles{
            if(bubble.intersects(nextBubble)){
                return false
            }
        }
        return true
    }
    
    // Function to handle events when a bubble is popped
    func handlePopedBall(bubble :SKSpriteNode){
        
        bubble.removeAllActions()
        let poppedBubbleType = getBallType(bubbleNode: bubble)
        let bubbleScore = calculateScore(poppedBall: bubble, poppedBubbleType: poppedBubbleType)
        let poppedBubbleScore = SKLabelNode(text: "+\(bubbleScore)")
        
        poppedBubbleScore.name = "poppedBubbleScore"
        poppedBubbleScore.fontName = "Chalkduster"
        poppedBubbleScore.fontSize = 20.0
        poppedBubbleScore.fontColor = getUIColor(strColor: poppedBubbleType.bubbleType)
        poppedBubbleScore.zPosition = 5
        poppedBubbleScore.position = CGPoint(x: bubble.frame.maxX - 50, y: bubble.frame.maxY - 50)
        addChild(poppedBubbleScore)
        poppedBubbleScore.run(SKAction.fadeOut(withDuration: 1.0),completion: {
            poppedBubbleScore.removeFromParent()
        })
        
        bubble.alpha = 0.45
        bubble.run(animateBall, completion: {
            bubble.run(SKAction.sequence(
                [
                    SKAction.move(to: self.scoreLblVal!.position,duration:0.50),
                    SKAction.scale(to: 0.0, duration: 0.50)
                ]
            ),completion:{
                bubble.removeFromParent()
            })
            
            
        })
        
        removeBubble(bubble: bubble)
        
        bubble.physicsBody?.categoryBitMask = PhysicsCategories.poppedBall
        bubble.physicsBody?.collisionBitMask = PhysicsCategories.poppedBall
        bubble.physicsBody?.categoryBitMask = PhysicsCategories.poppedBall
        bubble.physicsBody?.contactTestBitMask = PhysicsCategories.poppedBall
        bubble.physicsBody?.collisionBitMask = PhysicsCategories.poppedBall
        bubble.zPosition = ZPositions.poppedBall
        
        scoreLblVal!.text = "\(Int(score))"
        scoreLblVal!.run(animateScore)
        
        checkHighScore()
        
    }
    
    // Return ball type in the SkScrite Node
    func getBallType(bubbleNode: SKSpriteNode) -> Bubble{
        var ballType: Bubble?
        for type in bubbleTypes{
            
            if((bubbleNode.name)!.contains(type.bubbleType.lowercased())){
                ballType =  type
            }
        }
        
        return ballType!
        
    }
    
    // Remove a bubble on the screen
    func removeBubble(bubble: SKSpriteNode){
        var index = 0
        for bubble in bubbles{
            if( bubble.name == bubble.name){
                break
            }
            index += 1
        }
        
        if((index > -1) && (index < bubbles.count) && bubbles.indices.contains(index)){
            bubbles.remove(at: index)
        }
    }
    
    // Remove a bubble from the array and the screen
    func removeBubble(bubbleName: String){
        var index = 0
        for bubble in bubbles{
            if( bubble.name == bubbleName){
                break
            }
            index += 1
        }
        
        if((index > -1) && (index < bubbles.count)){
            bubbles[index].run(SKAction.fadeOut(withDuration: 0.30), completion: {
                if(self.bubbles.indices.contains(index)){
                    self.bubbles[index].removeFromParent()
                    self.bubbles.remove(at: index)
                }
            })
        }
    }
    
   // Calculate the score after each bubble is popped, also the bonus points
    func calculateScore(poppedBall: SKSpriteNode, poppedBubbleType: Bubble) -> Double{
        //var bonus = 0.0
        var bonus = Double(poppedBubbleType.getBubbleValue())
        
        if(previousPoppedType != nil && previousPoppedType!.getBubbleType() == poppedBubbleType.getBubbleType()){
            bonus = bonus * 1.5
        }
        
        score = score + bonus
        previousPoppedType = poppedBubbleType
        
        return bonus
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            var touchNodeName = ""
            if(touchedNode.name != nil){
                touchNodeName = touchedNode.name!
            }
            
            if touchedNode.name == "goBack" {
                // Navigates to menu scene on back button
                let gameScene = MainScreen(size: view!.bounds.size)
                view!.presentScene(gameScene)
            }else if(touchNodeName.contains("Ball") && !isGameOver){
                // Captures when user presses a bubble
                handlePopedBall(bubble: touchedNode as! SKSpriteNode)
                
            }
        }
    }
    
    override func willMove(from view: SKView) {
        removeAllChildren()
        removeAllActions()
        removeFromParent()
    }
}
