import 'package:get_it/get_it.dart';
import 'package:technical_assesment/features/authentication/data/repositories/auth_repository.dart';
import 'package:technical_assesment/features/authentication/dormain/repositories/auth_repository.dart';
import 'package:technical_assesment/features/wallet/data/repositories/wallet_repository.dart';
import 'package:technical_assesment/features/wallet/dormain/repositories/wallet_repository.dart';


void setup(GetIt injector) {
  injector.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(injector.get()));
  injector.registerLazySingleton<WalletRepository>(
      () => WalletRepositoryImpl(injector.get()));

}
