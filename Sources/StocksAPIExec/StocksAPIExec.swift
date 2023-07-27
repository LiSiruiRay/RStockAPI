//
//  File.swift
//  
//
//  Created by Ray on 7/26/23.
//

import Foundation
import RStockAPI

@main
struct XCAStocksExec {
    
//    private static let api = XCAStocksAPI()
    static let stockAPI = RStockAPI()
    static func main() async {
//        print(RStockAPI().text)
//        let (data, _) = try! await URLSession.shared.data(from: URL(string: "http://127.0.0.1:5000/test/quote/invalid_quote")!)
//
//        let quoteResponse = try! JSONDecoder().decode(QuoteResponse.self, from: data)
//        print(quoteResponse)
//        let (data, _) = try! await URLSession.shared.data(from: URL(string: "http://127.0.0.1:5000/search/MSFT")!)
//
//        let tickerResponse = try! JSONDecoder().decode(SearchTickersResponse.self, from: data)
//        print(tickerResponse)
//        let (data, _) = try! await URLSession.shared.data(from: URL(string: "http://127.0.0.1:5000/chart/MSFT")!)
//
//        let chartResponse = try! JSONDecoder().decode(ChartResponse.self, from: data)
//        print(chartResponse)
        
        do {
//            let quotes = try await stockAPI.fetchQuotes(symbols: "APPL")
//            print(quotes)
            
//            let tickers = try await stockAPI.searchTickers(query: "tesla")
//            print(tickers)
            if let chart = try await stockAPI.fetchChartData(symbol: "AAPL", range: .oneDay) {
                print(chart)
            }
//            print(tickers)
        } catch {
            print(error.localizedDescription)
        }
        
//        do {
//            // Fetch AAPL stocks last 1 day
//            let apple1dChart = try await api
//                .fetchChartData(tickerSymbol: "AAPL", range: .oneDay)
//
//            print(apple1dChart ?? "Not Found")
//
//            // Search Ticker using "TESLA" as Query
//            let tickers = try await api
//                .searchTickers(query: "TESLA")
//            print(tickers)
//
//            // Fetch Quote Detail for multiple symbols
//            // AAPL, TSLA, GOOG, MSFT
//            let quotes = try await api
//                .fetchQuotes(symbols: "AAPL,TSLA,GOOG,MSFT")
//            print(quotes)
//
//        } catch {
//            print(error.localizedDescription)
//        }
    }
}
