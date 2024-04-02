//
//  StatisticView.swift
//  Purtheo Expense
//
//  Created by Lê Ngọc Phương Đông on 20/03/2023.
//

import SwiftUI
import Charts
import BottomSheet
struct StatisticView: View {
    enum filterby
    {
        case day
        case week
        case month
        case year
    }
    enum statisticBy
    {
        case expense
        case income
    }
    @StateObject var vC = AppState.shared
    @State var currentFilter: filterby = .month
    @State var topSpendingData: [ExpenseModel] = []
    @State var statisticType: statisticBy = .expense
    @State var centerValue: Int = 0
    @State var totalBalance: Int = 0
    @State var isShowSheet = false
    @State var numberPickerMonth: Int = Calendar.current.component(.month, from: Date())
    
    
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    @State var alertButtonText: String = "OK"
    @State var alertIsShow: Bool = false
  
    var body: some View {
        
        GeometryReader { geo in
            
            VStack (spacing: 20)
            {
                HStack
                {
                    VStack(alignment: .leading,spacing: 10)
                    {
                        Button {
                            AppState.shared.current = .home
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color(rgb: "#222222"))
                                .font(.system(size: 24).weight(.medium))
                        }

                    }
                    Spacer()
                    
                    Text("Statistic")
                        .foregroundColor(Color(rgb: "#222222"))
                        .font(.system(size: 18).weight(.semibold))
                    
                    Spacer()
                }
                .padding(.vertical,10)
                .padding(.horizontal,12)
                .foregroundColor(.white)

                HStack
                {
                    Button {
                        alertTitle = "Thông báo"
                        alertMessage = "Hệ thống hiện chỉ cho phép filter theo tháng!"
                        alertIsShow = true
                    } label: {
                        VStack
                        {
                            Text("Day")
                                .font(.system(size: 13))
                        }
                        .padding(8)
                        .foregroundColor(Color(rgb: currentFilter == .day ? "#ffffff" : "#666666"))
                        .frame(width: geo.size.width / 5)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(rgb: currentFilter == .day ? "#438883" : "#ffffff"))
                        )
                    }
                    
                    Button {
                        alertTitle = "Thông báo"
                        alertMessage = "Hệ thống hiện chỉ cho phép filter theo tháng!"
                        alertIsShow = true
                    } label: {
                        VStack
                        {
                            Text("Week")
                                .font(.system(size: 13))
                        }
                        .padding(8)
                        .foregroundColor(Color(rgb: currentFilter == .week ? "#ffffff" : "#666666"))
                        .frame(width: geo.size.width / 5)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(rgb: currentFilter == .week ? "#438883" : "#ffffff"))
                        )
                    }
                    
                    Button {
                        currentFilter = .month
                        isShowSheet.toggle()
                    } label: {
                        VStack
                        {
                            Text("Month")
                                .font(.system(size: 13))
                        }
                        .padding(8)
                        .foregroundColor(Color(rgb: currentFilter == .month ? "#ffffff" : "#666666"))
                        .frame(width: geo.size.width / 5)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(rgb: currentFilter == .month ? "#438883" : "#ffffff"))
                        )
                    }

                    Button {
                        alertTitle = "Thông báo"
                        alertMessage = "Hệ thống hiện chỉ cho phép filter theo tháng!"
                        alertIsShow = true
                    } label: {
                        VStack
                        {
                            Text("Year")
                                .font(.system(size: 13))
                        }
                        .padding(8)
                        .foregroundColor(Color(rgb: currentFilter == .year ? "#ffffff" : "#666666"))
                        .frame(width: geo.size.width / 5)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(rgb: currentFilter == .year ? "#438883" : "#ffffff"))
                        )
                    }
                }

                
                HStack
                {
                    
                    HStack(spacing: 4)
                    {
                        Text("Balance:")
                            .foregroundColor(Color(rgb: "#666"))
                            .font(.system(size: 16).weight(.medium))
                        
                        if(totalBalance > 0)
                        {
                            Text("\(totalBalance)")
                                .foregroundColor(Color(rgb: "#25A969"))
                                .font(.system(size: 16).weight(.semibold))
                        }
                        else if totalBalance < 0
                        {
                            Text("\(totalBalance)")
                                .font(.system(size: 16).weight(.semibold))
                                .foregroundColor(Color(rgb: "#F95B51"))
                        }
                        else
                        {
                            Text("\(totalBalance)")
                                .font(.system(size: 16).weight(.semibold))
                                .foregroundColor(Color(rgb: "#666"))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .layoutPriority(1)

                    
                    Menu {
                        
                        Button {
                            statisticType = .expense
                            setupView()
                        } label: {
                            Text("Expense")
                        }
                        
                        Button {
                            statisticType = .income
                            setupView()
                        } label: {
                            Text("Income")
                        }

                        
                    }label: {
                        HStack
                        {
                            Text("\(statisticType == .expense ? "Expense" : "Income")")
                            Spacer()
                            Image(systemName: "chevron.down")
                        }
                        .padding(.horizontal, 8)
                        .foregroundColor(Color(rgb: "#666666"))
                        .font(.system(size: 14).weight(.medium))
                        .frame(width: 120, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(rgb: "#666666"))
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)

                }
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity)

            

//                MyLineChartView(dataEntries: dataEntries)
//                    .frame(width: geo.size.width, height: 200)
                PieChart(entries: Statistic.entriesForExpense(Statistic.allexpense, type: statisticType == .expense ? 2 : 1), type: statisticType == .expense ? 2 : 1, centerValue: centerValue)
                    .frame(width: geo.size.width, height: 250)
                
               
                Text("Top Spending")
                    .font(.system(size: 18).weight(.semibold))
                    .foregroundColor(Color(rgb: "#222222"))
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal, 8)
                
 
                ScrollView(showsIndicators: false)
                {
                    ForEach(topSpendingData.sorted(by: { element1, element2 in
                        element1.amount > element2.amount
                    }),id: \.id) {spending in
                        TopspendingView(spending: spending)
                    }
                }
                .padding(.horizontal,8)

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
                    .frame(width: geo.size.width / 4 - 6, height: 28, alignment: .center)
                    
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
                    .frame(width: geo.size.width / 4 - 6, height: 28, alignment: .center)
                   
                    Button(action: {
                        vC.current = .story
                    }, label: {
                        
                        if vC.current == .story
                        {
                            Image("walet-fill")
                                .resizable()
                                .frame(width: 30,height: 30)
                        }
                        else
                        {
                            Image("walet")
                                .resizable()
                                .frame(width: 30,height: 30)
                        }
                    })
                    .frame(width: geo.size.width / 4 - 6, height: 28, alignment: .center)
                   
                    
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
                    .frame(width: geo.size.width / 4 - 6, height: 28, alignment: .center)
                   
                }
                .padding(.top,2)
                .background(
                    Rectangle()
                        .fill(Color.clear)
                        .frame(maxWidth:.infinity, maxHeight: .infinity)
                        .shadow(color: .black, radius: 5, x: 0, y: -20)
                    
                )
                .frame(alignment: .bottom)


            }
            .bottomSheet(isPresented: $isShowSheet,detents: [.medium()]) {
                VStack
                {
                    GeometryReader {geo in
                        ZStack
                        {
                            HStack
                            {
                                Text("Statistic Filter")
                                    .font(.system(size: 20).weight(.medium))
                                    .foregroundColor(Color(rgb: "#333333"))
                                Spacer()
                                Button {
                                    vC.selectedFilterMonth = numberPickerMonth
                                    isShowSheet.toggle()
                                    setupView()
                                } label: {
                                    Text("OK")
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                            .padding(18)

                            VStack
                            {
                                Text("Filter by Month")
                                   .font(.system(size: 20).weight(.medium))
                                   .foregroundColor(Color(rgb: "#333333"))
                                Picker("Selected Month", selection: $numberPickerMonth)
                               {
                                   ForEach(1...12,id: \.self) {item in
                                       Text("Tháng \(item)")
                                           .foregroundColor(.black)
                                   }
                               }
                               .pickerStyle(.wheel)
                               .foregroundColor(.black)
                               .frame(width: geo.size.width - 100, alignment: .center)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white)
            }
            
        }
        .padding(.horizontal,8)
        .onAppear
        {
            setupView()
        }
        .onDisappear
        {
            vC.selectedFilterMonth = Calendar.current.component(.month, from: Date())
        }
        .alert(isPresented: $alertIsShow) {
            Alert(
                title: Text("\(alertTitle)"),
                message: Text("\(alertMessage)"),
                dismissButton: .default(Text("OK"), action: {
                    alertIsShow = false
                })
            )
        }
    }
}


struct PieChart: UIViewRepresentable
{
    let entries: [PieChartDataEntry]
    let pieChart: PieChartView = PieChartView()
    let type: Int
    let centerValue: Int
    func makeUIView(context: Context) -> PieChartView {
        pieChart.delegate = context.coordinator
        return pieChart
    }
    func updateUIView(_ uiView: PieChartView, context: Context) {
        let dataSet = PieChartDataSet(entries: entries)
        dataSet.colors = [Color(rgb: "#27523e").toUIColor(),Color(rgb: "#fbcd07").toUIColor(),Color(rgb: "#f7901e").toUIColor(),Color(rgb: "#ef5623").toUIColor(),Color(rgb: "#2ab3d4").toUIColor(),Color(rgb: "#1c907e").toUIColor(),Color(rgb: "#3f66b0").toUIColor()]
        dataSet.drawValuesEnabled = false
        dataSet.label = ""
        let pieChartData = PieChartData(dataSet: dataSet)
        uiView.data = pieChartData
        uiView.rotationEnabled = false
        uiView.animate(xAxisDuration: 0.5, easingOption: .easeInCirc)
        uiView.drawEntryLabelsEnabled = false
        uiView.highlightValue(x: -1, dataSetIndex: 0,callDelegate: false)
        if type == 1
        {
            uiView.centerText = "Income\n\(centerValue.formatVND())"
        }
        else
        {
            uiView.centerText = "Expense\n\(centerValue.formatVND())"
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    class Coordinator: NSObject,ChartViewDelegate
    {
        var parent: PieChart
        init(parent:PieChart)
        {
            self.parent = parent
        }
        
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            let label = entry.value(forKey: "label")! as! String
            let num = Int(entry.value(forKey: "value")! as! Double)
            parent.pieChart.centerText = "\(label)\n\(num.formatVND())"
        }
    }
}


struct TopspendingView: View
{
    var spending: ExpenseModel
    var body: some View
    {
        VStack
        {
            HStack
            {
                VStack
                {
                    Image(spending.category == "shopping" ? "shopping_icon" : (spending.category == "hospital" ? "hospital_icon" : (spending.category == "eat" ? "eat_icon" : (spending.category == "fuel" ? "fuel_icon" : (spending.category == "family" ? "family_icon" : (spending.category == "travel" ? "travel_icon" : "other_icon"))))))
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 20, height: 20)
                }
                .frame(width: 50, height: 50)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color(rgb: "#F0F6F5")))
                VStack(alignment: .leading, spacing: 6)
                {
                    Text("\(spending.name)")
                        .fontWeight(.medium)
                    Text("\(spending.date)")
                        .font(.system(size: 13))
                        .foregroundColor(Color(rgb: "#666666"))
                    
                    
                }
                Spacer()
                if(spending.type == 1)
                {
                    Text("+ \(spending.amount)")
                        .font(.system(size: 18).weight(.semibold))
                        .foregroundColor(Color(rgb: "#25A969"))
                }
                else
                {
                    Text("- \(spending.amount)")
                        .font(.system(size: 18).weight(.semibold))
                        .foregroundColor(Color(rgb: "#F95B51"))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(rgb: "#FBFBFB"))
            )
            
        }
    }
}


struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView()
    }
}
