import 'package:evently/core/app_theme/app_color.dart';
import 'package:evently/module/homeScreen/page/floating_event_screen/provider_event/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//end

class PositionLocationScreen extends StatefulWidget {
  late EventProvider provider;

  PositionLocationScreen({super.key, required this.provider});

  @override
  State<PositionLocationScreen> createState() => _PositionLocationScreenState();
}

class _PositionLocationScreenState extends State<PositionLocationScreen> {
  late EventProvider provider = widget.provider;

  @override
  void initState() {
    super.initState();
    provider.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ChangeNotifierProvider.value(
      value: provider,
      child: Consumer<EventProvider>(
        builder: (context, value, child) {
          return Scaffold(
            body: Stack(children: [
              Column(
                children: [
                  Expanded(
                    child: GoogleMap(
                      onTap: (LatLng position) {
                        provider.changeNewLocation(position);
                        Navigator.pop(context);
                      },
                      initialCameraPosition: provider.cameraPosition,
                      mapType: MapType.normal,
                      onMapCreated: (controller) {
                        provider.googleMapController = controller;
                      },
                      markers: provider.markers,
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(16),
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.tabToSelect,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              ),
            ]),
          );
        },
      ),
    );
  }
}
