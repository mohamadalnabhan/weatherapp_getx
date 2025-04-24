import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:weather_app_getx2/models/forecast5d_model.dart';

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
    String apiUri = "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apikey";
    try {
      Response response = await dio.get(apiUri);
      if(response.statusCode == 200){
        await Future.delayed(Duration(seconds: 1));
        ForecastData.value = Forecast.fromJson(response.data);
      }else{
        errorMessage.value = "an error happened";
      }
    }catch(e){
      errorMessage.value = "something went wrong";
    }finally{
      isLoading.value = false ;
    }

  }


}