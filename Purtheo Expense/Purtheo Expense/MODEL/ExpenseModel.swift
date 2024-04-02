//
//  ExpenseModel.swift
//  Purtheo Expense
//
//  Created by Lê Ngọc Phương Đông on 30/03/2023.
//

import SwiftUI
struct ExpenseModel: Codable
{
    var id: String
    var name: String
    var amount: Int
    var type: Int
    var date: String
    var category: String
}
