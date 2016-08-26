//
//  ViewController.swift
//  cardGame
//
//  Created by AMY on 16/7/28.
//  Copyright © 2016年 AMY/David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // all the cards' attribute -> used to change image
    @IBOutlet weak var cardView1: UIButton!
    @IBOutlet weak var cardView2: UIButton!
    @IBOutlet weak var cardView3: UIButton!
    @IBOutlet weak var cardView4: UIButton!
    @IBOutlet weak var cardView5: UIButton!
    @IBOutlet weak var cardView6: UIButton!
    @IBOutlet weak var cardView7: UIButton!
    @IBOutlet weak var cardView8: UIButton!
    
    //create array
    //used to link random card's position with array, later used to change the actural card
    var randomCardArray: [String] = ["null","null","null","null","null","null","null","null"]
    var cardAsignedNum: [Int] = [0,0,0,0]
    let cardArray: [String] = ["card1","card2","card3","card4"]
    
    //Keep track of clicks
    var count: Int = 0
    
    //Hold the choosen card(s)
    var chosenCard = [String]()
    var chosenCardIndex = [Int]()
    var holdCardView = [UIButton]()
    
    //Hold the index for the cards that is done
    var finishCardIndex = [Int]()
    
    var hard: Bool = true
    
    //UI Button Array
    var buttonArray: [UIButton] = [UIButton]()
    
    //Declare a timer
    var timer = NSTimer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // You can make a game loop here. use the randomCard function during the game
        setUpButtonArray()
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
            case "Random": // reset everything, used to test random
                for i in 0..<8{
                    buttonArray[i].setImage(UIImage(named: "cardFront"), forState: UIControlState.Normal)
                    buttonArray[i].enabled = true
                }
                
                randomCard()
            default: break
                
            }
        }
    }
    
    // random card function, used to randomly assigned card to the array. 
    func randomCard(){
        // assign randomCard
        print("random run")
        cardAsignedNum = [0,0,0,0]

        for i in 0..<8{
            var assigned = false
            while(assigned==false)
            {
                print("in assigned loop")
                let ran = Int(arc4random_uniform(4))
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
        chosenCard.removeAll()
        chosenCardIndex.removeAll()
        holdCardView.removeAll()
        finishCardIndex.removeAll()
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
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.check_match), userInfo: nil, repeats: false)
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
        } else {
            holdCardView[0].setImage(UIImage(named: "cardFront"),   forState: UIControlState.Normal)
            holdCardView[0].enabled = true
            holdCardView[1].setImage(UIImage(named: "cardFront"), forState: UIControlState.Normal)
            holdCardView[1].enabled = true
            button_enable(true)
            if hard == true {
                switching_cards()
            }
            
        }//End else
        
        //Clear Array
        chosenCard.removeAll()
        chosenCardIndex.removeAll()
        holdCardView.removeAll()
    }//End check_match()
    
    func button_enable(enable: Bool){
        for i in 0..<8{
            if (finishCardIndex.contains(i) == false) && (chosenCardIndex.contains(i) == false){
                buttonArray[i].enabled = enable
            }//End if
        }//End for
    }
    
    //Hard mode
    //Switch three card if the chosen card does not match
    func switching_cards(){
        var holdIndex = [Int]()
        var tempIndex = 0
        while true {
            let thirdCardIndex = Int(arc4random_uniform(8))
            if (chosenCardIndex.contains(thirdCardIndex) == false) && (finishCardIndex.contains(thirdCardIndex) == false){
                chosenCardIndex.append(thirdCardIndex)
                chosenCard.append(randomCardArray[thirdCardIndex])
                while true {
                    let randIndex = Int(arc4random_uniform(3))
                    if holdIndex.contains(randIndex) == false {
                        holdIndex.append(randIndex)
                        randomCardArray[chosenCardIndex[tempIndex]] = chosenCard[randIndex]
                        tempIndex += 1
                    }
                    if tempIndex == 3 {
                        break
                    }
                } //End while
                break              //End outer while loop
            } //End if
        } //End while

    } //End switching_cards()
    
    
    
    
}//End of program




