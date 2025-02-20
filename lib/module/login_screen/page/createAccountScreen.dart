import 'package:animate_do/animate_do.dart';
import 'package:evently/core/app_theme/app_color.dart';
import 'package:evently/core/constant/customBottom.dart';
import 'package:evently/core/constant/validation.dart';
import 'package:evently/core/routes/app_routes_name.dart';
import 'package:evently/module/login_screen/widget/build.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/app_theme/app_asstes.dart';
import '../../../core/maneger/provider/app_provider.dart';
import '../widget/auth.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordHidden = true;
  bool isRePasswordHidden = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.register,
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
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildTextField(
                      label: AppLocalizations.of(context)!.name,
                      icon: Icons.person,
                      theme: theme,
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please Enter Your Name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    buildTextField(
                      label: AppLocalizations.of(context)!.email,
                      icon: Icons.email,
                      theme: theme,
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please Enter Your Email";
                        }
                        if (!Validation.isValidEmail(value)) {
                          return "Please Enter a valid Email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    buildTextField(
                      label: AppLocalizations.of(context)!.password,
                      icon: Icons.lock,
                      theme: theme,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please Enter Password";
                        }
                        if (!Validation.validatePassword(value)) {
                          return "Password must be at least 8 characters,\ninclude uppercase, lowercase, number, and special character.";
                        }
                        return null;
                      },
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
                    const SizedBox(height: 20),
                    buildTextField(
                      label: AppLocalizations.of(context)!.rePassword,
                      icon: Icons.lock,
                      theme: theme,
                      controller: rePasswordController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please confirm your password.";
                        }
                        if (value != passwordController.text.trim()) {
                          return "Passwords do not match!";
                        }
                        return null;
                      },
                      obscureText: isRePasswordHidden,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isRePasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: theme.textTheme.bodyMedium!.color,
                        ),
                        onPressed: () {
                          setState(() {
                            isRePasswordHidden = !isRePasswordHidden;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              CustomBottom(
                text: AppLocalizations.of(context)!.create,
                onTab: () async {
                  if (_formKey.currentState!.validate()) {
                    AuthService authService = AuthService();
                    await authService.register(
                      context,
                      nameController.text.trim(),
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
