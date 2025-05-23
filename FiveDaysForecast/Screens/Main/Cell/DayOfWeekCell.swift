import SwiftUI

struct DayOfWeekCell: View {

    // MARK: - Property

    let dayTitle: String
    let conditionText: String
    let conditionIcon: UIImage
    let windSpeed: String
    let humidity: Int
    let temperature: Int

    // MARK: - View

    var body: some View {
        HStack {
            Text(dayTitle)
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .semibold))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 0) {
                Text(conditionText)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black.opacity(0.7))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .padding(.bottom, 5)

                Image(uiImage: conditionIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: min(15, 25), height: min(15, 25))
                    .foregroundColor(.white)

                Spacer()
            }
            .padding(.leading)

            VStack(spacing: 0) {
                Text("Wind")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black.opacity(0.7))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .padding(.bottom, 5)

                Text(windSpeed)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)

                Spacer()
            }
            .padding([.leading, .trailing], 5)

            VStack(spacing: 0) {
                Text("Humidity")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black.opacity(0.7))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .padding(.bottom, 5)

                Text("\(humidity)")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)

                Spacer()
            }
            .padding(.trailing)

            Text("\(temperature)°")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .padding(.trailing)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.vertical, 10)
        .background(.blue.opacity(0.7))
    }
}

#Preview {
    DayOfWeekCell(dayTitle: "", conditionText: "", conditionIcon: UIImage(), windSpeed: "", humidity: 0, temperature: 0)
}
