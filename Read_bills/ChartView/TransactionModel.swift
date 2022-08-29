//
//  TransactionModel.swift
//  Read_bills
//
//  Created by chang xing on 23/08/2022.
//

import Foundation
import SwiftUI
import SwiftUIFontIcon

struct Transaction: Identifiable, Decodable, Hashable{
    let id: Int
    let date: String
    // let institution: String
    // let account: String
    var merchant: String
    let amount: Double
    let type: TransactionType.RawValue
    var categoryID: Int
    var category: String
    // let isPending: Bool
    // var isTransfer: Bool
    var isExpense: Bool
    // var isEdited: Bool
    
    var icon: FontAwesomeCode{
        if let category = Category.all.first(where: {$0.id == categoryID}) {
            return category.icon
        }
        
        return .home
    }
    
    
    var dateParsed: Date{
        date.dateParsed()
    }
    
    var signedAmount: Double {
        return type == TransactionType.receive.rawValue ? amount : -amount
    }
    
    var month: String{
        dateParsed.formatted(.dateTime.year().month(.wide))
    }
    
}

enum TransactionType: String{
    case pay = "pay"
    case receive = "receive"
}

struct Category {
    let id: Int
    let name: String
    let icon: FontAwesomeCode
    var mainCategoryID: Int?
}

extension Category{
    
    static let home = Category(id: 1, name: "Home", icon: .home)
    static let income = Category(id: 2, name: "Income", icon: .dollar_sign)
    
    
    static let gas = Category(id: 101, name: "Gas", icon: .gas_pump, mainCategoryID: 1)
    static let water = Category(id: 102, name: "Water", icon: .water, mainCategoryID: 1)
    static let electric = Category(id: 103, name: "Electric", icon: .lightbulb, mainCategoryID: 1)
    static let paycheque = Category(id: 201, name: "Paycheque", icon: .dollar_sign, mainCategoryID: 2)
}

extension Category{
    static let categories: [Category] = [
        .home,
        .income
    ]
    
    static let subCategories: [Category] = [
        .gas,
        .water,
        .electric,
        .paycheque
    ]
    
    static let all: [Category] = categories + subCategories
}


