//
//  APIClient.swift
//  ExchangeRate
//
//  Created by Alex on 28/11/2021.
//

import Foundation

class APIClient: APIClientProtocol {

    private var baseUrl: String {
        guard let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            assertionFailure("Base URL is missing from build configuration")
            return ""
        }

        return baseUrl
    }

    private var apiKey: String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            assertionFailure("API key is missing from build configuration")
            return ""
        }

        return apiKey
    }

    func getLatestRates() async -> LatestExchangeRate? {
        let endpoint = "\(baseUrl)latest"

        guard var urlComponents = URLComponents(string: endpoint) else { return nil }

        var queryItems = [URLQueryItem]()
        queryItems.append(.init(name: "access_key", value: apiKey))
        queryItems.append(.init(name: "base", value: CurrencyCode.baseCurrency.rawValue.uppercased()))

        let symbolsList = CurrencyCode.allowedCurrencies.map({ $0.rawValue }).joined(separator: ",")
        queryItems.append(.init(name: "symbols", value: symbolsList))

        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else { return nil }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(LatestExchangeRate.self, from: data)
        } catch {
            return nil
        }
    }
}
