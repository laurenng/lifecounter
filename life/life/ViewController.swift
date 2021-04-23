//
//  ViewController.swift
//  life
//
//  Created by stlp on 4/21/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var user1: UILabel!
    @IBOutlet weak var user2: UILabel!
    @IBOutlet weak var user4: UILabel!
    @IBOutlet weak var user3: UILabel!
    @IBOutlet weak var loserText: UILabel!
    
    let START_CONST : Int  = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loserText.text = "PLAYER X LOSES"
        user1.text = String(START_CONST)
        user2.text = String(START_CONST)
        user3.text = String(START_CONST)
        user4.text = String(START_CONST)
    }
    
    func updateScore(val: Int, target: Int) {
        switch target{
        case 1:
            var newTotal = Int(user1.text!)!
            newTotal = newTotal + val
            user1.text = String(newTotal)
            if (newTotal <= 0) {
                loserText.text = "player 1 has lost"
            }
        case 2:
            var newTotal = Int(user2.text!)!
            newTotal = newTotal + val
            user2.text = String(newTotal)
            if (newTotal <= 0) {
                loserText.text = "player 2 has lost"
            }
        case 3:
            var newTotal = Int(user3.text!)!
            newTotal = newTotal + val
            user3.text = String(newTotal)
            if (newTotal <= 0) {
                loserText.text = "player 3 has lost"
            }
        case 4:
            var newTotal = Int(user4.text!)!
            newTotal = newTotal + val
            user4.text = String(newTotal)
            if (newTotal <= 0) {
                loserText.text = "player 4 has lost"
            }
        default:
            print("you're in the wrong spot buddy")
        }
    }
    
    @IBAction func singleAdditionButton(_ sender: UIButton) {
        print(sender.tag)
        updateScore(val: 1, target: sender.tag)
    }
    
    @IBAction func singleSubtractionButton(_ sender: UIButton) {
        print(sender.tag)
        updateScore(val: -1, target: sender.tag)
    }
    
    @IBAction func fiveAddtionButton(_ sender: UIButton) {
        print(sender.tag)
        updateScore(val: 5, target: sender.tag)
    }
    
    @IBAction func fiveSubtractionButton(_ sender: UIButton) {
        print(sender.tag)
        updateScore(val: -5, target: sender.tag)
    }
}



