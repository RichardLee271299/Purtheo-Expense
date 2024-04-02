//
//  MemoryView.swift
//  Purtheo Expense
//
//  Created by Lê Ngọc Phương Đông on 11/05/2023.
//

import SwiftUI


struct MemoryView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack
            {
                RemoteImageFireStorage(url: "background.jpg")
                    .ignoresSafeArea()
                
                 VStack
                 {
                     HStack
                     {
                         VStack(alignment: .leading,spacing: 10)
                         {
                             Button {
                                 AppState.shared.current = .home
                             } label: {
                                 Image(systemName: "chevron.left")
                                     .foregroundColor(Color(rgb: "#ffffff"))
                                     .font(.system(size: 24).weight(.medium))
                             }

                         }
                         Spacer()
                         
                         Text("Đông & Nguyên Memory")
                             .foregroundColor(Color(rgb: "#ffffff"))
                             .font(.system(size: 18).weight(.semibold))
                         
                         
                         Spacer()
                         Button {
                           
                         } label: {
                             Image(systemName: "text.book.closed")
                                 .foregroundColor(Color(rgb: "#ffffff"))
                                 .font(.system(size: 24).weight(.medium))
                         }
                         
                     }
                     .padding(.vertical,10)
                     .padding(.horizontal,12)
                     .foregroundColor(.white)
                     .frame(maxHeight: .infinity, alignment: .top)

                     Image("image1")
                         .resizable()
                         .frame(maxWidth: .infinity)
                         .frame(height: 300)
                         .aspectRatio(contentMode: .fit) 
                     
                     Spacer()

                 }
                 .padding(.horizontal,8)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct MemoryView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryView()
    }
}
