//
//  BillsTracker.swift
//  Read_bills
//
//  Created by chang xing on 24/08/2022.
//

import SwiftUI
import Foundation

struct BillsTracker: View{
    
    @StateObject var transactionListVM = TransactionViewModel()
    
    var body: some View{
        Group{
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
