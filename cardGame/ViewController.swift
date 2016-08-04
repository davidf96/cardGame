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
                cardView1.setImage(UIImage(named: randomCardArray[0]), forState: UIControlState.Normal) // this code used to change image of button
                break
            case "CardView2":
                cardView2.setImage(UIImage(named: randomCardArray[1]), forState: UIControlState.Normal)
                break
            case "CardView3":
                cardView3.setImage(UIImage(named: randomCardArray[2]), forState: UIControlState.Normal)
                break
            case "CardView4":
                cardView4.setImage(UIImage(named: randomCardArray[3]), forState: UIControlState.Normal)
                break
            case "CardView5":
                cardView5.setImage(UIImage(named: randomCardArray[4]), forState: UIControlState.Normal)
                break
            case "CardView6":
                cardView6.setImage(UIImage(named: randomCardArray[5]), forState: UIControlState.Normal)
                break
            case "CardView7":
                cardView7.setImage(UIImage(named: randomCardArray[6]), forState: UIControlState.Normal)
                break
            case "CardView8":
                cardView8.setImage(UIImage(named: randomCardArray[7]), forState: UIControlState.Normal)
            case "Random": // reset everything, used to test random
                cardView1.setImage(UIImage(named: "cardFront"), forState: UIControlState.Normal)
                 cardView2.setImage(UIImage(named: "cardFront"), forState: UIControlState.Normal)
                cardView3.setImage(UIImage(named: "cardFront"), forState: UIControlState.Normal)
                cardView4.setImage(UIImage(named: "cardFront"), forState: UIControlState.Normal)
                cardView5.setImage(UIImage(named: "cardFront"), forState: UIControlState.Normal)
                cardView6.setImage(UIImage(named: "cardFront"), forState: UIControlState.Normal)
                cardView7.setImage(UIImage(named: "cardFront"), forState: UIControlState.Normal)
                cardView8.setImage(UIImage(named: "cardFront"), forState: UIControlState.Normal)
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
    }
}
