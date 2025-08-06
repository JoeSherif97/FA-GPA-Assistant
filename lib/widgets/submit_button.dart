import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onp;
  final double icosize;
  final dynamic icoimg;
  const SubmitButton({
    super.key,
    required this.icosize,
    required this.icoimg,
    required this.onp,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double responsiveIconSize = size.width * 0.15; // 15% of screen width

    return IconButton(
      onPressed: onp,
      icon: ImageIcon(
        icoimg,
        size: responsiveIconSize < 60 ? responsiveIconSize : 60, // Cap max size
        color: Colors.black,
      ),
    );
  }
}
