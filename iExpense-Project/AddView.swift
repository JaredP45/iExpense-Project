//
//  AddView.swift
//  iExpense-Project
//
//  Created by Jared Paubel on 4/7/21.
//  Copyright © 2021 IN185 BS. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var expenses: Expenses
    
    static let types = ["Business", "Personal"]
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
        .navigationBarTitle("Add new expense")
                
        .navigationBarItems(trailing:
            Button("Save"){
                if let actualAmount = Int(self.amount)
                {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode
                        .wrappedValue.dismiss()
                } else {
                    self.showAlert = true
                }
        })
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Warning!"), message: Text("You must complete the fields with the correct values!"), dismissButton: .default(Text("Okay")))
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
