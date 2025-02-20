import 'package:animate_do/animate_do.dart';
import 'package:evently/core/constant/customBottom.dart';
import 'package:evently/core/routes/app_routes_name.dart';
import 'package:evently/module/login_screen/widget/build.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/app_theme/app_asstes.dart';
import '../../../core/maneger/provider/app_provider.dart';
import '../widget/auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//end

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordHidden = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              FadeInRightBig(
                child: Center(
                  child: Image.asset(
                    AppAssets.logo,
                    width: 90,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  buildTextField(
                    label: AppLocalizations.of(context)!.email,
                    icon: Icons.email,
                    theme: theme,
                    controller: emailController,
                  ),
                  const SizedBox(height: 20),
                  buildTextField(
                    label: AppLocalizations.of(context)!.password,
                    icon: Icons.lock,
                    theme: theme,
                    controller: passwordController,
                    obscureText: _isPasswordHidden,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: theme.textTheme.bodyMedium!.color,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordHidden = !_isPasswordHidden;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, RoutesName.password);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.forgetPassword,
                    style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: theme.primaryColor,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              CustomBottom(
                text: AppLocalizations.of(context)!.login,
                onTab: () async {
                  AuthService authService = AuthService();
                  await authService.login(
                    context,
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                },
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.dontHaveAccount,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: theme.textTheme.bodyLarge!.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, RoutesName.createAccount);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.create,
                      style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: theme.primaryColor,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      endIndent: 30,
                      indent: 30,
                      color: theme.primaryColor,
                      thickness: 2,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.or,
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.primaryColor),
                  ),
                  Expanded(
                    child: Divider(
                      endIndent: 30,
                      indent: 30,
                      color: theme.primaryColor,
                      thickness: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  AuthService authService = AuthService();
                  await authService.signInWithGoogle(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: theme.scaffoldBackgroundColor,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: theme.primaryColor, width: 2),
                    )),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.google,
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      AppLocalizations.of(context)!.googleLogin,
                      style: TextStyle(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
