import Foundation
import UIKit

final class MainViewModel: ObservableObject {

// MARK: - Properties

    @Published var temperature: Int = 0
    @Published var searchText: String = ""
    @Published var cityName: String = ""

    @Published var fiveDayForecast: [FiveDayForecastModel] = []

// MARK: - Functions

    @MainActor
    func fetchWeather() async {
        do {
            let weatherResponse = try await APIManager.shared.fetchForecast(for: searchText)
            if let firstWeather = weatherResponse.list?.first {
                self.cityName = weatherResponse.city?.name ?? ""
                self.temperature = Int((firstWeather.main?.temp ?? 273.15) - 273.15)
                self.searchText = ""

                self.fiveDayForecast = await extractFiveDayForecast(from: weatherResponse.list ?? [])
            }
        } catch {
            print("Error fetching weather: \(error)")
        }
    }

    private func extractFiveDayForecast(from list: [ForecastItem]) async -> [FiveDayForecastModel] {
        var seenDates: Set<String> = []
        var dailyForecast: [FiveDayForecastModel] = []

        for item in list {
            guard let dateText = item.dtTxt else { continue }

            let day = String(dateText.prefix(10))

            if !seenDates.contains(day) {
                seenDates.insert(day)

                var icon = UIImage()

                if let iconCode = item.weather?.first?.icon {
                    do {
                        let urlString = "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
                        if let url = URL(string: urlString) {
                            let (data, _) = try await URLSession.shared.data(from: url)
                            icon = UIImage(data: data) ?? UIImage()
                        }
                    } catch {
                        print("error")
                    }
                }

                let model = FiveDayForecastModel(
                    date: dateText,
                    conditionText: item.weather?.first?.main ?? "Unknown",
                    conditionIcon: icon,
                    temperature: Int((item.main?.temp ?? 273.15) - 273.15),
                    windSpeed: String(format: "%.1f", item.wind?.speed ?? 0),
                    humidity: item.main?.humidity ?? 0
                )

                dailyForecast.append(model)

                if dailyForecast.count == 5 { break }
            }
        }

        return dailyForecast
    }

    func getDayOfWeek(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        guard let date = dateFormatter.date(from: dateString) else {
            return "Unknown"
        }

        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Today"
        }

        let weekdayFormatter = DateFormatter()
        weekdayFormatter.dateFormat = "EEEE"
        return weekdayFormatter.string(from: date)
    }
}
