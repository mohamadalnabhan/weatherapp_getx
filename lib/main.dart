import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app_getx2/controllers/weather_controller.dart';
import 'package:weather_app_getx2/view/forecast_controller.dart';
import 'view/weather_screen.dart';

void main() {
  Get.put(WeatherController()); 
  Get.put(ForecastController());
  runApp(MyApp()); // <-- You forgot this line
}


class MyApp extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) {
    final controller = Get.find<WeatherController>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: WeatherScreen(),
    );
  }
}
