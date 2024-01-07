//  ViewController.swift
//  Auden

import UIKit
import AVFoundation

/* code written under the ViewController class
interacts with the first screen of the application. */
class ViewController: UIViewController {

/*  global variables synth and audenUtters utilize
 the AVFoundation library in Swift language */
    let synth = AVSpeechSynthesizer()
    var audenUtters = AVSpeechUtterance(string: "")

/* method responsible for running all initial
    views and set ups */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //example of abstraction
        AudenWelcomesUser()
    }

    //method AudenWelcomesUser
    func AudenWelcomesUser(){
        audenUtters = AVSpeechUtterance(string: "Hi there! I am Auden! Your child's virtual assistant.")
        audenUtters.rate = 0.5
        synth.speak(audenUtters)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK:- SecondViewControllerSection

class SecondViewController: UIViewController, UITextFieldDelegate {
    
//  defining connections to UIElements displayed on user's screen
    
//  main label that displays prompts to which user responds to
    @IBOutlet weak var directionsText: UILabel!
    
//  main text field by which user interacts with user.
    @IBOutlet weak var usersInput: UITextField!
    
//  function when the main done button is pressed to transition from one screen to the next.
    @IBAction func doneButtonPressed(_ sender: Any) {
        
// if this segue does not work as intended, the default procedures
// are executed.
        shouldPerformSegue(withIdentifier: "presentModally", sender: (Any).self)
        
    }
    
//    defining the variable number allows the simplification of code
    var number = 0; let numbers = 4
    
//    the main array used to display to the user, the prompts to
//    answer the questions correctly
    var directionsForUserArray = ["What should I say if the child wants food?",
                                  "What should I say if the child wants to drink?",
                                  "What should I say if the child is in danger?",
                                  "What should I say if the child is asked their name and other information?"]
    
//    main array where user's input is stored.
    var whatAudenSpeaks = [String]()
    
//    this method is executed when the second screen loads
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//    ALGORITHM - uses an if else statement to check if the value inputted by the user is nil. If yes, the program exits the function.
        if self.usersInput == nil {
            if number == 4 {
                print("\(whatAudenSpeaks)")
            } else {
                print("we've encountered a nil value and exited the function successfully!")
            return
            }
//    if the value is not nil, then the algorithm calls the
//    AudenSpeaks() method, responsible for prompting the user
//    to input information, assigns the user's input to self,
//    and iterates through the next direction text.
        } else {
            AudenSpeaks()
            usersInput.delegate = self
            directionsText.text = directionsForUserArray[number]
            while number < 4 {
                number+=1
                print("number is less than 4")
            }
        }
    }

    @IBAction func nextButtonPressed(_ sender: Any) {
        
        if textFieldShouldReturn(usersInput) == true {
            whatAudenSpeaks.append(self.usersInput.text ?? "")
        }
        if number == numbers {
            print(whatAudenSpeaks)
            return
        } else {
            updateView()
            number+=1
            textFieldDidBeginEditing(usersInput)
        }
    }
//    updates the view of the screen
    func updateView() {
        directionsText.text = directionsForUserArray[number]
        AudenSpeaks()
    }

//  textFieldShouldReturn, textFieldShouldClear,
//  and textFieldDidBeginEditing are three methods called
//  to reset the text field each time the 'next' button is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usersInput.resignFirstResponder()
        return true }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        usersInput.text = "" }
    
    
    let synth = AVSpeechSynthesizer()
    var audenSpeaks = AVSpeechUtterance(string: "")
    
    func AudenSpeaks() {
        audenSpeaks = AVSpeechUtterance(string: "\(directionsForUserArray[number])")
        audenSpeaks.rate = 0.5
        synth.speak(audenSpeaks)
    }
    
//    this abstraction is catered specifically towards
//    the third screen, taking in the parameter,
//    'indexValue', to iterate through to produce audio feedback
    func AudenSpeaksForChild(indexValue : Int) {
        audenSpeaks = AVSpeechUtterance(string: "\(whatAudenSpeaks[indexValue])")
        audenSpeaks.rate = 0.5
        synth.speak(audenSpeaks)
        print("Auden has spoken.")
    }
    
//    the default array used in case of error with nil value.
    var audenDefaultArray = [
        "Yes.",
        "No.",
        "Please feed me, I am hungry.",
        "Please give me water, I am thirsty.",
        "Help! Call my family member.",
        "Hi there. I am an awesome person. Sometimes I struggle with speech, but I get over it using this personal assistant." ]
    
// default speech method constructed to provide default feedback,
// in case of a nil value.
    func whatAudenSpeaksForChildByDefault(defaultNumber : Int) {
        audenSpeaks = AVSpeechUtterance(string : "\(audenDefaultArray[defaultNumber])")
        audenSpeaks.rate = 0.5
        synth.speak(audenSpeaks)
    }
    
//    each button pressed results in the execution of the function -
//    'whatAudenSpeaksForChildByDefault' set w/ index value
    @IBAction func yesButtonPressed(_ sender: Any) {
        whatAudenSpeaksForChildByDefault(defaultNumber: 0)
    }
    
    @IBAction func noButtonPressed(_ sender: Any) {
        whatAudenSpeaksForChildByDefault(defaultNumber: 1)

    }
    
    @IBAction func foodButtonPressed(_ sender: Any) {
//        AudenSpeaksForChild(indexValue : 1)
        whatAudenSpeaksForChildByDefault(defaultNumber: 2)

    }
    
    @IBAction func drinkButtonPressed(_ sender: Any) {
//        AudenSpeaksForChild(indexValue : 1)
        whatAudenSpeaksForChildByDefault(defaultNumber: 3)

    }
    
    @IBAction func helpMeButtonPressed(_ sender: Any) {
//        AudenSpeaksForChild(indexValue : 2)
        whatAudenSpeaksForChildByDefault(defaultNumber: 4)

    }
    
    @IBAction func aboutMeButtonPressed(_ sender: Any) {
//        AudenSpeaksForChild(indexValue : 3)
        whatAudenSpeaksForChildByDefault(defaultNumber: 5)

    }
}
