import 'package:flutter/material.dart';

import '../values/app_colors.dart';
import '../values/app_styles.dart';

class DrawerButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const DrawerButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6)),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ],
        ),
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text(
          label,
          style: AppStyles.h5.copyWith(
            color: AppColors.textColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
