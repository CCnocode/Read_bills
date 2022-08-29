//
//  TransactionList.swift
//  Read_bills
//
//  Created by chang xing on 24/08/2022.
//

import Foundation

import SwiftUI

struct TransactionList: View{
    
    @EnvironmentObject var transactionListVM: TransactionViewModel
    
    var body: some View{
        VStack{
            List{
                //
                ForEach(Array(transactionListVM.groupTransactionsByMonth()), id: \.key) {month, transactions in
                    Section{
                        ForEach(transactions){ transaction in
                            TransactionRow(transaction: transaction)
                        }
                    }header: {
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}
