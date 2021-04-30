//
//  ViewController.swift
//  lifeCounter V2
//
//  Created by Ted Neward on 4/27/21.
//

import UIKit

var hist : [String] = []

var buttonValue : Int = 3

class ViewController: UIViewController {

    var history = false
    
    var personList : [PersonPanelView] = []
    var count: Int = 1
    
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var contentView: UIStackView!
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet weak var removePlayerButton: UIButton!
    
    @IBOutlet var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addPerson(self)
        addPerson(self)
        self.statusLabel.text = "Player X Loses"
    }

    public func updateLoserLabel(newVal : String) {
        self.statusLabel.text = newVal
        NSLog("changinng")
        
    }
    
    public func disableButton() {
        addPlayerButton.isEnabled = false
        removePlayerButton.isEnabled = false
        
    }
    @IBAction func addPerson(_ sender: Any) {
        if (count <= 8) {

            let personPanel = PersonPanelView()
            personPanel.masterView = self
            personPanel.data = ("Person\(count)", 20)
            contentView.addArrangedSubview(personPanel)
            personList.append(personPanel)
            count += 1
        }
    }
    
    @IBOutlet weak var slider: UISlider!
    @IBAction func changeButtonValue(_ sender: Any) {
        buttonValue = Int(slider.value)
        
        for view in personList {
            view.updateButton(buttonValue)
        }
    }
    
    @IBAction func removePerson(_ sender: Any) {
        if (count > 3) {
            personList[count - 2].removeFromSuperview()
            personList.remove(at: count - 2)
            count -= 1
        } else {
            NSLog("can't hav less than 2")
        }
    }
    
}

class PersonPanelView: UIView {

    var data : (String, Int) = ("", 20) {
        didSet {
            // Update the label with modified data
            label.text = "\(data.0)"
        }
    }
    
    weak var label : UILabel!
    weak var scoreLabel : UILabel!
    weak var minus5button : UIButton!
    weak var minus1button: UIButton!
    weak var plus1button: UIButton!
    weak var plus5button: UIButton!
    
    var masterView : ViewController? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubViews()
    }
    
    public func updateButton(_ num : Int) {
        minus5button.setTitle("-" + String(num), for: .normal)
        plus5button.setTitle("+" + String(num), for: .normal)
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
        
        scoreLabel = (nibView.subviews[0].subviews[3] as! UILabel)
        scoreLabel.text = " \(data.1)"
        
        minus5button = (nibView.subviews[0].subviews[1] as! UIButton)
        
        minus5button.addTarget(self, action: #selector(minus5(_:)), for: .touchUpInside)
        
        minus1button = (nibView.subviews[0].subviews[2] as! UIButton)
        minus1button.addTarget(self, action: #selector(minus1(_:)), for: .touchUpInside)

        plus1button = (nibView.subviews[0].subviews[4] as! UIButton)
        plus1button.addTarget(self, action: #selector(plus1(_:)), for: .touchUpInside)
        
        plus5button = (nibView.subviews[0].subviews[5] as! UIButton)
        
        plus5button.addTarget(self, action: #selector(plus5(_:)), for: .touchUpInside)
    }
    
    @objc private func minus5(_ sender : UIButton) {
        // Modify our internal data
        let amount = Int(sender.currentTitle!)!
        data = (data.0, data.1 + amount)
        
        // Update the label with modified data
        scoreLabel.text = " \(data.1)"
        
        NSLog(String(data.1))
        if (data.1 <= 0) {
            masterView?.updateLoserLabel(newVal: "\(data.0) has Lost")
        }
        masterView?.disableButton()
        hist.append("\(data.0) lost \(amount) life")
    }
    
    @objc private func minus1(_ sender : UIButton) {
        // Modify our internal data
        data = (data.0, data.1 - 1)
//
        if (data.1 <= 0) {
            masterView?.updateLoserLabel(newVal: "\(data.0) has Lost")
        }
        
        scoreLabel.text = " \(data.1)"
        masterView?.disableButton()
        hist.append("\(data.0) lost 1 life")
    }
    
    @objc private func plus1(_ sender : UIButton) {
        // Modify our internal data
        data = (data.0, data.1 + 1)
        
        // Update the label with modified data
        scoreLabel.text = " \(data.1)"
        masterView?.disableButton()
        hist.append("\(data.0) gained 1 life ")
    }
    
    @objc private func plus5(_ sender : UIButton) {
        let amount = Int(sender.currentTitle!)!
        // Modify our internal data
        data = (data.0, data.1 + amount)
        
        // Update the label with modified data
        scoreLabel.text = " \(data.1)"
        masterView?.disableButton()
        hist.append("\(data.0) gained \(amount) life")
    }

}


class historyView : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self

        tableView.dataSource = self
        
        addHistory()
        
        for value in hist {
            NSLog(value)
        }
        
    }
    
    private func addHistory() {
        NSLog("adding valuees!!!!")
        tableView.insertRows(at: [IndexPath.init(row: hist.count-1, section: 0)], with: .automatic)
    }
}

extension historyView: UITableViewDelegate,UITableViewDataSource {

        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return hist.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")!
            cell.textLabel?.text = hist[indexPath.row]
            return cell
        }
    }
