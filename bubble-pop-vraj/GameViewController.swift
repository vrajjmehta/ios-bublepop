//
//  GameViewController.swift
//  bubble-pop-lahirurane
//
//  Created by Lahiru Ranasinghe on 30/4/19.
//  Copyright © 2019 Lahiru Ranasinghe. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

//    @IBOutlet weak var playBtn: UIButton!
//    @IBOutlet weak var settingsBtn: UIButton!
//    @IBOutlet weak var usernameText: UITextField!
//    @IBOutlet weak var highscoreBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            let scene = MenuScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
//    @IBAction func userNameAction(_ sender: Any) {
//    }
//    @IBAction func playButtonTouched(_ sender: Any) {
//    }
//    @IBAction func highScoreAction(_ sender: Any) {
//        let highscoreScene = HighScoreScene(size: view!.bounds.size)
//        moveToViewScene(scene: HighScoreScene)
//    }
//    @IBAction func settingsAction(_ sender: Any) {
//    }
//
//    func moveToViewScene(scene: SKScene){
//
//        if let view = self.view as! SKView? {
//            let scene = scene(size: view.bounds.size)
//            scene.scaleMode = .aspectFill
//
//            // Present the scene
//            view.presentScene(scene)
//            view.ignoresSiblingOrder = true
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
//
//    }
}
