import 'package:animate_do/animate_do.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/core/app_theme/app_asstes.dart';
import 'package:evently/core/app_theme/app_color.dart';
import 'package:evently/core/constant/customBottom.dart';
import 'package:evently/core/constant/shared_preferencesHe.dart';
import 'package:evently/core/maneger/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/routes/app_routes_name.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  Future<void> _checkIfFirstTime() async {
    bool isFirstOpen = await SharedPreferencesHe.isFirstTime();
    if (!mounted) return;

    Future.microtask(() {
      if (isFirstOpen) {
        SharedPreferencesHe.setFirstTime();
        Navigator.pushReplacementNamed(context, RoutesName.onboarding);
      } else {
        Navigator.pushReplacementNamed(context, RoutesName.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                child: Center(
                    child: Image.asset(
                  AppAssets.logoRow,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.5,
                )),
              ),
              const Spacer(),
              Expanded(
                flex: 6,
                child: Bounce(
                    child: Center(
                  child: Image.asset(
                    provider.themeMode == ThemeMode.light
                        ? AppAssets.firstOnboarding
                        : AppAssets.darkFirst,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )),
              ),
              const Spacer(),
              Text(
                AppLocalizations.of(context)!.start_title,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              SizedBox(
                width: 350,
                child: Text(
                  AppLocalizations.of(context)!.start_des,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              const Spacer(),
              Expanded(
                child: Row(
                  textDirection: TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.language,
                      style: TextStyle(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    AnimatedToggleSwitch<String>.rolling(
                      textDirection: TextDirection.ltr,
                      current: provider.lan,
                      values: const ["en", "ar"],
                      onChanged: (value) {
                        provider.changeLang(value);
                      },
                      iconList: [
                        Image.asset(
                          AppAssets.lr,
                          fit: BoxFit.cover,
                          width: 30,
                        ),
                        Image.asset(AppAssets.eg, fit: BoxFit.cover, width: 30),
                      ],
                      height: 40,
                      indicatorSize: const Size(40, 40),
                      style: ToggleStyle(
                          backgroundColor: Colors.transparent,
                          indicatorColor: theme.primaryColor,
                          borderColor: theme.primaryColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  textDirection: TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.theme,
                      style: TextStyle(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    AnimatedToggleSwitch<ThemeMode>.rolling(
                      textDirection: TextDirection.ltr,
                      current: provider.themeMode,
                      values: const [ThemeMode.light, ThemeMode.dark],
                      onChanged: (value) {
                        provider.changeTheme(value);
                      },
                      iconList: [
                        Image.asset(
                          AppAssets.sun,
                          fit: BoxFit.cover,
                          width: 30,
                        ),
                        Image.asset(
                          AppAssets.moon,
                          fit: BoxFit.cover,
                          width: 30,
                          color: provider.themeMode == ThemeMode.dark
                              ? AppColor.white
                              : null,
                        ),
                      ],
                      height: 40,
                      indicatorSize: const Size(40, 40),
                      style: ToggleStyle(
                          backgroundColor: Colors.transparent,
                          indicatorColor: theme.primaryColor,
                          borderColor: theme.primaryColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: CustomBottom(
                      text: AppLocalizations.of(context)!.l_start,
                      onTab: () {
                        _checkIfFirstTime();
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
