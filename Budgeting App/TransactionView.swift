//
//  TransactionView.swift
//  Budgeting App
//
//  Created by David on 4/25/25.
//
import SwiftUI
import SwiftData

struct TransactionsView: View {
    @Query private var transactions: [Transaction]

    var body: some View {
        NavigationStack {
            List {
                ForEach(transactions) { transaction in
                    VStack(alignment: .leading) {
                        Text("Amount: $\(transaction.amountSpent, specifier: "%.2f")")
                            .font(.headline)
                        Text("Location: \(transaction.location)")
                        Text("Category: \(transaction.category.rawValue.capitalized)")
                            .foregroundStyle(.secondary)
                        Text("Date: \(transaction.date, formatter: DateFormatter())")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Transactions")
        }
    }
}

