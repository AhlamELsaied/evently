import 'package:evently/core/constant/categoryData.dart';
import 'package:evently/module/homeScreen/widget/card_event.dart';
import 'package:evently/module/homeScreen/widget/layoutScreenProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/app_theme/app_asstes.dart';
import '../../../../core/app_theme/app_color.dart';
import '../../../../core/maneger/provider/app_provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String currentLocation = "Getting location...";

  @override
  void initState() {
    super.initState();
    Provider.of<LayoutscreenProvider>(context, listen: false)
        .getEventStream("All");
    _getUserLocation();

  }
  Future<void> _getUserLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _getAddressFromCoordinates(position.latitude, position.longitude);
    } else {
      setState(() {
        currentLocation = "Location permission denied";
      });
    }
  }

  Future<void> _getAddressFromCoordinates(double latitude, double longitude) async {
    List<Placemark> placemarks = await GeocodingPlatform.instance?.placemarkFromCoordinates(latitude, longitude) ?? [];
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      setState(() {
        currentLocation = "${place.subAdministrativeArea}, ${place.country}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);
    User? user = FirebaseAuth.instance.currentUser;
    String userName = user?.displayName ?? "User";

    return Consumer<LayoutscreenProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 200,
            backgroundColor: provider.themeMode == ThemeMode.dark
                ? theme.scaffoldBackgroundColor
                : theme.primaryColor,
            shape: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              ),
            ),
            flexibleSpace: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.welcomeBack,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Image.asset(
                          provider.themeMode == ThemeMode.dark
                              ? AppAssets.moon
                              : AppAssets.sun,
                          width: 40,
                          height: 40,
                        ),
                        SizedBox(width: 8),
                        Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              provider.lan,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      userName,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: AppColor.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                            size: 30, color: AppColor.white),
                        SizedBox(width: 4),
                        Text(
                          currentLocation,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    DefaultTabController(
                      length: CategoryData.categories.length + 1,
                      child: TabBar(
                          onTap: value.changeTabIndex,
                          labelColor: theme.primaryColor,
                          isScrollable: true,
                          unselectedLabelColor: AppColor.white,
                          indicatorColor: Colors.transparent,
                          indicatorPadding: const EdgeInsets.all(4),
                          dividerColor: Colors.transparent,
                          tabAlignment: TabAlignment.start,
                          tabs: [
                            Tab(
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: value.tabIndex == 0
                                      ? AppColor.white
                                      : theme.primaryColor,
                                  borderRadius: BorderRadius.circular(26),
                                  border: Border.all(
                                      color:
                                          provider.themeMode == ThemeMode.light
                                              ? AppColor.white
                                              : theme.primaryColor),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.explore_rounded),
                                    const SizedBox(width: 4),
                                    Text("All"),
                                  ],
                                ),
                              ),
                            ),
                            ...CategoryData.categories.map((e) {
                              return Tab(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: value.tabIndex ==
                                            CategoryData.categories.indexOf(e) +
                                                1
                                        ? AppColor.white
                                        : theme.primaryColor,
                                    borderRadius: BorderRadius.circular(26),
                                    border: Border.all(
                                        color: provider.themeMode ==
                                                ThemeMode.light
                                            ? AppColor.white
                                            : theme.primaryColor),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(e.icon),
                                      const SizedBox(width: 4),
                                      Text(e.name),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: value.events.length,
                itemBuilder: (context, index) {
                  return CardEvent(event: value.events[index]);
                },
              )),
        );
      },
    );
  }
}
