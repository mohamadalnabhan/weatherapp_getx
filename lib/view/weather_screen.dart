import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app_getx2/controllers/weather_controller.dart';
import 'package:weather_app_getx2/models/weather_model.dart';
import 'package:weather_app_getx2/view/forecast_controller.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherController weatherController = Get.put(WeatherController());
  final ForecastController forecastController = Get.put(ForecastController());
  

  @override
  void initState() {
    super.initState();
    weatherController.GetWeatherData(weatherController.city);
    forecastController.GetForecastData(forecastController.city);
  }

  Widget build(BuildContext context) {
      String iconCodeWeather = weatherController.weatherData.value?.weather[0].icon ?? "01d" ;
      String iconUrl = "https://openweathermap.org/img/wn/$iconCodeWeather@2x.png";
    return Scaffold(
      backgroundColor: const Color(0xFF3A79F7), // Background like your image
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Obx(() {
          if (weatherController.isLoading.value == true) {
            return Center(child: CircularProgressIndicator());
          }
          if (weatherController.weatherData.value == null) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Padding(padding: EdgeInsets.all(10)),
              Row(
                children: [
                  Text(
                    "${weatherController.city}",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.location_on_sharp, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                  "${((weatherController.weatherData.value?.main.temp ?? 0) - 273.15).toStringAsFixed(1)} °",
                    style: TextStyle(color: Colors.white, fontSize: 70),
                  ),
                const SizedBox(width: 20,),
                Column(
                  
                  children: [
                      Text("${weatherController.weatherData.value?.weather[0].description.capitalize}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height:  5,),
                  Text( " humidity ${
                    weatherController.weatherData.value?.main.humidity 
                  }"
                  , style: TextStyle(color: Colors.white, fontSize: 16),)

                  ],
                )
                ],
              ),
              Container(
                 width: double.infinity,
           
                child: Image.network(iconUrl,
                    fit: BoxFit.contain,
                ),
              )
            ],
            
          );
        }),
      ),
    );
  }
}

