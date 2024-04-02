//
//  DetailView.swift
//  Purtheo Expense
//
//  Created by Lê Ngọc Phương Đông on 19/03/2023.
//

import SwiftUI
import FirebaseDatabase

struct AddExpenseView: View {

    enum categories
    {
        case shopping
        case hospital
        case eat
        case fuel
        case family
        case travel
        case none
    }
    
    @StateObject var vC: AppState = AppState.shared
    
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    @State var alertButtonText: String = "OK"
    @State var alertIsShow: Bool = false
  
    @State var amount: String = ""
    @State var name: String = ""
    @State var expense_type = 0
    @State var note: String = ""
    @State var showDatePicker: Bool = false
    @State var selectedDate: Date = Date()
    @State var selectedDateText: String = ""
    @State var isAddOK : Bool = false
    @State var selectedCategories: categories = .none
    
    var body: some View {
        ZStack
        {
            GeometryReader { geo in
                VStack (spacing: 0)
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
                            HStack
                            {
                                VStack(alignment: .leading,spacing: 10)
                                {
                                    Button {
                                        AppState.shared.current = .home
                                    } label: {
                                        Image(systemName: "chevron.left")
                                            .font(.system(size: 24).weight(.medium))
//                                            .frame(width: 28, height: 28)
                                    }

                                }
                                Spacer()
                                
                                Text("Add Expense")
                                    .font(.system(size: 18).weight(.semibold))
                                
                                Spacer()
                                
                                Button {
                                    
                                } label: {
                                    ZStack
                                    {
                                        Image(systemName: "ellipsis")
                                            .resizable()
                                            .frame(width: 26,height: 6)
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
                    }
                    .frame(width: geo.size.width, height: geo.size.height / 3)
                    
                    VStack
                     {
                         VStack(alignment: .leading)
                         {
                             VStack(alignment: .leading,spacing: 20)
                             {
                                 VStack(alignment: .leading,spacing: 10)
                                 {
                                     
                                        Text("TYPE")
                                             .font(.system(size: 12).weight(.medium))
                                             .tracking(2)
                                         Menu{
                                             
                                             Button {
                                                 expense_type = 1
                                             } label: {
                                                 Text("Thu")
                                             }
                                             Button {
                                                 expense_type = 2
                                             } label: {
                                                 Text("Chi")
                                             }
                                         }label: {
                                             HStack
                                             {
                                                 Text("\(expense_type == 1 ? "Thu" : expense_type == 2 ? "Chi" : "Loại chi tiêu")")
                                                     .font(.system(size: 14).weight(.medium))
                                                 Spacer()
                                                 Image(systemName: "chevron.down")
                                                     .foregroundColor(Color(rgb: "#888888"))
                                                     .font(.system(size: 14).weight(.medium))

                                             }
                                         }
                                         .font(.system(size: 14))
                                         .padding(14)
                                         .frame(maxWidth: .infinity, alignment: .leading)
                                         .background(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color(rgb: "#DDDDDD"))
                                         )
                                 }
                                 VStack(alignment: .leading,spacing: 10)
                                 {
                                     
                                        Text("NAME")
                                             .font(.system(size: 12).weight(.medium))
                                             .tracking(2)
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
                                                .stroke(Color(rgb: "#DDDDDD"))
                                         )
                                 }
                                 VStack(alignment: .leading,spacing: 10)
                                 {
                                      Text("AMOUNT")
                                           .font(.system(size: 12).weight(.medium))
                                           .tracking(2)
                                      HStack
                                      {
                                         TextField("",text: $amount)
                                              .keyboardType(.numberPad)
                                              .font(.system(size: 14).weight(.semibold))
                                    
                                          Spacer()
                                          if amount != ""
                                          {
                                              Button {
                                                  amount = ""
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
                                              .stroke(Color(rgb: "#DDDDDD"))
                                       )
                                 }
                                 
                                 VStack(alignment: .leading,spacing: 10)
                                 {
                                     Text("DATE")
                                           .font(.system(size: 12).weight(.medium))
                                           .tracking(2)
                                     Button {
                                         showDatePicker.toggle()
                                     } label: {
                                         HStack
                                         {
                                             Text("\(selectedDateText)")
                                                 .font(.system(size: 14).weight(.medium))
                                             Spacer()
                                             Image(systemName: "calendar")
                                                  .foregroundColor(Color(rgb: "#888888"))
                                                  .font(.system(size: 14).weight(.medium))

                                         }
                                          .padding(14)
                                          .frame(maxWidth: .infinity, alignment: .leading)
                                          .background(
                                             RoundedRectangle(cornerRadius: 5)
                                                 .stroke(Color(rgb: "#DDDDDD"))
                                          )
                                     }

                                 }
                                 
                                 
                                 
                                 VStack(alignment: .leading,spacing: 10)
                                 {
                                      Text("CATEGORIES")
                                           .font(.system(size: 12).weight(.medium))
                                           .tracking(2)
                                      HStack
                                      {
                                          ScrollView(.horizontal,showsIndicators: false)
                                          {
                                             HStack
                                              {
                                                  Button {
                                                      if selectedCategories == .shopping
                                                      {
                                                          selectedCategories = .none
                                                      }
                                                      else
                                                      {
                                                          selectedCategories = .shopping
                                                      }
                                                  } label: {
                                                      VStack{
                                                          Image("shopping_icon")
                                                              .resizable()
                                                              .renderingMode(.original)
                                                              .frame(width: 20,height: 20)
                                                      }
                                                      .frame(width: 40,height: 40)
                                                      .background(RoundedRectangle(cornerRadius: 5).fill(Color(rgb: selectedCategories == .shopping ? "#29756F" : "#cccccc")))
                                                  }
                                                  
                                                  Button {
                                                      if selectedCategories == .hospital
                                                      {
                                                          selectedCategories = .none
                                                      }
                                                      else
                                                      {
                                                          selectedCategories = .hospital
                                                      }
                                                  } label: {
                                                     
                                                      VStack
                                                      {
                                                          Image("hospital_icon")
                                                              .resizable()
                                                              .renderingMode(.original)
                                                              .frame(width: 20,height: 20)
                                                      }
                                                      .frame(width: 40,height: 40)
                                                      .background(RoundedRectangle(cornerRadius: 5).fill(Color(rgb: selectedCategories == .hospital ? "#29756F" : "#cccccc")))
                                                  }
                                                  
                                                  Button {
                                                      if selectedCategories == .eat
                                                      {
                                                          selectedCategories = .none
                                                      }
                                                      else
                                                      {
                                                          selectedCategories = .eat
                                                      }
                                                  } label: {
                                                      VStack
                                                      {
                                                          Image("eat_icon")
                                                              .resizable()
                                                              .renderingMode(.original)
                                                              .frame(width: 20,height: 20)
                                                      }
                                                      .frame(width: 40,height: 40)
                                                      .background(RoundedRectangle(cornerRadius: 5).fill(Color(rgb: selectedCategories == .eat ? "#29756F" : "#cccccc")))
                                                  }
                                                  
                                                  Button {
                                                      if selectedCategories == .fuel
                                                      {
                                                          selectedCategories = .none
                                                      }
                                                      else
                                                      {
                                                          selectedCategories = .fuel
                                                      }
                                                  } label: {
                                                      VStack
                                                      {
                                                          Image("fuel_icon")
                                                              .resizable()
                                                              .renderingMode(.original)
        //                                                      .foregroundColor(.white)
                                                              .frame(width: 20,height: 20)
                                                      }
                                                      .frame(width: 40,height: 40)
                                                      .background(RoundedRectangle(cornerRadius: 5).fill(Color(rgb: selectedCategories == .fuel ? "#29756F" : "#cccccc")))
                                                  }

                                                  
                                                  Button {
                                                      if selectedCategories == .family
                                                      {
                                                          selectedCategories = .none
                                                      }
                                                      else
                                                      {
                                                          selectedCategories = .family
                                                      }
                                                  } label: {
                                                      VStack
                                                      {
                                                          Image("family_icon")
                                                              .resizable()
                                                              .renderingMode(.original)
                                                              .frame(width: 20,height: 20)
                                                      }
                                                      .frame(width: 40,height: 40)
                                                      .background(RoundedRectangle(cornerRadius: 5).fill(Color(rgb: selectedCategories == .family ? "#29756F" : "#cccccc")))
                                                  }
                                                  
                                                  Button {
                                                      if selectedCategories == .travel
                                                      {
                                                          selectedCategories = .none
                                                      }
                                                      else
                                                      {
                                                          selectedCategories = .travel
                                                      }
                                                  } label: {
                                                      VStack
                                                      {
                                                          Image("travel_icon")
                                                              .resizable()
                                                              .renderingMode(.original)
                                                              .frame(width: 20,height: 20)
                                                      }
                                                      .frame(width: 40,height: 40)
                                                      .background(RoundedRectangle(cornerRadius: 5).fill(Color(rgb: selectedCategories == .travel ? "#29756F" : "#cccccc")))
                                                  }
                                              }

                                          }
                                      }
                                       .padding(14)
                                       .frame(maxWidth: .infinity, alignment: .leading)
                                       .background(
                                          RoundedRectangle(cornerRadius: 5)
                                              .stroke(Color(rgb: "#DDDDDD"))
                                       )
                                 }
                                 
                                 
                                 VStack
                                 {
                                     Button {
                                         if expense_type == 0 || name == "" || amount == "" || selectedDateText == ""
                                         {
                                             alertTitle = "Thông báo"
                                             alertMessage = "Vui lòng nhập đầy đủ thông tin!"
                                             alertIsShow = true
                                         }
                                         else
                                         {
                                             addExpense()
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

                                       
                                 }
                                 
                             }
                             .frame(maxWidth: .infinity,alignment: .leading)
                             .foregroundColor(Color(rgb: "#666666"))
                         }
                         .padding()
                         .foregroundColor(.white)
                         .frame(maxWidth: .infinity)
                         .background(
                             RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                         )
                         .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 0)
                         .padding(.horizontal,20)
                         
                     }
                     .frame(maxWidth:.infinity, maxHeight: .infinity,alignment: .top)
                     .offset(y: -120)
                     .onTapGesture {
                         UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                     }

                }
                
                if showDatePicker
                {
                    DatePickerView(datetime: $selectedDate, showPicker: $showDatePicker, selectedDateText: $selectedDateText)
                }
            }
        }
        .alert(isPresented: $alertIsShow) {
                    Alert(
                        title: Text("\(alertTitle)"),
                        message: Text("\(alertMessage)"),
                        dismissButton: .default(Text("OK"), action: {
                            if isAddOK
                            {
                                vC.current = .home
                                alertIsShow = false
                            }
                            else
                            {
                                alertIsShow = false
                            }
                            
                        })
                    )
        }
        .background(Color(rgb: "#fefefe"))
        .ignoresSafeArea(edges: .top)
        

    }
    
    func addExpense()
    {
        let ref = Database.database(url: "https://purtheo-exspense-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
        let category = selectedCategories == .shopping ? "shopping" : (selectedCategories == .hospital ? "hospital" : (selectedCategories == .fuel ? "fuel" : (selectedCategories == .family ? "family" : (selectedCategories == .travel ? "travel" : (selectedCategories == .eat ? "eat" : "khác")))))
        
        //Lấy format đến mili giây để làm key
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyyHHmmssSSSS"
        let formattedDate = dateFormatter.string(from: Date())
        
        let generateObject = ExpenseModel(id: formattedDate,name: name, amount: Int(amount) ?? 0, type: expense_type, date: selectedDateText, category: category)
        guard let data = try? JSONEncoder().encode(generateObject) else {
            return
        }

        let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] ?? [:]

        
        ref.child("\(vC.deviceID)/expense/\(String(describing: generateObject.id))").setValue(json) { error, ref in
            if let error = error {
                isAddOK = false
                alertTitle = "Lỗi"
                alertMessage = "\(error.localizedDescription)"
                alertIsShow = true
            } else {
                isAddOK = true
                alertTitle = "Thông báo"
                alertMessage = "Đã thêm thành công"
                alertIsShow = true
            }
        }
    }
}
