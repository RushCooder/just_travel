import 'package:flutter/material.dart';

class PaymentNowButton extends StatelessWidget {
  final VoidCallback onPressed;
  const PaymentNowButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        onPressed: onPressed,
        child: Text(
          'Payment Now',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white70),
        ),
      ),
    );
  }
}
