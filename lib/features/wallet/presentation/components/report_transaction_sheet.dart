import 'package:flutter/material.dart';
import 'package:technical_assesment/common/components/custom_button.dart';
import 'package:technical_assesment/common/components/custom_text_field.dart';
import 'package:technical_assesment/core/constants/app_colors.dart';

class ReportTransactionSheet extends StatefulWidget {
  const ReportTransactionSheet({Key? key}) : super(key: key);

  @override
  State<ReportTransactionSheet> createState() => _ReportTransactionSheetState();
}

class _ReportTransactionSheetState extends State<ReportTransactionSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        color: Theme.of(context).colorScheme.background,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
                child: Container(
              margin: const EdgeInsets.all(5),
              width: 50,
              height: 7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: grey2),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    style: IconButton.styleFrom(
                        side: const BorderSide(color: grey2),
                        padding: const EdgeInsets.all(16)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 16,
                    )),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: Image.asset(
                'assets/images/notepad.png',
                height: 40,
                width: 40,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Leave a remark",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Your feedback helps us improve our services and resolve any issues you may have encountered.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w700, color: grey2),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.viewInsetsOf(context).bottom),
              child: const CustomTextField(
                hint: 'Write something',
                outline: true,
                maxLine: 5,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomButton(
                child: const Text('Report'),
                onPressed: () {
                  Navigator.pop(context, true);
                }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
