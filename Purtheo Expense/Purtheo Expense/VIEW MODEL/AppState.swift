//
//  AppState.swift
//  Purtheo Expense
//
//  Created by Lê Ngọc Phương Đông on 16/03/2023.
//

import Foundation
import SwiftUI
import FirebaseDatabase
class AppState: ObservableObject
{
    enum ViewCase {
        case started
        case home
        case addExpense
        case statistic
        case personal
        case story
    }
    
    static let shared = AppState()
    
    init(){
        getExpense()
        removeExpense()
    }
    
    @AppStorage("name") var name = ""
    @AppStorage("devideID") var deviceID = UIDevice.current.identifierForVendor!.uuidString
    @Published var isShowFirstScreen: Bool = false
    @Published var current: ViewCase = .started
    @Published var expenseData: [ExpenseModel] = []
    @Published var selectedFilterMonth: Int = Calendar.current.component(.month, from: Date())
  
    
    
    func getExpense()
    {
        self.expenseData.removeAll()
        let ref = Database.database(url: "https://purtheo-exspense-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
        // Lắng nghe sự thay đổi trên Firebase Realtime Database
        ref.child("\(deviceID)/expense").observe(.childAdded) { snapshot in
                guard let value = snapshot.value as? [String: Any],
                    let id = value["id"] as? String,
                    let name = value["name"] as? String,
                    let amount = value["amount"] as? Int,
                    let type = value["type"] as? Int,
                    let date = value["date"] as? String,
                    let category = value["category"] as? String
                else { return }
                
                let expense = ExpenseModel(id: id, name: name, amount: amount, type: type, date: date, category: category)
                self.expenseData.append(expense)
          }
    }
    func removeExpense()
    {
        let ref = Database.database(url: "https://purtheo-exspense-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
        ref.child("\(deviceID)/expense").observe(.childRemoved) { snapshot in
            print(snapshot)
                guard let value = snapshot.value as? [String: Any],
                    let id = value["id"] as? String
                else { return }
                
            self.expenseData.removeAll(where: {$0.id == id})
          }
    }
}
