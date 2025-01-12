import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BACKButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BACKButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF50B498),
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: SvgPicture.asset(
          'assets/BACK_ARROW_ICON.svg',
          fit: BoxFit.contain,
          width: 24,
          height: 24,
        ),
        iconSize: 24,
        onPressed: onPressed,
      ),
    );
  }
}
