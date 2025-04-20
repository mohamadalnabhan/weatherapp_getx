import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:weather_app_getx2/models/weather_model.dart';

class WeatherController extends GetxController{
 var weatherData =Rxn<Welcome>();
 var isLoading =false.obs;
 var errorMessage = ''.obs ;

  final dio = Dio();
  String city  = "beirut";

 void GetWeatherData(String city) async {
    isLoading.value = true ;
    errorMessage.value ='' ;

    String apikey = "410e9c9d1c980e77dce624c4fa6369fd";
    String uri  = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apikey";
    try {
   Response response = await dio.get(uri);
   if(response.statusCode ==200){
    weatherData.value = Welcome.fromJson(response.data);
   }else{
    errorMessage.value = 'city not found ';
   }
    } catch (e) {
      errorMessage.value = 'Something went wrong';
    } finally {
      isLoading.value = false;
    }
  }
}
// Setup Reactive Variables
//Create an HTTP Request Function
//JSON parsing
//Handle Invalid Cities or API Errors