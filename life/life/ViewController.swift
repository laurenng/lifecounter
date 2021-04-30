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
    
    
    @IBOutlet var grouping: [UIStackView]!
    @IBOutlet var userLabel: [UILabel]!
    
    @IBOutlet var scoreGroup: [UILabel]!
    
    @IBOutlet weak var contentView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loserText.text = "PLAYER X LOSES"
        user2.text = String(START_CONST)
        user3.text = String(START_CONST)
        user4.text = String(START_CONST)
        
        // addComponents()
        
        let name = "user 1"
        let age = 20

        let personPanel = userComponent()
        personPanel.data = (name, age)
        contentView.addArrangedSubview(personPanel)
    }
    
    @IBOutlet weak var slider: UISlider!
    @IBAction func buttonToggler(_ sender: Any) {
        let buttonValue = Int(slider.value)
        buttonNegative.setTitle("-" + String(buttonValue), for: .normal)
        buttonPositive.setTitle("+" + String(buttonValue), for: .normal)
    }
    
    @IBOutlet weak var buttonNegative: UIButton!
    @IBOutlet weak var buttonPositive: UIButton!
    
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
        updateScore(val: 1, target: sender.tag)
    }
    
    @IBAction func singleSubtractionButton(_ sender: UIButton) {
        updateScore(val: -1, target: sender.tag)
    }
    
    @IBAction func fiveAddtionButton(_ sender: UIButton) {
        let amount = Int(sender.currentTitle!)!
        updateScore(val: amount, target: sender.tag)
    }
    
    @IBAction func fiveSubtractionButton(_ sender: UIButton) {
        let amount = Int(sender.currentTitle!)!
        updateScore(val: amount, target: sender.tag)
    }
}

class user: UIViewController {
    private let tag : Int
    public var score : Int
    public var buttonPlus : UIButton = UIButton()
    public var label : UILabel
    
    init(tag : Int) {
        self.tag = tag
        self.score = 0
        self.label = UILabel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addComponents() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        buttonPlus.backgroundColor = .systemBlue
        buttonPlus.setTitle("Test Button", for: .normal)
        buttonPlus.addTarget(self, action: #selector(self.heello), for: .touchUpInside)
        
        print("iinside add component")
        
        label.text = "testing this poop"
        
        
        stackView.addArrangedSubview(buttonPlus)
        stackView.addArrangedSubview(label)
        
        return stackView
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
        }
    
    @objc func heello(sender: UIButton) {
      print("Button tapped")
        //label.text = "suckyyyyy"
    }
    
    @objc func buttonAction(sender: UIButton!) {
      print("Button tapped")
    // buttonPlus.setTitle("5", for: .normal)
        label.text = "suckyyyyy"
    }
}
