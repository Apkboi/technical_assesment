import 'package:either_dart/either.dart';
import 'package:technical_assesment/common/models/server_error_model.dart';
import 'package:technical_assesment/features/authentication/data/models/login_response.dart';

abstract class AuthRepository {
  Future<Either<ServerErrorModel, LoginResponse>> login(
      {required String email, required String password});
}
