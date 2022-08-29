//
//  TransactionListViewModel.swift
//  Read_bills
//
//  Created by chang xing on 23/08/2022.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionViewModel: ObservableObject{
    
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    
    func getTransactions() {
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://localhost:8080/Search_billsInfo.php")! as URL)
        request.httpMethod = "POST"
        let postString = "username=\(LocalState.username)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        /*
        let task = URLSession.shared.dataTask(with: request as URLRequest) { [self]
            data, response, error in
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
        }
        task.resume()
        
        
        guard let url = URL(string: "http://localhost:8080/bills_info.json") else {
            print("Invalid URL")
            return
        }
        */
        
        URLSession.shared.dataTaskPublisher(for: request as URLRequest )
            .tryMap{(data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print("Error fetching Bills info:", String(describing: error))
                case .finished:
                    print("Finished fetching Bills info")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
                dump(self?.transactions)
            }
            .store(in: &cancellables)
    }
    
    func groupTransactionsByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }
        
        let groupedTransactions = TransactionGroup(grouping: transactions) {$0.month}
        
        return groupedTransactions
    }
    
    func accumulateTransaction() -> TransactionPrefixSum{
        guard !transactions.isEmpty else {return []}
        let today = "09/09/2022".dateParsed()
            
        let timeinterval = Calendar.current.dateInterval(of: .year, for: today)!
        
        var sum : Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: timeinterval.start, to: today, by: 60*60*24) {
            let dailyExpenses = transactions.filter {$0.dateParsed == date && $0.isExpense}
            let dailyTotal = dailyExpenses.reduce(0) {$0 - $1.signedAmount}
            
            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cumulativeSum.append((date.formatted(), sum))
            
        }
        
        return cumulativeSum
    }
}
