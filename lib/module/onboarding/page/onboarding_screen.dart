import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/app_theme/app_asstes.dart';
import '../../../core/app_theme/app_color.dart';
import '../../../core/maneger/provider/app_provider.dart';
import '../../../core/routes/app_routes_name.dart';
import '../widget/widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//end

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor:
          Provider.of<AppProvider>(context).themeMode == ThemeMode.light
              ? AppColor.lightBackground
              : AppColor.darkBackground,
      body: Column(
        children: [
          const SizedBox(height: 40),
          Center(
              child: Image.asset(
            AppAssets.logoRow,
            width: 200,
          )),
          const SizedBox(height: 30),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              children: [
                buildPage(
                    image: Provider.of<AppProvider>(context).themeMode ==
                            ThemeMode.light
                        ? AppAssets.hotTrending
                        : AppAssets.hotDark,
                    title: AppLocalizations.of(context)!.title1,
                    subtitle:
                    AppLocalizations.of(context)!.sub1),
                buildPage(
                  image: Provider.of<AppProvider>(context).themeMode ==
                          ThemeMode.light
                      ? AppAssets.managerDesk
                      : AppAssets.wireframe,
                  title: AppLocalizations.of(context)!.title2,
                  subtitle:
                  AppLocalizations.of(context)!.sub2                ),
                buildPage(
                  image: Provider.of<AppProvider>(context).themeMode ==
                          ThemeMode.light
                      ? AppAssets.beingCreative
                      : AppAssets.thirdDark,
                  title: AppLocalizations.of(context)!.title3,
                  subtitle:
                  AppLocalizations.of(context)!.sub3                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentPageIndex > 0)
                  Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColor.primaryColor),
                      ),
                      child: IconButton(
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: const Icon(Icons.arrow_back_rounded,
                            color: AppColor.primaryColor),
                      ))
                else
                  const SizedBox(width: 60),
                Expanded(
                  child: Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        activeDotColor: AppColor.primaryColor,
                        dotColor: Provider.of<AppProvider>(context).themeMode ==
                                ThemeMode.light
                            ? AppColor.black
                            : AppColor.white,
                        dotHeight: 8,
                        dotWidth: 8,
                        spacing: 8,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColor.primaryColor),
                  ),
                  child: IconButton(
                    onPressed: () {
                      if (currentPageIndex == 2) {
                        Navigator.pushReplacementNamed(
                            context, RoutesName.login);
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    icon: const Icon(Icons.arrow_forward_outlined,
                        color: AppColor.primaryColor),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
