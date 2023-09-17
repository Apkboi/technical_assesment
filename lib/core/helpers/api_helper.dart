import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:technical_assesment/common/models/server_error_model.dart';



class SimplifyApiConsuming {
  SimplifyApiConsuming._();

  ///A more simplified method for making endpoint request call
  ///@param [requestFunction]
  ///a function passed, this function is the api call to execute
  ///@param [isStatusCode]
  ///a bool flag to indicate whether to equate response
  /// success with statusCode or with success string in response data
  ///@Param [statusCodeSuccess]
  /// an [int] status code to validate success of the request,
  /// if [isStatusCode] == true
  ///@Param [successResponse] a [Function]
  ///to execute if request is successful, must have a return statement
  /// Returns [Future<ResponseModel>]

  static Future<Either<T, S>> makeRequest<T, S>(
      Future<Response<dynamic>> Function() requestFunction,
      {bool isStatusCode = true,
        int statusCodeSuccess = 201,
        required S Function(dynamic data) successResponse,
        T Function(Response data)? errorResponse,
        T Function(Response? data)? dioErrorResponse,
        Function(int)? statusCode}) async {
    try {
      return await _makeRequest(requestFunction, isStatusCode,
          statusCodeSuccess, successResponse, errorResponse);
    } on SocketException {
      var serverErrorModel = const ServerErrorModel(
          statusCode: 400,
          errorMessage: "Something went wrong "
              "please check your internet connection and try again",
          data: null);
      return Left(serverErrorModel as T);
    } on DioError catch (e) {
      var serverErrorModel = ServerErrorModel(
          statusCode: 400,
          errorMessage: e.response?.data?.toString() ??
              "Something went wrong please try again",
          data: e.response?.data);
      return e.type == DioErrorType.badResponse &&  dioErrorResponse!= null
          ? Left(dioErrorResponse(e.response))
          : Left(serverErrorModel as T);
    } catch (error, stack) {
      // rethrow;
      var serverErrorModel = ServerErrorModel(
          statusCode: 400, errorMessage: error.toString(), data: null);
      log(stack.toString());
      return Left(
        serverErrorModel as T,
      );
    }
  }

  static Either<T, S> _handleResponseBasedOnDataReturned<T, S>(
      Response response,
      S Function(dynamic data) successResponse,
      T Function(Response data)? errorResponse) {
    if (response.data['status'] == 'success') {
      return Right(successResponse(response.data));
    }
    return Left(errorResponse!(response));
  }

  static Either<T, S> _handleResponseBasedOnStatusCode<T, S>(
      Response response,
      int statusCodeSuccess,
      S Function(dynamic data) successResponse,
      T Function(Response data)? errorResponse) {
    if (response.statusCode == statusCodeSuccess) {
      return Right(successResponse(response.data));
    } else {
      return Left(errorResponse!(response));
    }
  }

  static Future<Either<T, S>> _makeRequest<T, S>(
      Future<Response> Function() requestFunction,
      bool isStatusCode,
      int statusCodeSuccess,
      S Function(dynamic data) successResponse,
      T Function(Response data)? errorResponse) async {
    var response = await requestFunction();

    if (isStatusCode) {
      return _handleResponseBasedOnStatusCode(
          response, statusCodeSuccess, successResponse, errorResponse);
    } else {
      return _handleResponseBasedOnDataReturned(
          response, successResponse, errorResponse);
    }
  }
}
