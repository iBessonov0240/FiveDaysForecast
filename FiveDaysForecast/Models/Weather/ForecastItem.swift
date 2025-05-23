import Foundation

struct ForecastItem: Decodable {
    let main: ForecastMain?
    let wind: ForecastWind?
    let weather: [ForecastCondition]?
    let dtTxt: String?

    private enum CodingKeys: String, CodingKey {
        case main, wind, weather
        case dtTxt = "dt_txt"
    }
}
