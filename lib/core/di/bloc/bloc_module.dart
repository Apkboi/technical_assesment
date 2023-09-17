import 'package:get_it/get_it.dart';
import 'package:technical_assesment/features/authentication/presentation/blocs/auth/auth_bloc.dart';
import 'package:technical_assesment/features/wallet/presentation/blocs/wallet/wallet_bloc.dart';


void setup (GetIt injector){


  injector.registerLazySingleton<AuthBloc>(() => AuthBloc(injector.get()));
  injector.registerLazySingleton<WalletBloc>(() => WalletBloc(injector.get()));


}