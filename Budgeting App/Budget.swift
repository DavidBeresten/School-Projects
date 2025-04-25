//
//  Budget.swift
//  Budgeting App
//
//  Created by David on 4/23/25.
//

import SwiftData
import SwiftUI

@Model
class budget {
    var limit: Int
    var name: String
    var category: budgetCategory

    init(limit: Int, name: String, category: budgetCategory) {
        self.limit = limit
        self.name = name
        self.category = category
    }
}

