//
//  DatePickerView.swift
//  Purtheo Expense
//
//  Created by Lê Ngọc Phương Đông on 20/03/2023.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var datetime: Date
    @Binding var showPicker: Bool
    @State var datePicked: Date = Date()
    @Binding var selectedDateText: String
    var body: some View {
        ZStack {
            Color(rgb: "#333333")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
           VStack
            {
                DatePicker("", selection: self.$datePicked, in: ...Date.now, displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .labelsHidden()
                .environment(\.locale, Locale(identifier: "vi-VN"))
                HStack {
                    Button {
                        showPicker = false
                    }
                    label: {
                        Text("Huỷ")
                            .bold()
                    }
                    .padding(.trailing, 10)
                    Button {
                        datetime = datePicked
                        selectedDateText = datePicked.DateToString()
                        showPicker = false
                    }
                    label: {
                        Text("Xong")
                            .bold()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .bottomTrailing)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(rgb: "#cccccc"))
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                    )
            )
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear
        {
            self.datePicked = datetime
        }
    }
}
