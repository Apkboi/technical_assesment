import 'package:flutter/material.dart';
import 'package:technical_assesment/features/wallet/presentation/components/balance_widget.dart';
import 'package:technical_assesment/features/wallet/presentation/components/wallet_transactiions_widget.dart';

class WalletTab extends StatefulWidget {
  const WalletTab({Key? key}) : super(key: key);

  @override
  State<WalletTab> createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              const SliverToBoxAdapter(
                child: BalanceWidget(),
              )
            ];
          },
          body: const WalletTransactionsWidget(),
        ),
      ),
    );
  }
}
