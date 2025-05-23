import SwiftUI

struct Main: View {

// MARK: - Properties

    @StateObject private var viewModel = MainViewModel()

// MARK: - View

    var body: some View {
        ZStack {
            Image("cloud")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()

            VStack {
                Text(viewModel.cityName.isEmpty ? "City" : viewModel.cityName)
                    .font(.system(size: 40, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.top, 25)

                Text("\(viewModel.temperature)°C")
                    .font(.system(size: 55, weight: .light))
                    .foregroundColor(.white)
                    .padding(.top, 10)

                TextField("", text: $viewModel.searchText)
                    .padding(.vertical, 10)
                    .padding(.leading, 40)
                    .background(.gray.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .overlay {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.leading, 10)

                            if viewModel.searchText.isEmpty {
                                Text("Search for a city")
                                    .foregroundColor(.white.opacity(0.3))
                                    .padding(.leading, 5)
                            }

                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 25)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()

                            Button {
                                Task {
                                    await viewModel.fetchWeather()
                                }
                                UIApplication.shared.sendAction(
                                    #selector(UIResponder.resignFirstResponder),
                                    to: nil,
                                    from: nil,
                                    for: nil
                                )
                            } label: {
                                Text("Done")
                                    .foregroundStyle(Color.blue)
                            }
                        }
                    }

                List(viewModel.fiveDayForecast) { day in
                    DayOfWeekCell(
                        dayTitle: viewModel.getDayOfWeek(from: day.date),
                        conditionText: day.conditionText,
                        conditionIcon: day.conditionIcon,
                        windSpeed: day.windSpeed,
                        humidity: day.humidity,
                        temperature: day.temperature
                    )
                    .listRowInsets(EdgeInsets())
                }
                .scrollContentBackground(.hidden)
                .padding(.top, 5)
                .scrollIndicators(.hidden)
                .listStyle(.insetGrouped)
            }
            .frame(maxWidth: UIScreen.main.bounds.width)
        }
    }
}

#Preview {
    Main()
}
