//
//  ViewController.swift
//  newMath
//
//  Created by Macbook Air on 12/29/20.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    let gameName: UILabel = {
        let gameName = UILabel()
        gameName.text = "Welcome to Math Game!"
        gameName.textAlignment = .center
        gameName.font = .systemFont(ofSize: 32)
        gameName.contentMode = .scaleAspectFit
        return gameName
    }()

    let scoreLabel: UILabel = {
        let scoreLabel = UILabel()
        scoreLabel.backgroundColor = .darkGray
        scoreLabel.textColor = .white
        scoreLabel.text = "0"
        scoreLabel.textAlignment = .center
        scoreLabel.font = .systemFont(ofSize: 32)
        scoreLabel.layer.cornerRadius = 30
        scoreLabel.layer.masksToBounds = true
        return scoreLabel
    }()
    
    let correctNameLabel: UILabel = {
        let correctName = UILabel()
        correctName.text = "Correct"
        correctName.textColor = .systemGreen
        correctName.textAlignment = .center
        correctName.font = .systemFont(ofSize: 18)
        return correctName
    }()
    
    let incorrectNameLabel: UILabel = {
        let incorrectName = UILabel()
        incorrectName.text = "Incorrect"
        incorrectName.textColor = .systemRed
        incorrectName.textAlignment = .center
        incorrectName.font = .systemFont(ofSize: 18)
        return incorrectName
    }()
    
    let correctLabel: UILabel = {
        let correctLabel = UILabel()
        correctLabel.backgroundColor = .systemGreen
        correctLabel.textAlignment = .center
        correctLabel.font = .systemFont(ofSize: 18)
        correctLabel.layer.cornerRadius = 14
        correctLabel.layer.masksToBounds = true
        return correctLabel
    }()
    
    let incorrectLabel: UILabel = {
        let incorrectLabel = UILabel()
        incorrectLabel.backgroundColor = .systemRed
        incorrectLabel.textAlignment = .center
        incorrectLabel.font = .systemFont(ofSize: 18)
        incorrectLabel.layer.cornerRadius = 14
        incorrectLabel.layer.masksToBounds = true
        return incorrectLabel
    }()
    
    let lowLevelButton: UIButton = {
        let lowButton = UIButton()
        lowButton.backgroundColor = .systemBlue
        lowButton.setTitle("START", for: .normal)
        lowButton.titleLabel?.font = .systemFont(ofSize: 18)
        lowButton.layer.cornerRadius = 16
        lowButton.layer.masksToBounds = true
        lowButton.addTarget(self, action: #selector(lowButtonPress), for: .touchUpInside)
        return lowButton
    }()
    let nameLevelLabel: UILabel = {
       let nameLevelLabel = UILabel()
        nameLevelLabel.text = "Choose Level"
        nameLevelLabel.textColor = .systemRed
        nameLevelLabel.textAlignment = .center
        nameLevelLabel.font = .systemFont(ofSize: 18)
        
        return nameLevelLabel
    }()
    let imageMath: UIImageView = {
        let imageMath = UIImageView(image: UIImage(named: "mathImage"))
        return imageMath
    }()
    
    var segmentControll :UISegmentedControl = {
        var levelArray = ["Easy", "Medium", "Hard"]
        var segmentControl = UISegmentedControl(items: levelArray)
        segmentControl.selectedSegmentTintColor = .systemGreen
        segmentControl.addTarget(self, action: #selector(selectedValue), for: .valueChanged)
        return segmentControl
    }()
    
    var levelView: Int = 0
    var correct = 0
    var incorrect = 0
    var resultScore = 0
    var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if let result = userDefaults.string(forKey: "correct"){
            correctLabel.text = result
        }
        if let result = userDefaults.string(forKey: "incorrect"){
            incorrectLabel.text = result
        }
        // Do any additional setup after loading the view.
        setupView()
    }
    
  
    
    func setupView(){
        [scoreLabel, correctNameLabel,incorrectNameLabel,correctLabel, incorrectLabel, lowLevelButton,  gameName, segmentControll, nameLevelLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate ([
            gameName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameName.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
           
            scoreLabel.centerXAnchor.constraint(equalTo: gameName.centerXAnchor),
            scoreLabel.topAnchor.constraint(equalTo: gameName.topAnchor, constant: 100),
            scoreLabel.widthAnchor.constraint(equalToConstant: 60),
            scoreLabel.heightAnchor.constraint(equalToConstant: 60),
            
            correctNameLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 20),
            correctNameLabel.trailingAnchor.constraint(equalTo: scoreLabel.leadingAnchor),
            correctNameLabel.widthAnchor.constraint(equalToConstant: 100),
            correctNameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            incorrectNameLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor,constant: 20),
            incorrectNameLabel.leadingAnchor.constraint(equalTo: scoreLabel.trailingAnchor),
            incorrectNameLabel.widthAnchor.constraint(equalToConstant: 100),
            incorrectNameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            
            correctLabel.centerXAnchor.constraint(equalTo: correctNameLabel.centerXAnchor),
            correctLabel.topAnchor.constraint(equalTo: correctNameLabel.bottomAnchor, constant: 20),
            correctLabel.widthAnchor.constraint(equalToConstant: 60),
            correctLabel.heightAnchor.constraint(equalToConstant: 60),
            
            incorrectLabel.centerXAnchor.constraint(equalTo: incorrectNameLabel.centerXAnchor),
            incorrectLabel.topAnchor.constraint(equalTo: incorrectNameLabel.bottomAnchor, constant: 20),
            incorrectLabel.widthAnchor.constraint(equalToConstant: 60),
            incorrectLabel.heightAnchor.constraint(equalToConstant: 60),
            
            lowLevelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lowLevelButton.topAnchor.constraint(equalTo: correctLabel.bottomAnchor, constant: 80),
            lowLevelButton.widthAnchor.constraint(equalToConstant: 200),
            lowLevelButton.heightAnchor.constraint(equalToConstant: 70),
            
            nameLevelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLevelLabel.topAnchor.constraint(equalTo: lowLevelButton.bottomAnchor, constant: 60),
            
            segmentControll.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentControll.topAnchor.constraint(equalTo: nameLevelLabel.bottomAnchor, constant: 20),
            segmentControll.widthAnchor.constraint(equalToConstant: 250),
            segmentControll.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func delegateButton() {
        let vc = GameViewController()
        vc.delegate = self
        vc.level = levelView
        present(vc, animated: true, completion: nil)
    }
    
    @objc func lowButtonPress() {
       
        levelView = selectedValue(target: (segmentControll))
        delegateButton()
    }
    
    
    @objc func selectedValue(target: UISegmentedControl) -> Int  {
        var segmentIndex = 0
        if target == segmentControll {
            segmentIndex = target.selectedSegmentIndex + 1
           // print(segmentIndex)
        }
        return segmentIndex
    }

}

extension ViewController: resultDelegate {
    func updateScore(value: Int) {
        if value > 0 {
         correct += 1
            correctLabel.text = correct.description
            userDefaults.setValue(correct, forKey: "correct")
        } else {
            incorrect += 1
            incorrectLabel.text = incorrect.description
            userDefaults.setValue(incorrect, forKey: "incorrect")
        }
    }
    
    func correctAnswer(value: Int) {
        resultScore += value
        scoreLabel.text = resultScore.description
    }
    
    
}
