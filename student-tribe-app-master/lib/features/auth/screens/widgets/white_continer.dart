import 'package:flutter/material.dart';

import '../../../../core/theme/app_color.dart';

class AuthWhiteContainer extends StatelessWidget {
  const AuthWhiteContainer({
    super.key,
    this.child,
  });
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26), topRight: Radius.circular(26))),
      child: child,
    );
  }
}
