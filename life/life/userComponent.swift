//
//  userComponent.swift
//  life
//
//  Created by stlp on 4/27/21.
//

import UIKit


class userComponent: UIView {

    /* This is for Option 2: A custom subclass of UIView
     * It uses the same XIB as Option 1, but encapsulates everything
     * in this subclass, and makes it easier to contain the model/data
     * in one place.
     */

    var data : (String, Int) = ("", -1) {
        didSet {
            // Update the label with modified data
            label.text = "\(data.0)"
            scoreLabel.text = " \(data.1)"
        }
    }
    
    @IBOutlet weak var subtractOne: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var addOne: UIButton!
    @IBOutlet weak var addFive: UIButton!
    @IBOutlet weak var subtractFive: UIButton!
    var buttonValue : Int = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubViews()
    }
    
    @IBAction func addFive(_ sender: Any) {
        NSLog("clicked up bum")
        scoreLabel.text = "8"
    }
    
    private func initSubViews() {
        
        // Instantiate the nib into existence
        let nib = UINib(nibName: "PersonPanel", bundle: nil)
        let nibInstance = nib.instantiate(withOwner: self, options: nil)
        
        // Get the view from the instantiated nib and add it into our own tree
        let nibView = (nibInstance.first) as! UIView
        addSubview(nibView)
        
        // Wire up the controls to this view
        label = (nibView.subviews[0].subviews[0] as! UILabel)
        label.text = "\(data.0)"
        
        subtractFive = (nibView.subviews[0].subviews[1] as! UIButton)
        subtractFive.addTarget(self, action: #selector(subtractOneScore(_:)), for: .touchUpInside)
        
        subtractOne = (nibView.subviews[0].subviews[2] as! UIButton)
        subtractOne.addTarget(self, action: #selector(subtractOneScore(_:)), for: .touchUpInside)
        
        scoreLabel = (nibView.subviews[0].subviews[3] as! UILabel)
        label.text = "\(data.1)"
        
        addOne = (nibView.subviews[0].subviews[4] as! UIButton)
        addOne.addTarget(self, action: #selector(addOneScore(_:)), for: .touchUpInside)
        
        addFive = (nibView.subviews[0].subviews[5] as! UIButton)
        addFive.addTarget(self, action: #selector(addOneScore(_:)), for: .touchUpInside)
    }
    
    func changeButtonValue(_ count: Int) {
        buttonValue = count
        subtractFive.setTitle(String(count), for: .normal)
        addFive.setTitle(String(count), for: .normal)
    }
    
    @objc private func subtractOneScore(_ sender : UIButton) {
        // Modify our internal data
        data = (data.0, data.1 - 1)
        
        // Update the label with modified data
        scoreLabel.text = "\(data.1)"

        NSLog("Happy Birthday, \(data.0) you are now \(data.1)")
    }
    
    @objc private func addOneScore(_ sender : UIButton) {
        // Modify our internal data
        data = (data.0, data.1 + 1)
        
        // Update the label with modified data
        scoreLabel.text = "\(data.1)"

        NSLog("Happy Birthday, \(data.0) you are now \(data.1)")
    }

}

