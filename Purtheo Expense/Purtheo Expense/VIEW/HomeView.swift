//
//  HomeView.swift
//  Purtheo Expense
//
//  Created by Lê Ngọc Phương Đông on 17/03/2023.
//

import SwiftUI
import FirebaseDatabase

struct HomeView: View {
    @StateObject var vC = AppState.shared
    @State var name = ""
    @State var message = ""
    @State var totalBalance = 0
    @State var totalIncome = 0
    @State var totalExpense = 0
    @State var session: String = ""
    @State var isShowNotiView: Bool = false
    var body: some View {
        ZStack
        {
            GeometryReader { geo in
                VStack (spacing: 80)
                {
                    
                    ZStack
                    {
                        ZStack(alignment: .leading)
                        {
                            VStack
                            {
                                Image("three-circle")
                                    .opacity(0.06)
                                    .offset(x: -5)
                            }
                            .frame(maxHeight: .infinity, alignment: .topLeading)
                            HStack
                            {
                                VStack(alignment: .leading,spacing: 10)
                                {
                                    Text("\(session),")
                                        .font(.system(size: 16).weight(.medium))
                                  
                                    Text("\(vC.name)")
                                        .font(.system(size: 22).weight(.semibold))
                                }
                                Spacer()
                                
                                Button {
                                    isShowNotiView.toggle()
                                } label: {
                                    ZStack
                                    {
                                        Image(systemName: "bell")
                                            .resizable()
                                            .frame(width: 23, height: 23)
                                        Circle()
                                            .fill(Color(rgb: "#FFAB7B"))
                                            .frame(width: 8,height: 8)
                                            .offset(x: 6, y: -8)
                                    }
                      
                                }

                            }
                            .padding(.horizontal, 20)
                            .padding(.top,80)
                            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                            .foregroundColor(.white)
                        }
                        .background(
                            VStack
                            {
                                CrescentShape()
                                    .fill(LinearGradient(colors: [Color(rgb: "#429690"),Color(rgb: "#2A7C76")], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .frame(width: geo.size.width * 2, height: geo.size.height / 2)
                                    .scaledToFit()
                            }
                        )
                        
                       VStack
                        {
                            VStack(spacing: 20)
                            {
                                VStack(alignment: .leading, spacing: 10)
                                {
                                    Text("Total Balance")
                                        .font(.system(size: 16).weight(.semibold))
                                    Text("\(totalBalance)")
                                        .font(.system(size: 30).weight(.semibold))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                HStack
                                {
                                    VStack(alignment: .leading, spacing: 6)
                                    {
                                        HStack
                                        {
                                            Image(systemName: "arrow.down")
                                                .font(.system(size: 12))
                                                .padding(4)
                                                .background(
                                                    Circle()
                                                        .fill(Color.white.opacity(0.4))
                                                )
                                            Text("Income")
                                                .foregroundColor(Color(rgb: "#D0E5E4"))
                                        }
                                        
                                        Text("\(totalIncome)")
                                            .font(.system(size: 20).weight(.semibold))
                                    }
                                    Spacer()
                                    VStack(alignment: .leading, spacing: 6)
                                    {
                                        HStack
                                        {
                                            Image(systemName: "arrow.up")
                                                .font(.system(size: 12))
                                                .padding(4)
                                                .background(
                                                    Circle()
                                                        .fill(Color.white.opacity(0.4))
                                                )
                                            Text("Expense")
                                                .foregroundColor(Color(rgb: "#D0E5E4"))
                                        }
                                        
                                        Text("\(totalExpense)")
                                            .font(.system(size: 20).weight(.semibold))
                                    }
                                }
                            }
                            .padding()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(rgb: "#2F7E79"))
                            )
                            .shadow(color: Color(rgb: "#1B5C58").opacity(0.6), radius: 10, x: 0, y: 10)
                            .padding(.horizontal,20)
                            
                        }
                        .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .bottom)
                        .offset(y: 70)
                    }
                    .frame(width: geo.size.width, height: geo.size.height / 3)
                    
                    VStack (spacing: 0)
                    {
                        VStack
                        {
                            HStack
                            {
                                Text("Transactions History")
                                    .font(.system(size: 18).weight(.semibold))
                                    .foregroundColor(Color(rgb: "#333333"))
                                Spacer()
                                Text("See all")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(rgb: "#666666"))
                            }
                            
                            ScrollView(showsIndicators: false)
                            {
                                ForEach(vC.expenseData.reversed(), id: \.id){item in
                                    TransactionItem(data: item)
                                }
                            }
                            
                        }
                        .padding(.horizontal)
                        .padding(.vertical,6)
                        
                        //Menu tab bar
                        HStack
                        {
                            Button(action: {
                                vC.current = .home
                            }, label: {
                                if vC.current == .home
                                {
                                    Image("home-fill")
                                        .resizable()
                                        .frame(width: 30,height: 30)
                                }
                                else
                                {
                                    Image("home")
                                        .resizable()
                                        .frame(width: 30,height: 30)
                                }
                            })
                            .frame(width: UIScreen.main.bounds.width / 5.5, height: 28, alignment: .center)
                            
                            Button(action: {
                                vC.current = .statistic
                            }, label: {
                                
                                if vC.current == .statistic
                                {
                                    Image("chart-fill")
                                        .resizable()
                                        .frame(width: 30,height: 30)
                                }
                                else
                                {
                                    Image("chart")
                                        .resizable()
                                        .frame(width: 30,height: 30)
                                }
                            })
                            .frame(width: UIScreen.main.bounds.width / 5.5, height: 28, alignment: .center)
                           
                            Button {
                                vC.current = .addExpense
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20).weight(.semibold))
                                    .padding()
                                    .background(
                                        Circle()
                                            .fill(Color(rgb: "#438883"))
                                    )
                            }

                            
                            Button(action: {
                                vC.current = .story
                            }, label: {
                                
                                if vC.current == .story
                                {
                                    Image(systemName: "heart.fill")
                                        .resizable()
                                        .foregroundColor(Color(rgb: "#4e938e"))
                                        .frame(width: 30,height: 30)
                                }
                                else
                                {
                                    Image(systemName: "heart")
                                        .resizable()
                                        .foregroundColor(Color(rgb: "#aaaaaa"))
                                        .frame(width: 26,height: 26)
                                }
                            })
                            .frame(width: UIScreen.main.bounds.width / 5.5, height: 28, alignment: .center)
                           
                            
                            Button(action: {
                                vC.current = .personal
                            }, label: {
                                if vC.current == .personal
                                {
                                    Image("person-fill")
                                        .resizable()
                                        .frame(width: 30,height: 30)
                                }
                                else
                                {
                                    Image("iconperson")
                                        .resizable()
                                        .frame(width: 30,height: 30)
                                }
                            })
                            .frame(width: UIScreen.main.bounds.width / 5.5, height: 28, alignment: .center)
                           
                        }
                        .padding(.top,2)
                        .background(
                            Rectangle()
                                .fill(Color.clear)
                                .frame(maxWidth:.infinity, maxHeight: .infinity)
                                .shadow(color: .black, radius: 5, x: 0, y: -20)
                            
                        )
                        
                    }
                    .padding(.top)
                }

            }
            
            NotiView(isShowNotiView: $isShowNotiView)
                .offset(x: isShowNotiView ? 0 : UIScreen.main.bounds.width + 20)
                .animation(Animation.easeOut(duration: 0.25), value: isShowNotiView)
             
            //Popup nhập tên
            if vC.name == ""
            {
                
                GeometryReader { geobox in
                    ZStack
                    {
                        Image("BG_Login")
                            .resizable()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        VStack(alignment: .leading,spacing: 10)
                        {
                            
                               Text("NAME")
                                    .font(.system(size: 12).weight(.medium))
                                    .tracking(2)
                                    .foregroundColor(Color(rgb: "#29756F"))
                                HStack
                                {
                                    TextField("",text: $name)
                                        .font(.system(size: 14).weight(.medium))
                                    Spacer()
                                    if name != ""
                                    {
                                        Button {
                                            name = ""
                                        } label: {
                                            Text("Clear")
                                                .foregroundColor(Color(rgb: "#888888"))
                                                .font(.system(size: 12).weight(.medium))
                                        }
                                    }
                                }
                                .padding(14)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                   RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color(rgb: "#29756F"))
                                )
                                Button {
                                    if name == ""
                                    {
                                        message = "Vui lòng nhập tên"
                                    }
                                    else
                                    {
                                        vC.name = name
                                        let ref = Database.database(url: "https://purtheo-exspense-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
                                        ref.child("\(vC.deviceID)/name").setValue(name)
                                    }
                                } label: {
                                    VStack
                                    {
                                        Text("SUBMIT")
                                            .font(.system(size: 14).weight(.semibold))
                                    }
                                    .foregroundColor(.white)
                                    .padding(14)
                                    .frame(maxWidth: .infinity)
                                    .background(
                                       RoundedRectangle(cornerRadius: 5)
                                           .fill(Color(rgb: "#29756F"))
                                    )
                                }
                            
                            if message != ""
                            {
                                Text("\(message)")
                                    .foregroundColor(.red)
                                    .font(.system(size: 12).weight(.medium))
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding()
                        
                     
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    
                }
                .frame(maxHeight:.infinity)
              
            }
            
        }
        .ignoresSafeArea(edges: .top)
        .onAppear {
            setupView()
            let currentHour = getCurrentHour()
            if currentHour >= 0 && currentHour < 11
            {
                session = "Good morning"
            }
            else if currentHour >= 11 && currentHour < 16
            {
                session = "Good afternoon"
            }
            else
            {
                session = "Good everning"
            }
        }
    }
}

struct TransactionItem: View
{
    @StateObject var vC: AppState = AppState.shared
    var data: ExpenseModel
    var body: some View
    {
        HStack
        {
            VStack
            {
                Image(data.category == "shopping" ? "shopping_icon" : (data.category == "hospital" ? "hospital_icon" : (data.category == "eat" ? "eat_icon" : (data.category == "fuel" ? "fuel_icon" : (data.category == "family" ? "family_icon" : (data.category == "travel" ? "travel_icon" : "other_icon"))))))
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 20, height: 20)
                   
            }
            .frame(width: 50, height: 50)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color(rgb: "#F0F6F5")))
            VStack(alignment: .leading, spacing: 6)
            {
                Text("\(data.name)")
                    .fontWeight(.medium)
                Text("\(data.date)")
                    .font(.system(size: 13))
                    .foregroundColor(Color(rgb: "#666666"))
                
                
            }
            Spacer()
            if(data.type == 1)
            {
                Text("+ \(data.amount)")
                    .font(.system(size: 18).weight(.semibold))
                    .foregroundColor(Color(rgb: "#25A969"))
            }
            else
            {
                Text("- \(data.amount)")
                    .font(.system(size: 18).weight(.semibold))
                    .foregroundColor(Color(rgb: "#F95B51"))
            }
        }
        .frame(maxWidth: .infinity)
        .contextMenu {
            Button {
                let ref = Database.database(url: "https://purtheo-exspense-default-rtdb.asia-southeast1.firebasedatabase.app").reference().child("\(vC.deviceID)/expense/\(data.id)")
                ref.setValue(nil)
                
            } label: {
                Label("Xoá", systemImage: "trash")
            }
        }
    }
}



struct NotiView: View
{
    @Binding var isShowNotiView: Bool
    var body: some View
    {
        ZStack
        {
            ZStack(alignment: .leading)
            {
                VStack
                {
                    Image("three-circle")
                        .opacity(0.06)
                }
                .frame(maxHeight: .infinity, alignment: .topLeading)
                VStack(spacing: 10)
                {
                    HStack
                    {
                        VStack(alignment: .leading,spacing: 10)
                        {
                            Button {
                                isShowNotiView = false
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 24).weight(.medium))
                            }

                        }
                     Spacer()

                    }
                    .padding(.horizontal, 20)
                    .padding(.top,80)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)

                    
                    Text("Notifications")
                        .foregroundColor(.white)
                        .padding(.vertical,10)
                        .padding(.horizontal, 20)
                        .font(.system(size: 30).weight(.semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    GeometryReader  {geo in
                        HStack
                        {
                            Spacer()
                            VStack
                            {
                                Text("Không có thông báo")
//                                    .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
                            }
                            .padding(20)
                            .frame(width: geo.size.width - 20, height: geo.size.height)
                            .background(.white)
                            .cornerRadius(40, corners: [.topLeft])
                           
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                
            }
            .background(
                Rectangle()
                    .fill(Color(rgb: "#59a8a2"))
            )
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)

    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
