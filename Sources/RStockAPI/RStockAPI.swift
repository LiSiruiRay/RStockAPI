import Foundation

public struct RStockAPI {
    public var baseURL = "http://127.0.0.1:5000"
    public var session = URLSession.shared
    public let jsonDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()

    public init() {
    }
    
    public func fetchChartData(symbol: String, range: ChartRange) async throws -> ChartData? {
        guard var urlComponents = URLComponents(string: "\(baseURL)/chart/\(symbol)") else { throw APIError.invalidURL }
        urlComponents.queryItems = [
            .init(name: "range", value: range.rawValue),
            .init(name: "interval", value: range.interval),
            .init(name: "indicators", value: "quote"),
            .init(name: "includTimestamps", value: "true")
        ]
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        let (response, statusCode): (ChartResponse, Int) = try await fetch(url: url)
        if let error = response.error {
            throw APIServiceError.httpStatusCodeFailed(statusCode: statusCode, error: error)
        }
        return response.data?.first
    }
    
    public func searchTickers(query: String, isEquityTypeOnly: Bool = true) async throws -> [Ticker] {
        guard let urlComponents = URLComponents(string: "\(baseURL)/search/\(query)") else { throw APIError.invalidURL }
//        urlComponents.queryItems = [.init(name: <#T##String#>, value: <#T##String?#>)]
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        let (response, statusCode): (SearchTickersResponse, Int) = try await fetch(url: url)
        if let error = response.error {
            throw APIServiceError.httpStatusCodeFailed(statusCode: statusCode, error: error)
        }
        let data = response.data ?? []
        if isEquityTypeOnly {
            return data.filter { ($0.quoteType ?? "").localizedCaseInsensitiveCompare("equity") == .orderedSame }
        } else {
            return data
        }
    }
    
    public func fetchQuotes(symbols: String) async throws -> [Quote] {
        guard let urlComponents = URLComponents(string: "\(baseURL)/test/quote/valid_quote") else { throw APIError.invalidURL }
//        urlComponents.queryItems = [.init(name: <#T##String#>, value: <#T##String?#>)]
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        let (response, statusCode): (QuoteResponse, Int) = try await fetch(url: url)
        if let error = response.error {
            throw APIServiceError.httpStatusCodeFailed(statusCode: statusCode, error: error)
        }
        return response.data ?? []
    }
    
    // TODO: ask GPT
    private func fetch<D: Decodable>(url: URL) async throws -> (D, Int) {
        let (data, response) = try await session.data(from: url)
        let statusCode = try validateHTTPResponse(response: response)
        return (try jsonDecoder.decode(D.self, from: data), statusCode)
    }
    
    private func validateHTTPResponse(response: URLResponse) throws -> Int {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIServiceError.invalidResponseType
        }
        
        guard 200...299 ~= httpResponse.statusCode ||
              400...499 ~= httpResponse.statusCode
        else {
            throw APIServiceError.httpStatusCodeFailed(statusCode: httpResponse.statusCode, error: nil)
        }
        
        return httpResponse.statusCode
    }
}
