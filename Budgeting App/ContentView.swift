import SwiftUI
import SwiftData

enum EntryType {
    case transaction
    case budget
}

struct ContentView: View {
    @State private var showingSheet = false
    @State private var selectedTab = 2
    @State private var showingActionSheet = false
    @State private var entryType: EntryType = .transaction
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                TransactionsView()
                    .tabItem {
                        Label("Transactions", systemImage: "list.bullet")
                    }
                    .tag(1)
                BudgetsView()
                    .tabItem {
                        Label("Budgets", systemImage: "chart.pie.fill")
                    }
                    .tag(2)
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(
                    title: Text("Create New"),
                    buttons: [
                        .default(Text("Transaction")) {
                            entryType = .transaction
                            showingSheet = true
                        },
                        .default(Text("Budget")) {
                            entryType = .budget
                            showingSheet = true
                        },
                        .cancel {
                            showingActionSheet = false
                            showingSheet = false
                        }
                    ]
                )
            }

            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showingActionSheet = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.accentColor)
                            .shadow(radius: 4)
                    }
                    .padding()
                }
                Spacer()
            }

            if showingSheet {
                ZStack {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    NewEntryView(entryType: entryType, showingActionSheet: $showingActionSheet, showingSheet: $showingSheet)
                        .padding(.top, 100)
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }
}

struct NewEntryView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) private var presentationMode

    @State private var name = ""
    @State private var limit = ""
    @State private var selectedCategory = budgetCategory.food
    @State private var amountSpent = ""
    @State private var location = ""
    @State private var transactionCategory = budgetCategory.food
    @State private var selectedDate = Date()

    var entryType: EntryType
    @Binding var showingActionSheet: Bool
    @Binding var showingSheet: Bool

    var body: some View {
        NavigationStack {
            Form {
                if entryType == .transaction { // Use the enum value
                    TextField("Amount Spent", text: $amountSpent)
                        .keyboardType(.decimalPad)
                    TextField("Location", text: $location)
                    Picker("Category", selection: $transactionCategory) {
                        ForEach(budgetCategory.allCases, id: \.self) { category in
                            Text(category.rawValue.capitalized).tag(category)
                        }
                    }
                    DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                } else {
                    TextField("Budget Name", text: $name)
                    TextField("Limit", text: $limit)
                        .keyboardType(.numberPad)
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(budgetCategory.allCases, id: \.self) { category in
                            Text(category.rawValue.capitalized).tag(category)
                        }
                    }
                }
            }
            .navigationTitle(entryType == .transaction ? "New Transaction" : "New Budget")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if entryType == .transaction { // Use enum
                            if let amount = Double(amountSpent) {
                                let newTransaction = Transaction(amountSpent: amount, location: location, category: transactionCategory, date: selectedDate)
                                context.insert(newTransaction)
                                try? context.save()
                                presentationMode.wrappedValue.dismiss()
                                showingSheet = false
                            }
                        } else {
                            if let limitInt = Int(limit) {
                                let newBudget = budget(limit: limitInt, name: name, category: selectedCategory)
                                context.insert(newBudget)
                                try? context.save()
                                presentationMode.wrappedValue.dismiss()
                                showingSheet = false
                            }
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                        showingSheet = false
                        showingActionSheet = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [budget.self, Transaction.self])
}

