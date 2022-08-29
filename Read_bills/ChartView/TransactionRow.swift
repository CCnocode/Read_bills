//
//  TransactionRow.swift
//  Read_bills
//
//  Created by chang xing on 23/08/2022.
//

import SwiftUI
import Charts
import SwiftUIFontIcon

struct TransactionRow: View{
    var transaction: Transaction
    
    var body: some View{
        HStack(spacing: 20){
            //make icon
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.icon.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay{
                    FontIcon.text(.awesome5Solid(code: transaction.icon), fontsize: 24, color: Color.icon)
                }
            
            VStack(alignment: .leading, spacing: 6) {
                //marchant
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                //Date
                Text(transaction.dateParsed, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
            //Amount
            Text(transaction.signedAmount, format: .currency(code: "GBP"))
                .bold()
                .foregroundColor(transaction.type == TransactionType.receive.rawValue ? Color.text : .primary)
        }
        .padding([.top, .bottom], 8)
    }
}
