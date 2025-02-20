import 'package:animate_do/animate_do.dart';
import 'package:evently/core/app_theme/app_asstes.dart';
import 'package:evently/core/app_theme/app_color.dart';
import 'package:evently/core/constant/customBottom.dart';
import 'package:evently/core/maneger/provider/app_provider.dart';
import 'package:evently/core/routes/app_routes_name.dart';
import 'package:evently/module/login_screen/widget/build.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/auth.dart';
//end

class PasswordScreen extends StatelessWidget {
  PasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Forgot Password",
          style: TextStyle(
            fontSize: 28,
            fontWeight: theme.textTheme.bodyLarge?.fontWeight,
            color: provider.themeMode == ThemeMode.dark
                ? theme.primaryColor
                : AppColor.black,
          ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: provider.themeMode == ThemeMode.dark
                ? theme.primaryColor
                : AppColor.black,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacementNamed(context, RoutesName.login);
            }
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: FadeInDown(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                FadeInRightBig(
                  child: Center(
                    child: Image.asset(
                      AppAssets.forgetscreen,
                      width: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Column(
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: buildTextField(
                        label: "Email Address",
                        icon: Icons.email,
                        theme: theme,
                        controller: emailController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                CustomBottom(
                  text: "Reset Password",
                  onTab: () {
                    AuthService()
                        .resetPassword(context, emailController.text.trim());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
