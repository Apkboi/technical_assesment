import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:technical_assesment/common/components/circular_loader.dart';
import 'package:technical_assesment/common/components/error_widget.dart';
import 'package:technical_assesment/core/constants/app_colors.dart';
import 'package:technical_assesment/core/di/injector.dart';
import 'package:technical_assesment/features/wallet/presentation/blocs/wallet/wallet_bloc.dart';
import 'package:technical_assesment/features/wallet/presentation/components/transaction_item.dart';
import 'package:technical_assesment/features/wallet/presentation/screens/wallet_transactions_screen.dart';

class WalletTransactionsWidget extends StatefulWidget {
  const WalletTransactionsWidget({Key? key}) : super(key: key);

  @override
  State<WalletTransactionsWidget> createState() =>
      _WalletTransactionsWidgetState();
}

class _WalletTransactionsWidgetState extends State<WalletTransactionsWidget> {
  final refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletBloc, WalletState>(
      bloc: injector.get(),
      listener: _listenToWalletBlocState,
      buildWhen: _buildWhen,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Transactions',
                        style: TextStyle(
                            color: grey2,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.arrow_downward_rounded,
                        size: 16,
                        color: grey2,
                      )
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const WalletTransactionsScreen(),
                            ));
                      },
                      child: Text(
                        'See all',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ))
                ],
              ),
              if (state is FetchTransactionsSuccessState)
                Expanded(
                    child: SmartRefresher(
                  enablePullDown: true,
                  onRefresh: () {
                    injector
                        .get<WalletBloc>()
                        .add(const FetchTransactionsEvent());
                    injector.get<WalletBloc>().add(FetchWalletsEvent());
                    refreshController.refreshCompleted();
                  },
                  controller: refreshController,
                  child: ListView.builder(
                    itemCount: state.response.data.transactions.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TransactionItem(
                        transaction: state.response.data.transactions[index],
                      ),
                    ),
                  ),
                )),
              if (state is FetchTransactionsFailedState)
                Expanded(
                  child: Center(
                    child: SizedBox(
                        child: AppPromptWidget(
                      title: 'Something went wrong..',
                      message: state.error,
                      onTap: () {
                        injector
                            .get<WalletBloc>()
                            .add(const FetchTransactionsEvent());
                      },
                    )),
                  ),
                ),
              if (state is FetchTransactionsLoadingState)
                const Expanded(
                  child: Center(
                    child: CircularLoader(
                      size: 30,
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }

  void _listenToWalletBlocState(BuildContext context, WalletState state) {}

  bool _buildWhen(WalletState previous, WalletState current) {
    return current is FetchTransactionsLoadingState ||
        current is FetchTransactionsFailedState ||
        current is FetchTransactionsSuccessState;
  }
}
