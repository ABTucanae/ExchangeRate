//
//  CurrencyComparisonViewModel.swift
//  ExchangeRate
//
//  Created by Alex on 28/11/2021.
//

import Foundation

class CurrencyComparisonViewModel: ObservableObject {

    @Published var historicalRatesPresentationObjects = [HistoricalRatesPresentationObject]()

    var firstCurrencyTitle: String {
        assert(selectedCurrencies.count == 2)

        return selectedCurrencies[0].rawValue.uppercased()
    }

    var secondCurrencyTitle: String {
        assert(selectedCurrencies.count == 2)

        return selectedCurrencies[1].rawValue.uppercased()
    }

    let baseCurrencyValue: Double

    private let selectedCurrencies: [CurrencyCode]
    private let apiClient: APIClientProtocol

    init(baseCurrencyValue: Double, selectedCurrencies: [CurrencyCode], apiClient: APIClientProtocol = APIClient()) {
        self.baseCurrencyValue = baseCurrencyValue
        self.selectedCurrencies = selectedCurrencies
        self.apiClient = apiClient
    }

    /// Create an array of Dates spanning the last 5 days, including today
    private func createDateRange() -> [Date] {
        let now = Date()
        var listOfDates = [now]
        var dateComponents = Calendar.current.dateComponents([.day], from: now)

        for duration in 1..<5 {
            dateComponents.day = -duration

            if let date = Calendar.current.date(byAdding: dateComponents, to: now) {
                listOfDates.append(date)
            }
        }

        return listOfDates
    }

    func loadHistoricalRates() async {
        // Fetch the historical data for each day
        let historicalRates: [HistoricalRates] = await withTaskGroup(of: HistoricalRates?.self) { group in
            var historicalRates = [HistoricalRates]()

            for date in createDateRange() {
                group.addTask { [apiClient, selectedCurrencies] in
                    return await apiClient.loadHistoricalRates(for: date, selectedCurrencies: selectedCurrencies)
                }
            }

            for await historicalRate in group {
                if let rate = historicalRate {
                    historicalRates.append(rate)
                }
            }

            return historicalRates
        }

        await MainActor.run {
            historicalRatesPresentationObjects = createHistoricalPresentationObjects(for: historicalRates)
        }
    }

    func createHistoricalPresentationObjects(for historicalRates: [HistoricalRates]) -> [HistoricalRatesPresentationObject] {
        guard selectedCurrencies.count == 2 else { return [] }

        let sortedRates = historicalRates.sorted { first, second in
            first.date > second.date
        }

        return sortedRates.map { historicalRate in
            let firstCurrencyCode = selectedCurrencies[0]
            let secondCurrencyCode = selectedCurrencies[1]

            let firstCurrencyRate = historicalRate.rates[firstCurrencyCode.rawValue.uppercased()] ?? 0
            let secondCurrencyRate = historicalRate.rates[secondCurrencyCode.rawValue.uppercased()] ?? 0

            let firstCurrencyValue = baseCurrencyValue * firstCurrencyRate
            let secondCurrencyValue = baseCurrencyValue * secondCurrencyRate

            return HistoricalRatesPresentationObject(
                date: historicalRate.date,
                firstCurrencyValue: firstCurrencyValue,
                secondCurrencyValue: secondCurrencyValue,
                firstCurrency: firstCurrencyCode,
                secondCurrency: secondCurrencyCode
            )
        }
    }
}
