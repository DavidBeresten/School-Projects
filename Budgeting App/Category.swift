//
//  Category.swift
//  Budgeting App
//
//  Created by David on 4/25/25.
//

import SwiftUI
import SwiftData

enum budgetCategory: String, Codable, Hashable, CaseIterable {
    case food
    case bills
    case entertainment
}

