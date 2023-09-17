import 'dart:developer';
import 'package:either_dart/either.dart';
import 'package:technical_assesment/common/models/server_error_model.dart';
import 'package:technical_assesment/core/constants/endpoints.dart';
import 'package:technical_assesment/core/helpers/api_helper.dart';
import 'package:technical_assesment/core/helpers/http_helper.dart';
import 'package:technical_assesment/features/wallet/data/models/fetch_transactions_response.dart';
import 'package:technical_assesment/features/wallet/data/models/fetch_wallet_response.dart';
import 'package:technical_assesment/features/wallet/data/models/transaction_by_id_response.dart';
import 'package:technical_assesment/features/wallet/dormain/repositories/wallet_repository.dart';

class WalletRepositoryImpl extends WalletRepository {
  final HttpHelper httpHelper;

  WalletRepositoryImpl(this.httpHelper);

  @override
  Future<Either<ServerErrorModel, FetchTransactionByIdResponse>>
      getTransactionById(String transactionId) {
    String urlWithId = '${WalletEndpoints.transactionById}$transactionId';

    return SimplifyApiConsuming.makeRequest(
        () => httpHelper.get(
              urlWithId,
            ),
        statusCodeSuccess: 200, successResponse: (response) {
      return FetchTransactionByIdResponse.fromJson(response);
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
            errorMessage: response.data['message'],
            data: null);
      }

      return const ServerErrorModel(
          statusCode: 400,
          errorMessage: 'An error occurred check your network and retry',
          data: null);
    });
  }

  @override
  Future<Either<ServerErrorModel, FetchTransactionsResponse>> getTransactions(
      String type) {
    String urlWithType = '${WalletEndpoints.getTransactionsEndpoint}$type';
    return SimplifyApiConsuming.makeRequest(
        () => httpHelper.get(
              urlWithType,
            ),
        statusCodeSuccess: 200, successResponse: (response) {
      return FetchTransactionsResponse.fromJson(response);
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
            errorMessage: response.data['message'],
            data: null);
      }

      return const ServerErrorModel(
          statusCode: 400,
          errorMessage: 'An error occurred check your network and retry',
          data: null);
    });
  }

  @override
  Future<Either<ServerErrorModel, FetchWalletResponse>> getWallet() {
    return SimplifyApiConsuming.makeRequest(
        () => httpHelper.get(
              WalletEndpoints.getWallet,
            ),
        statusCodeSuccess: 200, successResponse: (response) {
      return FetchWalletResponse.fromJson(response);
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
            errorMessage: response.data['message'],
            data: null);
      }

      return const ServerErrorModel(
          statusCode: 400,
          errorMessage: 'An error occurred check your network and retry',
          data: null);
    });
  }
}
