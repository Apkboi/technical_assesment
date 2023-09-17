import 'package:get_it/get_it.dart';
import 'package:technical_assesment/core/di/bloc/bloc_module.dart' as blocModule;
import 'package:technical_assesment/core/di/cubit/cubit_module.dart'
    as cubitModule;
import 'package:technical_assesment/core/di/network/newtwork_module.dart'
    as networkModule;
import 'package:technical_assesment/core/di/repository/repossitory_module.dart'
    as repositoryModule;




GetIt injector = GetIt.instance;
Future<void> init() async {
  cubitModule.setup(injector);
  networkModule.setup(injector);
  repositoryModule.setup(injector);
  blocModule.setup(injector);
}
