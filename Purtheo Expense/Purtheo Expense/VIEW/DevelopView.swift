//
//  DevelopView.swift
//  Purtheo Expense
//
//  Created by Lê Ngọc Phương Đông on 23/03/2023.
//

import SwiftUI

struct DevelopView: View {
    var body: some View {
        VStack
        {
            Button {
                AppState.shared.current = .home
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color(rgb: "#222222"))
                    .font(.system(size: 24).weight(.medium))
            }
            .frame(maxWidth:.infinity,alignment: .leading)
            
            Spacer()

            Text("VIEW ĐANG ĐƯỢC PHÁT TRIỂN")
                .font(.system(size: 14).weight(.semibold))
            Spacer()
        }
        .padding()
        .frame(maxWidth:.infinity, maxHeight: .infinity)
    }
}

struct DevelopView_Previews: PreviewProvider {
    static var previews: some View {
        DevelopView()
    }
}
