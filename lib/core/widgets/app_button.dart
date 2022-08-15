import 'package:flutter/material.dart';
import 'package:trade_depot_tracker_assessment_test/utils/colors.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final String label;
  final bool isLoading;

  const AppButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: isLoading
          ? const SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        primary: AppColors.buttonBlueColor,
        onPrimary: AppColors.white,
      ),
      onPressed: onPressed,
    );
  }
}
