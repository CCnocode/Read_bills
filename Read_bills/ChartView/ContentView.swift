//
//  ContentView.swift
//  Read_bills
//
//  Created by chang xing on 23/08/2022.
//

import Foundation
import SwiftUI
import SwiftUICharts

struct ContentView:View{
    
    @State private var isDarkMode = false
    
    @EnvironmentObject var transactionListVm: TransactionViewModel
    
    var body: some View{
        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 24){
                    Text("OverView")
                        .font(.title2)
                        .bold()
                    
                    //chart
                    let data = transactionListVm.accumulateTransaction()
                    
                    if !data.isEmpty{
                        let totalExpense = data.last?.1 ?? 0
                        CardView{
                            VStack(alignment: .leading){
                                ChartLabel(totalExpense.formatted(.currency(code: "GBP")), type:  .title, format: "£%.02f")
                                LineChart()
                            }
                            .background(Color.systemBackground)

                        }
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                        .frame(height: 320)
                    }
                    //Bills list
                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                //make notifacation icon
                ToolbarItem{
                    Button(action: {
                        transactionListVm.getTransactions()
                    }, label:{
                        Image(systemName: "arrow.clockwise")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon, .primary)
                    })
                    .preferredColorScheme(isDarkMode ? .dark : .light)
                }
            }
        }
        .navigationViewStyle(.stack)
        //.accentColor(.primary)
    }
}
