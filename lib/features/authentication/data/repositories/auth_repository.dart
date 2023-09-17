import 'dart:developer';
import 'package:either_dart/either.dart';
import 'package:technical_assesment/common/models/server_error_model.dart';
import 'package:technical_assesment/core/constants/endpoints.dart';
import 'package:technical_assesment/core/helpers/api_helper.dart';
import 'package:technical_assesment/core/helpers/http_helper.dart';
import 'package:technical_assesment/features/authentication/data/models/login_response.dart';
import 'package:technical_assesment/features/authentication/dormain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final HttpHelper httpHelper;

  AuthRepositoryImpl(this.httpHelper);

  @override
  Future<Either<ServerErrorModel, LoginResponse>> login(
      {required String email, required String password}) {
    return SimplifyApiConsuming.makeRequest(
        () => httpHelper.post(AuthorizationEndpoints.login,
            body: {"email": email, "password": password}),
        successResponse: (response) {
      return LoginResponse.fromJson(response);
    }, errorResponse: (response) {
      log("RESPONSE ERROR");
      return ServerErrorModel(
          statusCode: response.statusCode!,
          errorMessage: response.data.toString(),
          data: null);
    }, dioErrorResponse: (response) {
      if (response != null) {
        return ServerErrorModel(
            statusCode: response.statusCode ?? 400,
            errorMessage: (response.data['errors'] as List).isNotEmpty
                ? response.data['errors'][0]
                : response.data['message'],
            data: null);
      }

      return const ServerErrorModel(
          statusCode: 400,
          errorMessage: 'An error occurred check your network and retry',
          data: null);
    });
  }
}
