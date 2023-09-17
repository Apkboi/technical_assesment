import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:technical_assesment/core/constants/app_colors.dart';
import 'package:technical_assesment/core/extensions/transaction_extension.dart';
import 'package:technical_assesment/core/helpers/enums.dart';
import 'package:technical_assesment/core/utils/app_utils.dart';
import 'package:technical_assesment/features/wallet/data/models/fetch_transactions_response.dart';
import 'package:technical_assesment/features/wallet/presentation/screens/transactions_summary_screen.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({Key? key, required this.transaction})
      : super(key: key);
  final Transaction transaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionSummaryScreen(
                uid: widget.transaction.uuid,
              ),
            ));
      },
      child: Column(
        children: [
          Row(
            children: [
              TransactionIndicator(
                transactionType: widget.transaction.transactionType,
                radius: 24,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.transaction.transactionTittle.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    Text(
                      'Processed',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.w700, color: grey2),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '₦${widget.transaction.amount}',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    AppUtils.formatDateTime(widget.transaction.createdAt),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.w700, color: grey2),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: grey1,
          )
        ],
      ),
    );
  }
}

class TransactionIndicator extends StatelessWidget {
  const TransactionIndicator(
      {Key? key, required this.transactionType, this.radius = 25})
      : super(key: key);
  final TransactionType transactionType;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    switch (transactionType) {
      case TransactionType.withdrawal:
        return CircleAvatar(
          radius: radius!,
          backgroundColor:
              Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          child: Transform.rotate(
            angle: 400,
            child: Icon(
              Iconsax.arrow_down,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        );

      case TransactionType.deposit:
        return CircleAvatar(
          radius: 25,
          backgroundColor: grey1,
          child: Transform.rotate(
            angle: 120,
            child: const Icon(
              Iconsax.arrow_down,
              color: grey2,
            ),
          ),
        );

      default:
        return CircleAvatar(
          radius: 36,
          backgroundColor: grey1,
          child: Transform.rotate(angle: 90),
        );
    }
  }
}
