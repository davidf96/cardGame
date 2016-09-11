//
//  ViewControllerEasy.swift
//  cardGame
//
//  Created by AMY on 16/9/8.
//  Copyright © 2016年 AMY/David. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerEasy:UIViewController
{
    
    @IBOutlet weak var cardView1: UIButton!
    
    @IBOutlet weak var cardView2: UIButton!
    
    @IBOutlet weak var cardView3: UIButton!
    
    @IBOutlet weak var cardView4: UIButton!
    
    @IBOutlet weak var cardView5: UIButton!
    
    @IBOutlet weak var cardView6: UIButton!
    
    @IBOutlet weak var cardView7: UIButton!
    
    @IBOutlet weak var cardView8: UIButton!
    
    @IBOutlet weak var cardView9: UIButton!
    
    @IBOutlet weak var cardView10: UIButton!
    
    @IBOutlet weak var cardView11: UIButton!
    
    @IBOutlet weak var cardView12: UIButton!

    
    //create array
    //used to link random card's position with array, later used to change the actural card
    var randomCardArray: [String] = ["null","null","null","null","null","null","null","null","null","null","null","null"]
    var cardAsignedNum: [Int] = [0,0,0,0,0,0]
    let cardArray: [String] = ["card1","card2","card3","card4","card5","card6"]
    
    var count: Int = 0          //Keep track of clicks
    var score: Int = 0           //Keep track of  score
    
    //Hold the choosen card(s)
    var chosenCard = [String]()
    var chosenCardIndex = [Int]()
    var holdCardView = [UIButton]()
    
    //Hold the index for the cards that is done
    var finishCardIndex = [Int]()
    
    
    //Create Array to hold the UIButton
    var buttonArray: [UIButton] = [UIButton]()
    
    //Declare a timer
    var timer = NSTimer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // You can make a game loop here. use the randomCard function during the game
        randomCard()    // this is just a test
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Connected all the Card View button to this Action (ctr button and drag it to this function , apply to all button)
    @IBAction func ClickImage(sender: UIButton) {
        // link title with the title of button being clicked
        if let title = sender.currentTitle {  // this if statement is need for whatever reason, I googled it
            // switch used to see what button being clicked
            switch title{
            case "CardView1":
                buttonClicked(0)
                break
            case "CardView2":
                buttonClicked(1)
                break
            case "CardView3":
                buttonClicked(2)
                break
            case "CardView4":
                buttonClicked(3)
                break
            case "CardView5":
                buttonClicked(4)
                break
            case "CardView6":
                buttonClicked(5)
                break
            case "CardView7":
                buttonClicked(6)
                break
            case "CardView8":
                buttonClicked(7)
                break
            case "CardView9":
                buttonClicked(8)
                break
            case "CardView10":
                buttonClicked(9)
                break
            case "CardView11":
                buttonClicked(10)
                break
            case "CardView12":
                buttonClicked(11)
                break
            case "Reset": // reset everything, used to test random
                clear_all()
                randomCard()
                
            default: break
                
            }
        }
    }
    
    
    
    //Reset all the global variables
    func clear_all(){
        for i in 0..<12{
            buttonArray[i].setImage(UIImage(named: "cardFront"), forState: UIControlState.Normal)
            buttonArray[i].enabled = true
        }
        randomCardArray = ["null","null","null","null","null","null","null","null","null","null","null","null"]
        cardAsignedNum = [0,0,0,0,0,0]
        count = 0
        chosenCard.removeAll()
        chosenCardIndex.removeAll()
        holdCardView.removeAll()
        finishCardIndex.removeAll()
        buttonArray.removeAll()
        score = 0
    }
    
    // random card function, used to randomly assigned card to the array.
    func randomCard(){
        // assign randomCard
        print("random run")
        
        for i in 0..<12{
            var assigned = false
            while(assigned==false)
            {
                print("in assigned loop")
                let ran = Int(arc4random_uniform(6))
                //print(cardAsignedNum[0])
                
                if cardAsignedNum[ran] < 2
                {
                    randomCardArray[i] = cardArray[ran]
                    cardAsignedNum[ran] = cardAsignedNum[ran]+1
                    print("randomNum: ", ran, " card: ",cardArray[ran], " CardAssigned: ", cardAsignedNum[ran] )
                    assigned = true
                }
            }
            print(i)
        }
        
        setUpButtonArray()    //Set up the array to hold the UIButton
    }
    
    //Set up UIButton Array
    func setUpButtonArray() {
        buttonArray.append(cardView1)
        buttonArray.append(cardView2)
        buttonArray.append(cardView3)
        buttonArray.append(cardView4)
        buttonArray.append(cardView5)
        buttonArray.append(cardView6)
        buttonArray.append(cardView7)
        buttonArray.append(cardView8)
        buttonArray.append(cardView9)
        buttonArray.append(cardView10)
        buttonArray.append(cardView11)
        buttonArray.append(cardView12)
        
    }
    
    //Set image and add everything to the appropriate list when a card is click
    func buttonClicked(index: Int) {
        buttonArray[index].setImage(UIImage(named: randomCardArray[index]), forState: UIControlState.Normal)
        buttonArray[index].enabled = false
        count += 1
        chosenCard.append(randomCardArray[index])
        chosenCardIndex.append(index)
        holdCardView.append(buttonArray[index])
        //Check how many cards have been choosen
        if count % 2 == 0 {
            button_enable(false)
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(ViewControllerEasy.check_match), userInfo: nil, repeats: false)
            //check_match()       //Call this function for match when two cards choosen
            
        }
        
    }
    
    
    //Check if the two choosen cards match or not
    func check_match(){
        //Compare the two chosen cards
        if chosenCard[0] == chosenCard[1] {
            finishCardIndex.append(chosenCardIndex[0])
            finishCardIndex.append(chosenCardIndex[1])
            button_enable(true)
            // add 50 points
            score += 50
            
            
        } else {
            holdCardView[0].setImage(UIImage(named: "cardFront"),   forState: UIControlState.Normal)
            holdCardView[0].enabled = true
            holdCardView[1].setImage(UIImage(named: "cardFront"), forState: UIControlState.Normal)
            holdCardView[1].enabled = true
            button_enable(true)
            score -= 5

            
        }//End else
        
        //Clear Array
        chosenCard.removeAll()
        chosenCardIndex.removeAll()
        holdCardView.removeAll()
        
        //check if the game win or not
        if(finishCardIndex.count == 12)
        {
            game_win()
        }
        
    }//End check_match()
    
    
    
    func button_enable(enable: Bool){
        for i in 0..<12{
            if (finishCardIndex.contains(i) == false) && (chosenCardIndex.contains(i) == false){
                buttonArray[i].enabled = enable
            }//End if
        }//End for
    }
    
    
    //Reset everything and update maximum score
    //show the completion image and the score
    func game_win(){
        let refreshAlert = UIAlertController(title: "Your Score", message: "Your Score is " + String(score), preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        clear_all()
        randomCard()

    }
    
    

}
