import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/app_theme/app_color.dart';
import '../../../core/maneger/provider/app_provider.dart';
//end

class CustomTextField extends StatelessWidget {
  final String title;
  final IconData? prefixIcon;
  final int? minLin;
  final int? maxLin;
  final bool? isExda;
  final TextEditingController? controller;
  void Function(String)? onChanged;
  final Color borderColor;

  CustomTextField({
    super.key,
    required this.title,
    this.prefixIcon,
    this.minLin,
    this.maxLin,
    this.isExda,
    this.controller,
    this.onChanged,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        return TextFormField(
          key: ValueKey(provider.themeMode),
          controller: controller,
          onChanged: onChanged,
          maxLines: maxLin,
          minLines: minLin,
          textAlignVertical: TextAlignVertical.top,
          expands: isExda ?? false,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            prefixIcon: Icon(prefixIcon, color: borderColor),
            labelText: title,
            suffixStyle: TextStyle(
              color: borderColor,
            ),
            labelStyle: TextStyle(
              color: borderColor,
              fontWeight: FontWeight.bold,
            ),
            filled: true,
            fillColor: theme.scaffoldBackgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.primaryColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: borderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: provider.themeMode == ThemeMode.dark
                    ? theme.primaryColor
                    : AppColor.gray,
                width: 2,
              ),
            ),
          ),
        );
      },
    );
  }
}
