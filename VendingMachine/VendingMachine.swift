//
//  VendingMachine.swift
//  VendingMachine
//
//  Created by Aleksander Makedonski on 1/28/17.
//  Copyright © 2017 Treehouse Island, Inc. All rights reserved.
//

import Foundation
import UIKit

enum VendingSelection{
    case soda
    case dietSoda
    case chips
    case cookie
    case sandwich
    case wrap
    case candyBar
    case popTart
    case water
    case fruitJuice
    case sportsDrink
    case gum
    
}

protocol VendingItem{
    var price: Double {get}
    var quantity: Int {get set}
}

protocol VendingMachine{
    var selection: [VendingSelection] {get}
    var inventory: [VendingSelection:VendingItem] {get set}
    var amountDeposited: Double {get set}
    
    init(inventory: [VendingSelection: VendingItem])
    
    func vend(_ quantity: Int, selection: VendingSelection) throws
    func deposit(_ amount: Double)
    
}

struct Item: VendingItem{
    var price: Double
    var quantity: Int
}

class FoodVendingMachine: VendingMachine{
    
    let selection: [VendingSelection] = [
        .soda, .dietSoda, .chips, .cookie, .sandwich, .wrap, .candyBar, .popTart, .water, .fruitJuice,
        .sportsDrink, .gum
    ]
    
    var inventory: [VendingSelection : VendingItem]
    
    var amountDeposited: Double = 10
    
    required init(inventory: [VendingSelection : VendingItem]) {
        self.inventory = inventory
    }
    
    func vend(_ quantity: Int, selection: VendingSelection) throws {
        
    }
    
    func deposit(_ amount: Double) {
        
    }
}
