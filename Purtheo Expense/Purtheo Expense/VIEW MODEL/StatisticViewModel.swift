//
//  StatisticViewModel.swift
//  Purtheo Expense
//
//  Created by Lê Ngọc Phương Đông on 31/03/2023.
//

import Foundation
import Charts
import SwiftUI

extension Color {
    func toUIColor() -> NSUIColor {
        let uiColor = UIColor(self)
        return NSUIColor(cgColor: uiColor.cgColor)
    }
}

extension StatisticView
{
    func setupView()
    {
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy"
        
        let calendar = Calendar.current
        let currentMonth = vC.selectedFilterMonth
        
        //Lấy thu chi của tháng hiện tại
        let currentMonthExpense = AppState.shared.expenseData.filter { item in
            
            let stringToDate = dateFormater.date(from: item.date)
            
            let month = calendar.component(.month, from: stringToDate ?? Date())
            
            return currentMonth == month
        }
        
        topSpendingData.removeAll()
        let statisticTypeNumber = self.statisticType == .income ? 1 : 2
        
        //Clear centerValue
        centerValue = 0
        var totalExpense: Int = 0
        var totalIncome: Int = 0
        for item in currentMonthExpense
        {
            if item.type == 1
            {
                totalIncome += item.amount
            }
            else
            {
                totalExpense += item.amount
            }
            if item.type == statisticTypeNumber
            {
                self.topSpendingData.append(item)
                self.centerValue += item.amount
                
            }
        }
        //Gán total balance
        self.totalBalance = totalIncome - totalExpense
       
//        var expenseDictionary: [String: Int] = [:]
//        for expense in vC.expenseData {
//            if let amount = expenseDictionary[expense.date] {
//                expenseDictionary[expense.date] = amount + expense.amount
//            } else {
//                expenseDictionary[expense.date] = expense.amount
//            }
//        }
//        self.chartData = expenseDictionary
//        print(chartData)
      
    }
    

}
