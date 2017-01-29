//
//  VendingMachine.swift
//  VendingMachine
//
//  Created by Aleksander Makedonski on 1/28/17.
//  Copyright © 2017 Treehouse Island, Inc. All rights reserved.
//

import Foundation
import UIKit

enum VendingSelection: String{
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
    
    func icon() -> UIImage{
        if let image = UIImage(named: self.rawValue){
            return image
        } else{
            return #imageLiteral(resourceName: "default")
        }
    }
    
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

enum VendingMachineError: Error{
    case invalidSelection
    case outOfStock
    case insufficentFunds(required: Double)
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

enum InventoryError: Error{
    case invalidResource
    case conversionError
    case invalidSelection
}

class PlistConverter{
    static func dictionary(fromFile name: String, ofType type: String) throws -> [String: AnyObject]{
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw InventoryError.invalidResource
        }
        
        guard let dictionary = NSDictionary(contentsOfFile: path) as? [String:AnyObject] else {
            throw InventoryError.conversionError
        }
        
        return dictionary

        
    }
}

class InventoryUnarchiver{
    static func vendingInventory(fromDictionary dictionary: [String: AnyObject]) throws -> [VendingSelection: VendingItem]{
        
        var inventory: [VendingSelection:VendingItem] = [:]
        
        for (key,value) in dictionary{
            if let itemDictionary = value as? [String: Any], let price = itemDictionary["price"] as? Double, let quantity = itemDictionary["quantity"] as? Int {
                let item = Item(price: price, quantity: quantity)
                
                guard let selection = VendingSelection(rawValue: key) else {
                    throw InventoryError.invalidSelection
                }
                
                inventory.updateValue(item, forKey: selection)
            }
        }
        
        return inventory
        
    }
}
