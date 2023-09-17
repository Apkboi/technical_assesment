import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_assesment/common/components/circular_loader.dart';
import 'package:technical_assesment/common/components/custom_button.dart';
import 'package:technical_assesment/common/components/error_widget.dart';
import 'package:technical_assesment/core/constants/app_colors.dart';
import 'package:technical_assesment/core/di/injector.dart';
import 'package:technical_assesment/core/utils/formatters.dart';
import 'package:technical_assesment/features/wallet/presentation/blocs/wallet/wallet_bloc.dart';

class BalanceWidget extends StatefulWidget {
  const BalanceWidget({Key? key}) : super(key: key);

  @override
  State<BalanceWidget> createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletBloc, WalletState>(
      bloc: injector.get(),
      listener: (context, state) {},
      buildWhen: _buildWhen,
      builder: (context, state) {
        if (state is FetchWalletSuccessState) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wallet',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Column(
                      children: [
                        const Text(
                          "Balance",
                          style: TextStyle(
                              fontSize: 14,
                              color: grey2,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "${formatMoney(state.fetchWalletResponse.userWallet.balance,"₦")}",
                          style: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                            isExpanded: false,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60, vertical: 20),
                            child: const Text('Withdraw'),
                            onPressed: () {})
                      ],
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Divider(),
            ],
          );
        }

        if (state is FetchWalletFailedState) {
          return SizedBox(
              height: 100,
              child: AppPromptWidget(
                title: 'Something went wrong..',
                message: state.error,
                onTap: () {
                  injector.get<WalletBloc>().add(FetchWalletsEvent());
                },
              ));
        }

        if (state is FetchWalletLoadingState) {
          return const SizedBox(
              height: 200,
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
                injector.get<WalletBloc>().add(FetchWalletsEvent());
              },
            ));
      },
    );
  }

  bool _buildWhen(WalletState previous, WalletState current) {
    return current is FetchWalletLoadingState ||
        current is FetchWalletFailedState ||
        current is FetchWalletSuccessState;
  }
}
