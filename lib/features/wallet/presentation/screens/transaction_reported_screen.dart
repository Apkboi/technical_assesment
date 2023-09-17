import 'package:flutter/material.dart';
import 'package:technical_assesment/common/components/custom_button.dart';
import 'package:technical_assesment/core/constants/app_colors.dart';

class TransactionReportedScreen extends StatefulWidget {
  const TransactionReportedScreen({Key? key}) : super(key: key);

  @override
  State<TransactionReportedScreen> createState() =>
      _TransactionReportedScreenState();
}

class _TransactionReportedScreenState extends State<TransactionReportedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/success_image.png',
                        height: 200,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Transaction\nSuccessfully Reported',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Your report has been received and\nis under careful review.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: grey2),
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                  child: const Text('Back to Home'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
