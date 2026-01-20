# Weather App (Flutter + GetX + Dio)

A simple and clean weather application built with Flutter that fetches real-time weather data and a short forecast using a public Weather API. The app allows users to search for a city and view current weather conditions along with a 3-day forecast.

---

## 📱 Features

* Search weather by city name
* Display current temperature, weather description, and humidity
* Show weather icon based on API response
* 3-day weather forecast
* Real-time data from a Weather API
* Reactive UI updates using GetX
* Loading states while fetching data

---

## 🛠️ Tech Stack

* Flutter
* Dart
* GetX (state management & dependency injection)
* Dio (HTTP client)
* MVC architecture (Model–View–Controller)
* OpenWeather API (or similar weather API)

---

## 🧱 Architecture

This project follows a simple MVC pattern:

* **Model**: Handles data structures and JSON parsing (e.g., `WeatherModel`, `ForecastModel`)
* **View**: UI screens and widgets (e.g., `WeatherScreen`)
* **Controller**: Business logic and API calls (e.g., `WeatherController`, `ForecastController`)

State is managed using GetX with reactive variables (`Rx`) and `Obx` widgets for UI updates.

---

## 🌐 API Integration

* Uses Dio to make HTTP requests to a weather API
* Fetches:

  * Current weather data
  * 3-day forecast data
* Parses JSON responses into Dart models

---

## 🚀 Getting Started

1. Clone the repository:

```bash
git clone https://github.com/your-username/weather-app-getx.git
```

2. Install dependencies:

```bash
flutter pub get
```

3. Add your API key:

* Create a `.env` file or update the constants file
* Insert your Weather API key

4. Run the app:

```bash
flutter run
```

---

## 📸 Screenshots

<img width="305" height="674" alt="weatherapp" src="https://github.com/user-attachments/assets/5d940be3-e908-4d58-984d-cdb573b55586" />


---

## ⚠️ Notes

* This project was built as a practice project to learn:

  * API integration in Flutter
  * GetX state management
  * MVC architecture
* Temperature values are converted from Kelvin to Celsius

---

## 👨‍💻 Author

Mohamad Nabhan

---

## 📄 License

This project is open-source and available for learning and educational purposes.
