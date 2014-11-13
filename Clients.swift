//
//  Clients.swift
//  LemonadeStand
//
//  Created by Martin Brunner on 12.11.14.
//  Copyright (c) 2014 Martin Brunner. All rights reserved.
//

import Foundation


enum typeOfLemonade {
    case isAcid, isNeutral, isDiluted
}

class Clients {

    private var clients: [typeOfLemonade] = []

    var count: Int {
        return clients.count
    }
    
    init(weather: Int)   {
        var  numberOfClients = Int(arc4random_uniform(UInt32(10)))

        if numberOfClients == 0 {
            numberOfClients = 10
        }

        for count  in 1...numberOfClients {
            var randomNumber = Int(arc4random_uniform(UInt32(10)))
            if randomNumber == 0 {
                randomNumber = 1
            }
            let x: Double = 1.0/Double (randomNumber)
    
            if x < 0.4 {
                clients.append(typeOfLemonade.isAcid)
            }
            else if x >= 0.4 &&  x < 0.6 {
                clients.append(typeOfLemonade.isNeutral)
            }
            else if x >= 0.6 {
                clients.append(typeOfLemonade.isDiluted)
            }
            else {
                println("Error")
            }
        }

    }// End Init()
    
    func doesClientBuy ( index: Int, mix: typeOfLemonade) -> Bool {
        var buyingClient = false
        if index >= 0 && index < self.count {
            if clients[index] == mix {
                buyingClient = true
            }
        }
        return buyingClient
    }
    
}