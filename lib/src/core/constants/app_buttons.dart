import 'package:flutter/material.dart';

Widget appButton({
  required String title,
  required VoidCallback? onpressed,
  bool expanded = false,
}) {
  return SizedBox(
    width: expanded ? double.infinity : null,
    child: ElevatedButton(
      onPressed: onpressed,
      style:
          ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3f7edc),
            disabledBackgroundColor: const Color(0xFF3f7edc).withOpacity(0.5),
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
          ).copyWith(
            overlayColor: WidgetStateProperty.resolveWith<Color?>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.pressed)) {
                return Colors.white.withOpacity(0.2);
              }
              return null;
            }),
          ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
