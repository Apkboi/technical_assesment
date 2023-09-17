import 'package:get_it/get_it.dart';
import 'package:technical_assesment/core/cubits/navigation_cubit/navigation_cubit.dart';


void setup(GetIt injector) {

  injector.registerLazySingleton<NavigationCubit>(() => NavigationCubit());

}
