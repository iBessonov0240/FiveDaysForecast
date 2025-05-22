🌤️ SwiftUI 5-Day Weather Forecast App

A clean and lightweight iOS app built with SwiftUI that displays the weather forecast for the next 5 days, including today, using data from WeatherAPI.

📲 Features

Each forecast item shows:

condition.text – Textual weather description (e.g. Sunny, Cloudy)

condition.icon – Icon representing the weather

avgtemp_c – Average temperature (°C)

maxwind_kph – Maximum wind speed (km/h)

avghumidity – Average humidity (%)

The app uses a single, scrollable screen powered by SwiftUI, with a focus on clarity and performance.

🔗 Weather API

Data is fetched from:

https://api.weatherapi.com/v1/forecast.json

Required query parameters:

key – Your API key

q – Location (e.g. city name or coordinates)

days=5 – Number of forecast days (must include today)

aqi=no – Disable air quality (optional)

alerts=no – Disable alerts (optional)

Example: https://api.weatherapi.com/v1/forecast.json?key=YOUR_API_KEY&q=Paris&days=5&aqi=no&alerts=no

🛠 Tech Stack

Swift

SwiftUI

Combine / async-await

MVVM architecture

URLSession for network calls
