import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app_getx2/controllers/weather_controller.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
   final WeatherController weatherController = Get.put(WeatherController());
  @override
  Widget build(BuildContext context) {
 return Scaffold(
      backgroundColor: const Color(0xFF3A79F7), // Background like your image
      appBar: AppBar(title: Text("hello")),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Obx((){
          if(weatherController.isLoading.value == true){
              return Center(
                child: CircularProgressIndicator(),
              );
          }
          return  Column(
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
          ],
        );
        }),
      ),
    );
  }
}
