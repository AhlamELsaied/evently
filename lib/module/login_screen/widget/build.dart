import 'package:evently/core/app_theme/app_color.dart';
import 'package:evently/core/maneger/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildTextField({
  required String label,
  required IconData icon,
  required ThemeData theme,
  TextEditingController? controller,
  bool obscureText = false,
  Widget? suffixIcon,
  FormFieldValidator<String>? validator,
}) {
  return Builder(
    builder: (context) {
      var provider = Provider.of<AppProvider>(context);
      return TextFormField(
        controller: controller,
        validator: validator,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.start,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: theme.textTheme.bodyMedium!.color),
          prefixIcon: Icon(icon, color: theme.textTheme.bodyMedium!.color),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: provider.themeMode == ThemeMode.dark
                  ? theme.primaryColor
                  : AppColor.gray,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: provider.themeMode == ThemeMode.dark
                  ? theme.primaryColor
                  : AppColor.gray,
              width: 2.5,
            ),
          ),
          suffixIcon: suffixIcon,
        ),
      );
    },
  );
}
