import Foundation

struct ForecastResponse: Decodable {
    let city: City?
    let list: [ForecastItem]?
}
