//
//  Transaction.swift
//  Budgeting App
//
//  Created by David on 4/25/25.
//
import SwiftUI
import SwiftData

@Model
class Transaction {
    var amountSpent: Double
    var location: String
    var category: budgetCategory
    var date: Date
    
    init(amountSpent: Double, location: String, category: budgetCategory, date: Date) {
        self.amountSpent = amountSpent
        self.location = location
        self.category = category
        self.date = date
    }
}
