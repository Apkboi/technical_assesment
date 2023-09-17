import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_assesment/common/components/circular_loader.dart';
import 'package:technical_assesment/common/components/custom_button.dart';
import 'package:technical_assesment/common/components/error_widget.dart';
import 'package:technical_assesment/core/constants/app_colors.dart';
import 'package:technical_assesment/core/di/injector.dart';
import 'package:technical_assesment/features/wallet/presentation/blocs/wallet/wallet_bloc.dart';
import 'package:technical_assesment/features/wallet/presentation/components/balance_widget.dart';
import 'package:technical_assesment/features/wallet/presentation/components/transaction_item.dart';
import 'package:technical_assesment/features/wallet/presentation/components/wallet_transactiions_widget.dart';
import 'package:technical_assesment/features/wallet/presentation/screens/wallet_transactions_screen.dart';

class WalletTab extends StatefulWidget {
  const WalletTab({Key? key}) : super(key: key);

  @override
  State<WalletTab> createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BalanceWidget(),
            Expanded(child: Center(child: WalletTransactionsWidget()))
          ],
        ),
      ),
    );
  }
}
