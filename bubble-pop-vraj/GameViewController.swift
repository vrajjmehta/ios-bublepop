// --------Important INFO--------------
//This project is programmed using SpriteKit & GamePlayKit
//There are No Standard View Controllers as such, various "Scenes" make up the View Controller
//Also, In Storyboard you wont be able to see different views
//The views are dynamically created using SprikeKit

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            let scene = MainScreen(size: view.bounds.size)
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
}
