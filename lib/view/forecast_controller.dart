import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:weather_app_getx2/models/forecast5d_model.dart';
import 'weather_screen.dart';
class ForecastController extends GetxController {
var ForecastData = Rxn<Forecast>();
 var isLoading =false.obs;
 var errorMessage = ''.obs ;

  String city = "beirut";
  final dio= Dio();

  void GetForecastData(String city) async{
      isLoading.value = true ;
    errorMessage.value ='' ;
     String apikey = "";
    String apiUri = "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apikey&units=metric";

    try {
  Response response = await dio.get(apiUri);

  print(response.data);

  if (response.statusCode == 200) {
    await Future.delayed(Duration(seconds: 1));
    
    try {
      ForecastData.value = Forecast.fromJson(response.data as Map<String, dynamic>);  // 🔥 wrap in small try-catch
      print("xxxxxxxxxxxxxxxxxxxx");
      print(ForecastData.value?.list.length);
      print("first weather icon: ${ForecastData.value?.list[0].weather[0].icon}");
      print("xxxxxxxxxxxxxxxxxxxx");
    } catch (e) {
      print("🔥 Error while parsing Forecast.fromJson: $e");
    }

  } else {
    errorMessage.value = "an error happened";
  }
} catch (e) {
  print("🔥 Error in request or general: $e");
  errorMessage.value = "something went wrong";
} finally {
  isLoading.value = false;
}



  }}