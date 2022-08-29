//
//  PreviewData.swift
//  Read_bills
//
//  Created by chang xing on 23/08/2022.
//

import Foundation
import Swift

var transactionPreviewData = Transaction(id:1, date: "01/24/2022", merchant: "Apple", amount: 11.49, type: "pay", categoryID: 103, category: "Electric", isExpense: true)

var transactionListPreViewData = [Transaction](repeating: transactionPreviewData, count: 10)
