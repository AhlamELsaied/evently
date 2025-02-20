import 'package:evently/core/app_theme/app_asstes.dart';
import 'package:evently/core/app_theme/app_color.dart';
import 'package:evently/core/routes/app_routes_name.dart';
import 'package:evently/module/homeScreen/widget/layoutScreenProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../core/maneger/provider/app_provider.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => LayoutscreenProvider(),
      child: Consumer<LayoutscreenProvider>(
        builder: (context, value, child) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.event);
              },
              elevation: 0,
              backgroundColor: theme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(360),
                side: BorderSide(
                  color: AppColor.white,
                  width: 4,
                ),
              ),
              child: Icon(
                Icons.add,
                color: AppColor.white,
                size: 30,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: value.selectIndex,
                onTap: value.changeBottNav,
                backgroundColor: theme.primaryColor,
                fixedColor: AppColor.white,
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: AppColor.white,
                items: [
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(AppAssets.home),
                      activeIcon: SvgPicture.asset(AppAssets.selectHome),
                      label: "Home"),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(AppAssets.location),
                      activeIcon: SvgPicture.asset(AppAssets.selectLocat),
                      label: "Map"),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(AppAssets.heart),
                      activeIcon: SvgPicture.asset(AppAssets.selectHeart),
                      label: "Love"),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(AppAssets.person),
                      activeIcon: SvgPicture.asset(AppAssets.selectPercon),
                      label: "Person"),
                ]),
            body: value.screen[value.selectIndex],
          );
        },
      ),
    );
  }
}
