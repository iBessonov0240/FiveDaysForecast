import Foundation

final class APIManager {

    static let shared = APIManager()
    private let baseURL = "https://api.openweathermap.org/data/2.5/forecast"
    private let apiKey = "e8bbd8f5f7619142c9d029e8f07d00c8"

    func fetchForecast(for city: String) async throws -> ForecastResponse {

        guard var urlComponents = URLComponents(string: baseURL) else {
            throw URLError(.badURL)
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: apiKey)
        ]

        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let forecastResponse = try JSONDecoder().decode(ForecastResponse.self, from: data)

        return forecastResponse
    }
}
