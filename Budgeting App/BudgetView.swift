//
//  BudgetView.swift
//  Budgeting App
//
//  Created by David on 4/25/25.
//
import SwiftUI
import SwiftData

struct BudgetsView: View {
    @Query private var budgets: [budget]

    var body: some View {
        NavigationStack {
            List {
                ForEach(budgets) { budget in
                    VStack(alignment: .leading) {
                        Text(budget.name)
                            .font(.headline)
                        Text("Limit: \(budget.limit)")
                        Text("Category: \(budget.category.rawValue.capitalized)")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Budgets")
        }
    }
}

