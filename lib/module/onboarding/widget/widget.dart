import 'package:evently/core/app_theme/app_color.dart';
import 'package:flutter/material.dart';
//end
Widget buildPage({
  required String image,
  required String title,
  String? subtitle,
}) {
  return Builder(
    builder: (context) {
      ThemeData theme = Theme.of(context);
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: const TextStyle(
                color: AppColor.primaryColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: 20),
          if (subtitle != null)
            Text(
              subtitle,
              style: TextStyle(
                color: theme.textTheme.bodyMedium?.color,
                fontSize: 16,
              ),
              textAlign: TextAlign.start,
            ),
        ],
      );
    },
  );
}
