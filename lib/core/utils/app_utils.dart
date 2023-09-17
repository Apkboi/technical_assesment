import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:technical_assesment/core/constants/storage_keys.dart';
import 'package:technical_assesment/core/helpers/storage_helper.dart';
import 'package:technical_assesment/features/authentication/presentation/screens/login_screen.dart';
import 'package:technical_assesment/features/dashboard/presentation/screens/dashboard.dart';

class AppUtils {
  AppUtils._();

  static Future<Widget> getFirstScreen() async {
    bool isLoggedIn =
        await StorageHelper.getBoolean(StorageKeys.stayLoggedIn, false);

    if (isLoggedIn) {
      return const Dashboard();
    } else {
      return const LoginScreen();
    }
  }

  static Future<T?> showCustomModalBottomSheet<T>(
    BuildContext context,
    Widget child, {
    bool? isDismissible = true,
    bool? isScrollControlled = true,
    bool? enableDrag = true,
  }) {
    return showModalBottomSheet(
      context: context,
      //
      // topRadius: const Radius.circular(20),
      //
      // animationCurve: Curves.easeIn,
      backgroundColor: Theme.of(context).colorScheme.background,

      isDismissible: isDismissible!,

      isScrollControlled: isScrollControlled!,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      enableDrag: enableDrag!,
      // constraints:
      // BoxConstraints(maxHeight: getDeviceSize(context).height * 0.8),
      // closeProgressThreshold: 200,
      // duration: const Duration(milliseconds: 300),

      builder: (context) => child,
    );
  }

  static String formatDateTime(DateTime? t) {
    if (t?.day == DateTime.now().day) {
      return 'Today';
    }
    return DateFormat("E MMM d, yyyy").format(t!);
  }
}

class CustomSnackBar {
  final BuildContext context;

  CustomSnackBar({required this.context});

  CustomSnackBar.showMessage(
    this.context, {
    required String message,
    Function? action,
    String? actionMessage,
    Color? backgroundColor,
  }) {
    final snackBar = SnackBar(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      action: action == null
          ? null
          : SnackBarAction(
              label: actionMessage ?? "OK",
              onPressed: () => action,
              textColor: Colors.white,
            ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor:
          backgroundColor ?? backgroundColor ?? const Color(0xFF383737),
      content: Text(
        message,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  CustomSnackBar.show(
    this.context, {
    required Widget body,
    Function? action,
    String? actionMessage,
    Color? backgroundColor,
  }) {
    final snackBar = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(18),
      duration: const Duration(seconds: 5),
      dismissDirection: DismissDirection.horizontal,
      action: action == null
          ? null
          : SnackBarAction(
              label: actionMessage ?? "OK",
              onPressed: () => action,
              textColor: Colors.white,
            ),
      backgroundColor: backgroundColor ?? backgroundColor ?? Colors.black,
      content: body,
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      snackBar,
    );
  }

  CustomSnackBar.showError(
    this.context, {
    required String message,
    Function? action,
    String? actionMessage,
    Color? backgroundColor,
  }) {
    final snackBar = SnackBar(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      action: action == null
          ? null
          : SnackBarAction(
              label: actionMessage ?? "OK",
              onPressed: () => action,
              textColor: Colors.white,
            ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: backgroundColor ?? backgroundColor ?? Colors.red,
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          color: Colors.white,
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  CustomSnackBar.showSuccess(
    this.context, {
    required String message,
    Function? action,
    String? actionMessage,
    Color? backgroundColor,
  }) {
    final snackBar = SnackBar(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      action: action == null
          ? null
          : SnackBarAction(
              label: actionMessage ?? "OK",
              onPressed: () => action,
              textColor: Colors.white,
            ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: backgroundColor ?? backgroundColor ?? Colors.green,
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          color: Colors.white,
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
