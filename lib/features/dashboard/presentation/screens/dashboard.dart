import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:technical_assesment/core/constants/app_colors.dart';
import 'package:technical_assesment/core/cubits/navigation_cubit/navigation_cubit.dart';
import 'package:technical_assesment/core/di/injector.dart';
import 'package:technical_assesment/features/dashboard/presentation/screens/home_tab.dart';
import 'package:technical_assesment/features/messaging/presentation/screens/inbox_tab.dart';
import 'package:technical_assesment/features/profile/presentation/screens/profile_tab.dart';
import 'package:technical_assesment/features/wallet/presentation/blocs/wallet/wallet_bloc.dart';
import 'package:technical_assesment/features/wallet/presentation/screens/wallet_tab.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _navIndex = 1;

  @override
  void initState() {
    injector.get<WalletBloc>().add(FetchWalletsEvent());
    injector.get<WalletBloc>().add(const FetchTransactionsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationCubit, NavigationState>(
      bloc: injector.get<NavigationCubit>(),
      listener: (context, state) {
        if (state is SwitchDrawerState) {
          setState(() {
            _navIndex = state.index;
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: _navIndex,
            children: const [HomeTab(), WalletTab(), InboxTab(), ProfileTab()],
          ),
          bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                injector.get<NavigationCubit>().switchDrawer(index);
              },
              type: BottomNavigationBarType.fixed,
              currentIndex: _navIndex,
              selectedIconTheme: IconThemeData(
                  color: Theme.of(context).colorScheme.onBackground),
              selectedLabelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.w600),
              selectedItemColor: Theme.of(context).colorScheme.onBackground,
              unselectedItemColor: grey2,
              elevation: 3,
              iconSize: 25,
              items: [
                const BottomNavigationBarItem(
                    activeIcon: Icon(
                      Iconsax.home5,
                    ),
                    icon: Icon(
                      Iconsax.home,
                    ),
                    label: 'Home'),
                const BottomNavigationBarItem(
                  icon: Icon(Iconsax.wallet),
                  label: "Wallet",
                  activeIcon: Icon(
                    Iconsax.empty_wallet5,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary),
                      onPressed: () {},
                      child: const Icon(
                        Icons.add,
                        size: 16,
                      )),
                  label: "",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Iconsax.message_text_1),
                  label: "Inbox",
                  activeIcon: Icon(
                    Iconsax.message_text5,
                  ),
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Iconsax.profile_circle),
                  label: "Profile",
                  activeIcon: Icon(
                    Iconsax.profile_circle5,
                  ),
                ),
              ]),
        );
      },
    );
  }
}
