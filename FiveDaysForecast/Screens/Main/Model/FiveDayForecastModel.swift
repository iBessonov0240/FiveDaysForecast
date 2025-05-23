import Foundation
import UIKit

struct FiveDayForecastModel: Identifiable {
    let id = UUID()
    let date: String
    let conditionText: String
    let conditionIcon: UIImage
    let temperature: Int
    let windSpeed: String
    let humidity: Int
}
