//
//  ViewController.swift
//  HangMan
//
//  Created by Amen George on 2023-10-24.
//

import UIKit

class ViewController: UIViewController {

//    variables and outlets declared
    @IBOutlet weak var imageView: UIImageView!
    let words:[String] = ["ICEBERG","CABBAGE","ACTIONS","ADAPTER","HABITAT","PACIFIC","RABBITS","VACANCY","BROWSER","CHIPSET","INSTALL","PRINTER","BUZZING","DESKTOP","DEFAULT","LETTERS"]
    var wins = 0;
    var loses = 0;
    var guessesRemaining = 7;
    var letterIncludedCount = 0
    var lettersClicked:String=""
    @IBOutlet weak var loseLabel: UILabel!
    
    @IBOutlet weak var winlabel: UILabel!
    var answerWord:String = ""
    
    
    @IBOutlet var answerOutlet: [UILabel]!
    @IBOutlet var keyBoardOutlets: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        startGame function to start the game and reset when needed
        startGame()
        
        
    }

//    function which is called when a letter is clicked from keyboard
    
    @IBAction func letterClicked(_ sender: UIButton) {
        let letterUsed:String? = sender.titleLabel?.text;    //Getting the letter clicked
        if let optionalLetterUsed = letterUsed{
            
            if answerWord.contains(optionalLetterUsed) {
                for (index, letter) in answerWord.enumerated() {
//                    checking the letter with letters in the answer word
                    if optionalLetterUsed == String(letter) {
                        answerOutlet[index].text = optionalLetterUsed
                        letterIncludedCount+=1
                        print(sender.tag)
                        changeKey(colour: UIColor.green,key: sender.tag)
                    }
                }
//                checking if all the letters are discovered
                if letterIncludedCount == 7{
                    wins+=1
                    imageView.image=UIImage.saved
                    winlabel.text="Wins:\(wins)"
                    showAlert(isSuccess: true)
                    lettersClicked.append(optionalLetterUsed)
                }
            }else{
//                work if there are no guesses remaining
                guessesRemaining -= 1
                let image = "hangman\(7-guessesRemaining)"
                imageView.image = UIImage(named: image)
                changeKey(colour: UIColor.red,key: sender.tag)
                print(sender.tag)
                if guessesRemaining == 0{
                    showAlert(isSuccess: false)
                    loses += 1
                    loseLabel.text = "Loses: \(loses)"
                }
                
            }
        }
        
    }
    
//    function to show alerts
    func showAlert(isSuccess value:Bool){
        var alert:UIAlertController;
        if value == true{
           alert = UIAlertController(title: "Woohoo!", message: "You saved me!. Would you like to play again?", preferredStyle: .alert)
        }else{
            alert = UIAlertController(title: "Uh oh", message: "The correct word was \(answerWord). Would you like to try again?", preferredStyle: .alert)
        }
        let tryAgainAction = UIAlertAction(title: "Yes", style: .default){ _ in
            self.startGame()}
        let okAction = UIAlertAction(title: "No", style: .default)
        alert.addAction(tryAgainAction)
        alert.addAction(okAction)
        self.present(alert, animated: true)

    }
    
//    function startGame
    func startGame(){
        
        guessesRemaining = 7
        lettersClicked=""
        letterIncludedCount=0
        
        var index = getrandom()
        
//        getting a random index to get a random word from the array
        while answerWord==words[index]{
            index=getrandom()
        }
        
        answerWord = words[index]
        
        print("\(answerWord)")
        
//        enabling keyboard buttons and assigning a tag to each buttons
        for (index, button) in keyBoardOutlets.enumerated() {
                button.tag = index
                button.isEnabled = true
                button.layer.cornerRadius=10
            }
//        adding border colour and border width to each labels in answer stackview
        for (_,answer) in answerOutlet.enumerated(){
            answer.layer.borderColor = UIColor.darkGray.cgColor
            answer.layer.borderWidth = 1.0
            answer.text = "_"
        }
        
        imageView.image = UIImage(named: "hangman")
        
    }
    
//    function to change the keyboard colour
    func changeKey(colour newColour:UIColor, key keyUsed:Int){
        
        let button = keyBoardOutlets[keyUsed]
        
        button.isEnabled = false
        button.backgroundColor = newColour
        button.layer.cornerRadius = 10
    }
    
//    function to get random index number
    func getrandom()->Int{
        let randomIndex = Int.random(in: 0..<words.count)
        
        return randomIndex
    }
    
    
}

