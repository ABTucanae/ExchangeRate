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

    var dateFormat: Date.ISO8601FormatStyle {
        .iso8601.year().month().day().dateSeparator(.dash)
    }

    func getLatestRates() async -> LatestExchangeRates? {
        let endpoint = "\(baseUrl)latest"

        guard var urlComponents = URLComponents(string: endpoint) else { return nil }

        urlComponents.queryItems = createQueryItems(including: CurrencyCode.allowedCurrencies)

        guard let url = urlComponents.url else { return nil }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(LatestExchangeRates.self, from: data)
        } catch {
            print(#function, error)
            return nil
        }
    }

    func loadHistoricalRates(for date: Date, selectedCurrencies: [CurrencyCode]) async -> HistoricalRates? {
        let endpoint = "\(baseUrl)\(date.formatted(dateFormat))"

        guard var urlComponents = URLComponents(string: endpoint) else { return nil }

        urlComponents.queryItems = createQueryItems(including: selectedCurrencies)

        guard let url = urlComponents.url else { return nil }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(HistoricalRates.self, from: data)
        } catch {
            print(#function, error)
            return nil
        }
    }

    private func createQueryItems(including currencyCodes: [CurrencyCode]) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()

        queryItems.append(.init(name: "access_key", value: apiKey))
        queryItems.append(.init(name: "base", value: CurrencyCode.baseCurrency.rawValue.uppercased()))
        let symbolsList = currencyCodes.map({ $0.rawValue.uppercased() }).joined(separator: ",")
        queryItems.append(.init(name: "symbols", value: symbolsList))

        return queryItems
    }
}
