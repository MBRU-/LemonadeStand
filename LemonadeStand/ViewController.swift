//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Martin Brunner on 11.11.14.
//  Copyright (c) 2014 Martin Brunner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var lemonInventoryLabel: UILabel!
    @IBOutlet weak var iceCubeInventoryLabel: UILabel!
    @IBOutlet weak var lemonPurchaseLabel: UILabel!
    @IBOutlet weak var iceCubePurchaseLabel: UILabel!
    @IBOutlet weak var lemonMixLabel: UILabel!
    @IBOutlet weak var iceCubeMixLabel: UILabel!
    
    //Constants
    enum Purchase {
        case lemonPlus, lemonMinus, iceCubePlus,iceCubeMinus
    }
    enum LemonadeMix {
        case lemonPlus, lemonMinus, iceCubePlus,iceCubeMinus
    }
    
    let kCostForLemon = 2
    let kCostForIceCube = 1
    
    var inventoryCash = 10
    var inventoryLemons = 0
    var inventoryIceCubes = 0
    var clients: [Int] = []
    var lemonsForMix = 0
    var iceCubesForMix = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func lemonInventoryPlusButton(sender: UIButton) {
        purchaseStuff(Purchase.lemonPlus)

    }
    
    @IBAction func lemonInventoryMinusButton(sender: UIButton) {
        purchaseStuff(Purchase.lemonMinus)
    }
    
    @IBAction func iceCubeInventoryPlusButton(sender: UIButton) {
            purchaseStuff(Purchase.iceCubePlus)
    }

    @IBAction func iceCubeInventotyMinusButton(sender: UIButton) {
            purchaseStuff(Purchase.iceCubeMinus)
    }
    
    
    @IBAction func lemonMixPlusButton(sender: UIButton) {
        mixLemonade(LemonadeMix.lemonPlus)
    }
    
    @IBAction func lemonMixMinusButton(sender: UIButton) {
            mixLemonade(LemonadeMix.lemonMinus)
    }
    
    @IBAction func iceCubeMixPlusButton(sender: UIButton) {
            mixLemonade(LemonadeMix.iceCubePlus)
    }
    
    @IBAction func iceCubeMixMinusButton(sender: UIButton) {
           mixLemonade(LemonadeMix.iceCubeMinus)
    }
    
    @IBAction func startDayButton(sender: UIButton) {
        dayDeal()
        setupGame()
    }
    
    //helper functions
    
    func setupGame() {
        //setup Step 1
        cashLabel.text = "$ \(inventoryCash) "
        lemonInventoryLabel.text = "\(inventoryLemons) Lemon(s)"
        iceCubeInventoryLabel.text = "\(inventoryIceCubes) Ice Cube(s)"
        
        //Setup Step 2
        lemonPurchaseLabel.text = "\(inventoryLemons)"
        iceCubePurchaseLabel.text = "\(inventoryIceCubes)"
        
        //Setup Step 3
        lemonMixLabel.text = "\(lemonsForMix)"
        iceCubeMixLabel.text = "\(iceCubesForMix)"
    }
    
    func purchaseStuff(buyWhat: Purchase) {
        switch buyWhat {
            
        case .lemonPlus:
            if inventoryCash >= kCostForLemon {
                inventoryCash -= kCostForLemon
                inventoryLemons += 1
            }
            else {
                showAlertWithText(message: "Not enough money to buy more Lemons")
            }

        case .lemonMinus:
            if inventoryLemons >= 1 {
                inventoryCash += kCostForLemon
                inventoryLemons -= 1
            }
            else {
                showAlertWithText(message: "No more Lemons to return!")
            }
            
        case .iceCubePlus:
            if inventoryCash >= kCostForIceCube {
                inventoryCash -= kCostForIceCube
                inventoryIceCubes += 1
            }
            else {
                showAlertWithText(message: "Not enough money to buy more IceCubes")
            }

        case .iceCubeMinus:
            if inventoryIceCubes >= 1 {
                inventoryCash += kCostForIceCube
                inventoryIceCubes -= 1
            }
            else {
                showAlertWithText(message: "No more Ice Cubes to return!!")
            }
            
        default:
            println("Something happened")
        }
        setupGame()
    }
    
    func mixLemonade( mixWhat: LemonadeMix) {
        switch mixWhat {
            
        case .lemonPlus:
            if inventoryLemons >= 1 {
                inventoryLemons--
                lemonsForMix++
            }
            else {
                 showAlertWithText(message: "Need to buy more Lemons!")
            }
            
        case .lemonMinus:
            if lemonsForMix >= 1 {
                lemonsForMix--
                inventoryLemons++
            } else {
                showAlertWithText(message: "You brew lemonade with no Lemons!")
            }
            
        case .iceCubePlus:
            if inventoryIceCubes >= 1 {
                iceCubesForMix++
                inventoryIceCubes--
            } else {
                showAlertWithText(message: "Need to buy more Ice Cubes!")
            }
            
        case .iceCubeMinus:
            if iceCubesForMix >= 1 {
                iceCubesForMix--
                inventoryIceCubes++
            } else {
                showAlertWithText(message: "You brew lemonade with no Ice Cubes!")
            }
            
        default:
            println("Something happened")
        }
        setupGame()
 
    }
    
    func showAlertWithText (header: String = "Warning", message: String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func dayDeal() {
        let mix = 0

        if let mix = lemonadeMixOfToday() {
            let dayClients = Clients(weather: 0)
        
            let count = dayClients.count
                println("today we have \(count) visiting clients")
          
            for dayBalance in 0..<count {
                if dayClients.doesClientBuy(dayBalance, mix: mix) == true {
                    inventoryCash += 1
                    println("Paid")
                }
                else {
                    println("didn't want to buy")
                }
            }

        }
 
    }
    
    func lemonadeMixOfToday() -> typeOfLemonade? {
       
        if (iceCubesForMix == 0) || (lemonsForMix) == 0 {
            showAlertWithText(header: "Bad Taste!", message: "You need at least one Lemon and one Ice cube! Mix again")
            return nil
        }
        else {
            let mix = Double (lemonsForMix / iceCubesForMix)
            if mix < 1 {
                return typeOfLemonade.isDiluted
            }
            else if mix == 1 {
                return typeOfLemonade.isNeutral
            }
            else if mix > 1 {
                return typeOfLemonade.isAcid
            }
            else {
                return nil
            }
        }
        
    }

}

