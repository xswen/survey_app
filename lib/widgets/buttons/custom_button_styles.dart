import 'package:flutter/material.dart';

class CustomButtonStyles {
  static ButtonStyle inactiveButton({required bool isActive}) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.grey[300]!;
          } else if (states.contains(MaterialState.disabled) || !isActive) {
            return Colors.grey;
          }
          return Colors.blue; // Default color for active state
        },
      ),
    );
  }
}
