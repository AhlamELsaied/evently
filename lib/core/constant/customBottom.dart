import 'package:flutter/material.dart';

import '../app_theme/app_color.dart';

class CustomBottom extends StatelessWidget {
  final String text;
  final Function()onTab;
   CustomBottom({super.key,required this.text,required this.onTab});
  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);

    return Row(
      textDirection: TextDirection.ltr,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
            onTab();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16))),
            child: Text(
              text,
              style: const TextStyle(
                  color: AppColor.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
        ),
      ],
    );
  }
}
