const String baseUrl = "https://dev-api.kooha.com/v1";
const String imageBaseUrl = "https://kooha-mobile-files.s3.amazonaws.com/";

class AuthorizationEndpoints {
  static String login = '$baseUrl/auth/test/login';
}

class WalletEndpoints {
  static String getTransactionsEndpoint = '$baseUrl/transactions/test?type=';
  static String transactionById = '$baseUrl/transactions/test/';
  static String getWallet = '$baseUrl/wallets/test';
}
