import 'package:flutter/material.dart';

class CustomButtonStyles {
  static ButtonStyle inactiveButton({required bool isActive}) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return Colors.grey[300]!;
          } else if (states.contains(WidgetState.disabled) || !isActive) {
            return Colors.grey;
          }
          return Colors.blue; // Default color for active state
        },
      ),
    );
  }
}
