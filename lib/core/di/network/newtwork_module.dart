import 'package:get_it/get_it.dart';
import 'package:technical_assesment/core/helpers/http_helper.dart';


void setup (GetIt injector){

  injector.registerLazySingleton<HttpHelper>(() => HttpHelper());


}