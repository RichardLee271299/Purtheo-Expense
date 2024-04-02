//
//  StatisticModel.swift
//  Purtheo Expense
//
//  Created by Lê Ngọc Phương Đông on 01/04/2023.
//

import Foundation
import Charts

struct Statistic{
    enum Category
    {
        case shopping
        case hospital
        case eat
        case fuel
        case family
        case travel
        case none
    }
    init(category: Category, value: Int, type: Int)
    {
        self.category = category
        self.value = value
        self.type = type
    }
    var category : Category
    var value: Int
    var type: Int

    static func entriesForExpense(_ expense: [Statistic], type: Int) -> [PieChartDataEntry] {
        let requestedExpense = expense.filter { $0.type == type }
        var categoryDict: [Statistic.Category: Int] = [:]
        requestedExpense.forEach {
            categoryDict[$0.category, default: 0] += $0.value
        }
        let entries = categoryDict.map { (category, value) -> PieChartDataEntry in
            let label = (category == .shopping ? "Shopping" : (category == .hospital ? "Hospital" : (category == .fuel ? "Fuel" : (category == .family ? "Family" : (category == .travel ? "Travel" : (category == .eat ? "Eat" : "Khác"))))))
            return PieChartDataEntry(value: Double(value), label: label)
        }
        return entries
    }
    
    static var allexpense: [Statistic]
    {
//       [
//        Statistic(category: .travel, value: 2000000,type: 1),
//        Statistic(category: .fuel, value: 500000,type: 1),
//        Statistic(category: .eat, value: 500000,type: 2),
//        Statistic(category: .eat, value: 500000,type: 2),
//        Statistic(category: .family, value: 1400000,type: 1)
//       ]
//
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy"
        
        let calendar = Calendar.current
        let currentMonth = AppState.shared.selectedFilterMonth
        
        let currentMonthExpense = AppState.shared.expenseData.filter { item in
            
            let stringToDate = dateFormater.date(from: item.date)
            
            let month = calendar.component(.month, from: stringToDate ?? Date())
            
            return currentMonth == month
        }
//
        let expenseData = currentMonthExpense.map { item -> Statistic in
            let category: Category = item.category == "shopping" ? .shopping : (item.category == "hospital" ? .hospital : (item.category == "eat" ? .eat : (item.category == "fuel" ? .fuel : (item.category == "family" ? .family : (item.category == "travel" ? .travel : .none)))))
            return Statistic(category: category, value: item.amount, type: item.type)
        }
        return expenseData
    }
}
