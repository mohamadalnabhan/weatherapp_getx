import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app_getx2/controllers/weather_controller.dart';
import 'package:weather_app_getx2/models/weather_model.dart';
import 'package:weather_app_getx2/view/forecast_controller.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();
  final WeatherController weatherController = Get.put(WeatherController());
  final ForecastController forecastController = Get.put(ForecastController());

  @override
  void initState() {
    super.initState();
    weatherController.GetWeatherData(weatherController.city);
    forecastController.GetForecastData(forecastController.city);
  }

  @override
  Widget build(BuildContext context) {
    String iconCodeWeather =
        weatherController.weatherData.value?.weather[0].icon ?? "01d";

    String iconUrl =
        "https://openweathermap.org/img/wn/$iconCodeWeather@2x.png";

    return Scaffold(
      backgroundColor: const Color(
        0xFF3A79F7,
      ),
      appBar: AppBar(
   backgroundColor: const Color(
        0xFF3A79F7,)

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20), 
        child: Column(
          children: [
            Obx(() {
              if (weatherController.isLoading.value == true) {
                return Center(child: CircularProgressIndicator());
              }
              if (weatherController.weatherData.value == null) {
                return Center(child: CircularProgressIndicator());
              }
              return Column(
                children: [
                  Padding(padding: EdgeInsets.all(10)),
                  InkWell(
                    onTap: () {
                      Get.defaultDialog(
                        title: "You can change your location here",
                        content: Column(
                          children: [
                            TextFormField(
                              controller: _controller,
                              decoration: InputDecoration(
                                labelText: 'Enter City',
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                String newCity = _controller.text.trim();
                                weatherController.city = newCity;
                                weatherController.GetWeatherData(newCity);
                                Get.back();
                              },
                              child: Text("Update City"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          "${weatherController.city}",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.location_on_sharp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "${((weatherController.weatherData.value?.main.temp ?? 0) - 273.15).toStringAsFixed(1)} °",
                        style: TextStyle(color: Colors.white, fontSize: 70),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          Text(
                            "${weatherController.weatherData.value?.weather[0].description.capitalize}",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Humidity: ${weatherController.weatherData.value?.main.humidity}",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: Image.network(iconUrl, fit: BoxFit.contain),
                  ),
                ],
              );
            }),
            Expanded(
              child: Obx(() {
                if (forecastController.ForecastData.value == null) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container(
                  color: Colors.white24,
                  child: ListView.builder(
                    itemCount:
                        forecastController.ForecastData.value!.list.length < 3
                            ? forecastController.ForecastData.value!.list.length
                            : 3,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final Item =
                          forecastController.ForecastData.value!.list[index];

                      // get the icon
                      String iconCodeForecast =
                          Item.weather.isNotEmpty
                              ? Item.weather[0].icon ?? "01d"
                              : "01d";
                      String iconUrlForecast =
                          "https://openweathermap.org/img/wn/$iconCodeForecast@2x.png";

                      final temperature = (Item.main?.temp ?? 273.15)
                          .toStringAsFixed(1);
                      final DateTime? date = Item.dtTxt;
                      final String dayName =
                          date != null
                              ? DateFormat('EEEE').format(date)
                              : "Day ${index + 2}";

                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  iconUrlForecast,
                                  width: 40,
                                  height: 40,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          Icon(Icons.error),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  dayName,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Text(
                              "$temperature °C",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
