//
//  HomeViewModel.swift
//  Purtheo Expense
//
//  Created by Lê Ngọc Phương Đông on 17/03/2023.
//

import Foundation

extension HomeView
{
    func setupView()
    {
        
        var tBalance = 0
        var tIncome = 0
        var tExpense = 0
        for item in vC.expenseData
        {
            if item.type == 1
            {
                tIncome += item.amount
                tBalance += item.amount
            }
            else
            {
                tExpense += item.amount
                tBalance -= item.amount
            }
        }
        self.totalBalance = tBalance
        self.totalExpense = tExpense
        self.totalIncome = tIncome
    }
    
    func getCurrentHour() -> Int {
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: Date())
            return hour
    }
}
