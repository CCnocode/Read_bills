//
//  RecentTransactionList.swift
//  Read_bills
//
//  Created by chang xing on 23/08/2022.
//

import Foundation
import SwiftUI

struct RecentTransactionList: View{
    
    @EnvironmentObject var transactionListVM: TransactionViewModel
    
    var body: some View {
        VStack{
            HStack{
                //Header
                Text("Recent Transactions")
                    .bold()
                
                Spacer()
                
                NavigationLink{
                    TransactionList()
                }label: {
                    HStack(spacing: 4){
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                
                }
            }
            .padding(.top)
            
            //Recent Transaction List
            ForEach(Array(transactionListVM.transactions.prefix(5).enumerated()), id:\.element) { index, transaction in
                TransactionRow(transaction: transaction)
                
                Divider()
                    .opacity(index == 4 ? 0:1)
            
            }
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style:  .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}
