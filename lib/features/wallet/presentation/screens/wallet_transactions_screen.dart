import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:technical_assesment/common/components/back_button.dart';
import 'package:technical_assesment/common/components/circular_loader.dart';
import 'package:technical_assesment/common/components/error_widget.dart';
import 'package:technical_assesment/core/constants/app_colors.dart';
import 'package:technical_assesment/core/di/injector.dart';
import 'package:technical_assesment/core/extensions/enums_extensions.dart';
import 'package:technical_assesment/core/helpers/enums.dart';
import 'package:technical_assesment/features/wallet/presentation/blocs/wallet/wallet_bloc.dart';
import 'package:technical_assesment/features/wallet/presentation/components/transaction_item.dart';

class WalletTransactionsScreen extends StatefulWidget {
  const WalletTransactionsScreen({Key? key}) : super(key: key);

  @override
  State<WalletTransactionsScreen> createState() =>
      _WalletTransactionsScreenState();
}

class _WalletTransactionsScreenState extends State<WalletTransactionsScreen> {
  final walletBloc = WalletBloc(injector.get());

  @override
  void initState() {
    walletBloc.add(const FetchTransactionsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  CustomBackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Expanded(
                      child: Center(
                          child: Text(
                    'Wallet Transactions',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  )))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TransactionsFilterWidget(
                onSelected: (TransactionType transactionType) {
                  walletBloc.add(
                      FetchTransactionsEvent(transactionType: transactionType));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: BlocConsumer<WalletBloc, WalletState>(
                listener: _listenToWalletBlocStates,
                bloc: walletBloc,
                builder: (context, state) {
                  if (state is FetchTransactionsSuccessState) {
                    return ListView.builder(
                      itemCount: state.response.data.transactions.length,
                      itemBuilder: (context, index) => TransactionItem(
                        transaction: state.response.data.transactions[index],
                      ),
                    );
                  }
                  if (state is FetchTransactionsFailedState) {
                    return SizedBox(
                        height: 70,
                        child: AppPromptWidget(
                          title: 'Something went wrong..',
                          message: state.error,
                          onTap: () {
                            walletBloc.add(const FetchTransactionsEvent());
                          },
                        ));
                  }
                  if (state is FetchTransactionsLoadingState) {
                    return const SizedBox(
                        height: 70,
                        child: Center(
                          child: CircularLoader(
                            size: 30,
                          ),
                        ));
                  }

                  return SizedBox(
                      height: 70,
                      child: AppPromptWidget(
                        title: 'Something went wrong..',
                        message: 'Try again',
                        onTap: () {
                          walletBloc.add(const FetchTransactionsEvent());
                        },
                      ));
                },
              ))
            ],
          ),
        ),
      ),
    );
  }

  void _listenToWalletBlocStates(BuildContext context, WalletState state) {}
}

class TransactionsFilterWidget extends StatefulWidget {
  const TransactionsFilterWidget({Key? key, required this.onSelected})
      : super(key: key);
  final Function(TransactionType transactionType) onSelected;

  @override
  State<TransactionsFilterWidget> createState() =>
      _TransactionsFilterWidgetState();
}

class _TransactionsFilterWidgetState extends State<TransactionsFilterWidget> {
  TransactionType selectedType = TransactionType.all;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          TransactionType.values.length,
          (index) => GestureDetector(
            onTap: () {
              selectedType = TransactionType.values[index];
              widget.onSelected(TransactionType.values[index]);

              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Chip(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                label: Row(
                  children: [
                    if (TransactionType.values[index] != TransactionType.all)
                      TransactionType.values[index] ==
                              TransactionType.withdrawal
                          ? Transform.rotate(
                              angle: 400,
                              child: Icon(
                                Iconsax.arrow_down,
                                size: 16,
                                color: selectedType ==
                                        TransactionType.values[index]
                                    ? Colors.black
                                    : grey2,
                              ),
                            )
                          : Transform.rotate(
                              angle: 120,
                              child: Icon(
                                Iconsax.arrow_down,
                                size: 16,
                                color: selectedType ==
                                        TransactionType.values[index]
                                    ? Colors.black
                                    : grey2,
                              ),
                            ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      TransactionType.values[index].caption,
                      style: TextStyle(
                        color: selectedType == TransactionType.values[index]
                            ? Colors.black
                            : grey2,
                      ),
                    ),
                  ],
                ),
                side: BorderSide.none,
                backgroundColor: TransactionType.values[index] == selectedType
                    ? Theme.of(context).colorScheme.secondary
                    : grey1,
                shape: const StadiumBorder(side: BorderSide.none),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
