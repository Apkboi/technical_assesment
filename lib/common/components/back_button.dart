import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key, required this.onPressed}) : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
        style: IconButton.styleFrom(
            padding: const EdgeInsets.all(10),
            shape: const CircleBorder(side: BorderSide(color: Colors.grey))),
        onPressed: () {
          onPressed();
        },
        icon: const Icon(Iconsax.arrow_left));
  }
}
