import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:technical_assesment/common/components/back_button.dart';
import 'package:technical_assesment/common/components/circular_loader.dart';
import 'package:technical_assesment/common/components/error_widget.dart';
import 'package:technical_assesment/core/constants/app_colors.dart';
import 'package:technical_assesment/core/di/injector.dart';
import 'package:technical_assesment/core/extensions/transaction_extension.dart';
import 'package:technical_assesment/core/utils/app_utils.dart';
import 'package:technical_assesment/features/wallet/presentation/blocs/wallet/wallet_bloc.dart';
import 'package:technical_assesment/features/wallet/presentation/components/report_transaction_sheet.dart';
import 'package:technical_assesment/features/wallet/presentation/components/transaction_item.dart';
import 'package:technical_assesment/features/wallet/presentation/screens/transaction_reported_screen.dart';

class TransactionSummaryScreen extends StatefulWidget {
  const TransactionSummaryScreen({Key? key, required this.uid})
      : super(key: key);

  final String uid;

  @override
  State<TransactionSummaryScreen> createState() =>
      _TransactionSummaryScreenState();
}

class _TransactionSummaryScreenState extends State<TransactionSummaryScreen> {
  @override
  void initState() {
    injector.get<WalletBloc>().add(FetchTransactionsByIdEvent(widget.uid));
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
                    'Transaction Summary',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  )))
                ],
              ),
              Expanded(
                child: BlocConsumer<WalletBloc, WalletState>(
                  listener: _listenToBloStates,
                  buildWhen: _buildWhen,
                  bloc: injector.get(),
                  builder: (context, state) {
                    if (state is FetchTransactionByIdSuccessState) {
                      return Column(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      TransactionIndicator(
                                          transactionType: state
                                              .response.data.transactionType),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        "₦${state.response.data.amount}",
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        AppUtils.formatDateTime(state.response.data.createdAt),
                                        style: const TextStyle(color: grey2),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Divider(
                                  color: grey1,
                                ),
                                if (state.response.data.bankDetail != null)
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Expanded(
                                              child: Text(
                                            'Recipient',
                                            style: TextStyle(
                                                fontSize: 14, color: grey2),
                                          )),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                state.response.data.bankDetail!
                                                    .bankName,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "${state.response.data.bankDetail!.accountName}(${state.response.data.bankDetail!.accountNumber})",
                                                style: const TextStyle(
                                                    color: grey2, fontSize: 12),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      const Divider(
                                        color: grey1,
                                      ),
                                    ],
                                  ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                        child: Text(
                                      'Status',
                                      style:
                                          TextStyle(fontSize: 14, color: grey2),
                                    )),
                                    Card(
                                      color: Colors.green,
                                      shape: const StadiumBorder(),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                          vertical: 8,
                                        ),
                                        child: Text(
                                          state.response.data.status,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Divider(
                                  color: grey1,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                        child: Text(
                                      'Fee',
                                      style:
                                          TextStyle(fontSize: 14, color: grey2),
                                    )),
                                    Text(
                                      '₦${state.response.data.fee}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Divider(
                                  color: grey1,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                        child: Text(
                                      'Transaction ID',
                                      style:
                                          TextStyle(fontSize: 14, color: grey2),
                                    )),
                                    Row(
                                      children: [
                                        Icon(
                                          Iconsax.copy,
                                          size: 15,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${state.response.data.uuid.substring(0, 10)}...',
                                          style: const TextStyle(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Divider(
                                  color: grey1,
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary))),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Report Transaction'),
                                ],
                              ),
                              onPressed: () {
                                _reportTransaction(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          )
                        ],
                      );
                    }

                    if (state is FetchTransactionByIdFailedState) {
                      return SizedBox(
                          height: 100,
                          child: AppPromptWidget(
                            title: 'Something went wrong..',
                            message: state.error,
                            onTap: () {
                              injector
                                  .get<WalletBloc>()
                                  .add(FetchTransactionsByIdEvent(widget.uid));
                            },
                          ));
                    }

                    if (state is FetchTransactionByIdLoadingState) {
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
                            injector
                                .get<WalletBloc>()
                                .add(FetchTransactionsByIdEvent(widget.uid));
                          },
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _reportTransaction(BuildContext context) async {
    bool reported = await AppUtils.showCustomModalBottomSheet(
        context, const ReportTransactionSheet());

    if (reported) {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TransactionReportedScreen(),
          ));
    }
  }

  void _listenToBloStates(BuildContext context, WalletState state) {}

  bool _buildWhen(WalletState previous, WalletState current) {
    return current is FetchTransactionByIdLoadingState ||
        current is FetchTransactionByIdFailedState ||
        current is FetchTransactionByIdSuccessState;
  }
}
