//
//  MainView.swift
//  Purtheo Expense
//
//  Created by Lê Ngọc Phương Đông on 16/03/2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var vC: AppState = AppState.shared
    
    var body: some View {
        ZStack
        {
            VStack
            {
                GeometryReader {geo in
                    switch vC.current
                    {
                        case .started:
                            VStack(spacing: 10)
                            {
                                ZStack
                                {
                                    Image("person")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxHeight: .infinity,alignment: .bottom)
                                      
                                }
                                .frame(width: geo.size.width, height: geo.size.height * 0.6,alignment: .top)
                                .background(
                                    Image("bgperson")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                                        .ignoresSafeArea()
                                )
                                
                                VStack(spacing: 5)
                                {
                                    Text("Spend Smarter")
                                    Text("Save More")
                                }
                                .font(.system(size: 36).weight(.heavy))
                                .foregroundColor(Color(rgb: "#438883"))
                                
                            
                                Button {
                                    vC.current = .home
                                } label: {
                                    VStack
                                    {
                                        Text("Get Started")
                                            .foregroundColor(.white)
                                            .font(.system(size: 16))
                                    }
                                    .padding()
                                    .frame(width: geo.size.width - 100)
                                    .background(
                                        RoundedRectangle(cornerRadius: 50)
                                            .fill(
                                                LinearGradient(colors: [Color(rgb: "#69AEA9"),Color(rgb: "#3F8782")], startPoint: .top, endPoint: .bottom)
                                            )
                                            .shadow(color: Color(rgb: "#3E7C78").opacity(0.6), radius: 10, x: 0, y: 10)
                                    )
                                   
                                }
                                
                                Text("Powered by Dong Le")
                                    .font(.system(size: 10))
                                    .foregroundColor(Color(rgb: "#444444"))
                                    .padding()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(.white)
                            .ignoresSafeArea()
                        case .home:
                            HomeView()
                        case .addExpense:
                            AddExpenseView()
                        case .statistic:
                            StatisticView()
                        case .personal:
                            DevelopView()
                        case .story:
                            StoryView()
//                        case .walet:
//                            DevelopView()
                        
                   
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background()
            // Màn hình chào khởi động
            if vC.isShowFirstScreen {
                ZStack {
                    VStack(spacing: 8) {
                            Text("PURTHEO EXPENSE")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.title)
                                .padding(.vertical, 5)
            //                            ProgressView()
            //                                .scaleEffect(1.5)
            //                                .progressViewStyle(CircularProgressViewStyle(tint: Color("primary")))
            //                                .padding(.top, 10)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(rgb: "#59a8a2"))
                .opacity(vC.isShowFirstScreen ? 1 : 0)
                .ignoresSafeArea(.container)
                .animation(.easeInOut, value: vC.isShowFirstScreen)
            }
        }
        .onAppear
        {
            
            // Màn hình chào khởi động
            if !vC.isShowFirstScreen {
                // Hiển thị màn hình chào
                vC.isShowFirstScreen = true
                
                // Cài đặt hiển thị trong 1.5 giây, không lặp lại.
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { timer in
                    // Tắt hiển thị màn hình chờ
                    vC.isShowFirstScreen = false
                    // Huỷ bộ đếm thời gian
                    timer.invalidate()
                })
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
