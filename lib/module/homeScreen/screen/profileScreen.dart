import 'package:evently/core/app_theme/app_asstes.dart';
import 'package:evently/core/app_theme/app_color.dart';
import 'package:evently/core/routes/app_routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/maneger/provider/app_provider.dart';
//end

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String userName = user?.displayName ?? "User";

    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 170,
        backgroundColor: theme.primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(64),
        )),
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              textDirection: TextDirection.ltr,
              children: [
                Image.asset(
                  AppAssets.route,
                  width: 130,
                  height: 130,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textDirection: TextDirection.ltr,
                      userName,
                        style: theme.textTheme.bodyLarge!.copyWith(
                            color: AppColor.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        textDirection: TextDirection.ltr,
                        user?.email ?? "userName....@gmail.com",
                        style: theme.textTheme.bodyLarge!.copyWith(
                            color: AppColor.white, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Language", style: theme.textTheme.bodyLarge),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.primaryColor)),
              child: DropdownButton(
                underline: SizedBox(),
                isExpanded: true,
                value: "ar",
                items: [
                  DropdownMenuItem(
                    value: "ar",
                    child: Text(
                      "Arabic",
                      style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "en",
                    child: Text(
                      "English",
                      style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                onChanged: (value) {
                  provider.changeLang(value);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Theme", style: theme.textTheme.bodyLarge),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.primaryColor)),
              child: DropdownButton(
                underline: SizedBox(),
                isExpanded: true,
                value: provider.themeMode,
                items: [
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text(
                      "Light",
                      style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text(
                      "Dark",
                      style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                onChanged: (value) {
                  provider.changeTheme(value);
                },
              ),
            ),
            Spacer(
              flex: 8,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, RoutesName.login);
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Icon(Icons.logout_outlined, color: AppColor.white),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "LogOut",
                      style: theme.textTheme.bodyLarge!.copyWith(
                          color: AppColor.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
