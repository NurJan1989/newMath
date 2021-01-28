//
//  GameViewController.swift
//  newMath
//
//  Created by Macbook Air on 1/1/21.
//

import UIKit
protocol resultDelegate {
    func updateScore(value: Int)
    func correctAnswer(value: Int)
}

class GameViewController: UIViewController {

    let questionLabel: UILabel = {
        let questionLabel = UILabel()
        questionLabel.backgroundColor = .white
        questionLabel.textColor = .black
        questionLabel.layer.borderWidth = 1
        questionLabel.layer.borderColor = UIColor.systemGreen.cgColor
        questionLabel.textAlignment = .center
        questionLabel.font = .systemFont(ofSize: 18)
        return questionLabel
    }()
    
    let answerTextField: UITextField = {
        let answerText = UITextField()
        answerText.backgroundColor = .white
        answerText.layer.borderWidth = 1
        answerText.layer.borderColor = UIColor.systemGreen.cgColor
        answerText.textAlignment = .center
        answerText.font = .systemFont(ofSize: 18)
        return answerText
    }()
    
    let submitButton: UIButton = {
        let submitButton = UIButton()
        submitButton.backgroundColor = .systemBlue
        submitButton.setTitle("SUBMIT", for: .normal)
        submitButton.titleLabel?.font = .systemFont(ofSize: 24)
        submitButton.titleLabel?.textAlignment = .center
        submitButton.layer.cornerRadius = 10
        submitButton.layer.masksToBounds = true
        submitButton.addTarget(self, action: #selector(submitButtonPress), for: .touchUpInside)
        return submitButton
    }()
    let helpButton: UIButton = {
       let helpButton = UIButton()
        helpButton.backgroundColor = .systemGreen
        helpButton.setTitle("Ответ", for: .normal)
        helpButton.titleLabel?.font = .systemFont(ofSize: 18)
        helpButton.titleLabel?.textAlignment = .center
        helpButton.layer.cornerRadius = 10
        helpButton.layer.masksToBounds = true
        helpButton.addTarget(self, action: #selector(helpButtonPress), for: .touchUpInside)
        return helpButton
    }()
    
    var firstNumber = 0
    var secondNumber = 0
    var result = 0
    var level = 0
    var delegate: resultDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBackground()
        //view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
        setupView()
        generateQuestion()
    }
    
    func setupView() {
        [questionLabel, answerTextField, submitButton,helpButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        NSLayoutConstraint.activate([
            
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            questionLabel.widthAnchor.constraint(equalToConstant: 200),
            questionLabel.heightAnchor.constraint(equalToConstant: 60),
            
            answerTextField.centerXAnchor.constraint(equalTo: questionLabel.centerXAnchor),
            answerTextField.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 60),
            answerTextField.widthAnchor.constraint(equalToConstant: 200),
            answerTextField.heightAnchor.constraint(equalToConstant: 60),
            
            submitButton.centerXAnchor.constraint(equalTo: answerTextField.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: answerTextField.bottomAnchor, constant: 80),
            submitButton.widthAnchor.constraint(equalToConstant: 250),
            submitButton.heightAnchor.constraint(equalToConstant: 80),
            
            helpButton.centerXAnchor.constraint(equalTo: submitButton.centerXAnchor),
            helpButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20),
            helpButton.widthAnchor.constraint(equalToConstant: 100),
            helpButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func generateQuestion() {
        switch level {
        case 1:
            firstNumber = Int.random(in: 1...9)
            secondNumber = Int.random(in: 1...9)
            mathExpression()
        case 2:
            firstNumber = Int.random(in: 1...19)
            secondNumber = Int.random(in: 1...19)
            mathExpression()
        case 3:
            firstNumber = Int.random(in: 1...99)
            secondNumber = Int.random(in: 1...99)
            mathExpression()
        default:
            break
        }
        
    }
    
    func mathExpression() {
       // let level = getRandomNumber()
        switch getRandomNumber() {
        case 0:
            questionLabel.text = "\(firstNumber) + \(secondNumber)"
            result = firstNumber + secondNumber
        case 1:
            questionLabel.text = "\(firstNumber) - \(secondNumber)"
            result = firstNumber - secondNumber
        case 2:
            questionLabel.text = "\(firstNumber) * \(secondNumber)"
            result = firstNumber * secondNumber
        default:
            questionLabel.text = "\(firstNumber) / \(secondNumber)"
            result = firstNumber / secondNumber
        }
    }
    
    func getRandomNumber() -> Int {
        return Int(arc4random_uniform(UInt32(3)))
    }
    
    @objc func helpButtonPress() {
        answerTextField.text = result.description
    }
    
    @objc func submitButtonPress() {
        guard let resultText = answerTextField.text else { return }
        var title = ""
        var message = ""
        if result == Int(resultText ){
            title = "Correct"
            message = "You earn 1 point"
            delegate.correctAnswer(value: 1)
            delegate.updateScore(value: 1)
        } else {
            title = "Incorrect"
            message = "You loose 1 point"
            delegate.correctAnswer(value: -1)
            delegate.updateScore(value: -1)
        }
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Еще Раз", style: .default, handler: { (action) in
            self.answerTextField.text = nil
            self.generateQuestion()
    
        }))
        alert.addAction(UIAlertAction(title: "Вернуться в главное меню", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }

}
extension UIView {
func addBackground() {
    // screen width and height:
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height

    let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
    imageViewBackground.image = UIImage(named: "mathImage")

    // you can change the content mode:
    imageViewBackground.contentMode = .scaleAspectFill

    self.addSubview(imageViewBackground)
    self.sendSubviewToBack(imageViewBackground)
}}
