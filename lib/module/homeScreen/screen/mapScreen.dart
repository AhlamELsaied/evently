import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../widget/layoutScreenProvider.dart';
import '../widget/mapCardItem.dart';
//end

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LayoutscreenProvider provider;

  @override
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);

    return Consumer<LayoutscreenProvider>(builder: (context, value, child) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            value.getLocation();
          },
          child: Icon(Icons.gps_fixed),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: provider.cameraPosition,
                    mapType: MapType.normal,
                    onMapCreated: (controller) {
                      provider.googleMapController = controller;
                    },
                    markers: provider.markers,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SizedBox(
                  height: 112,
                  child: ListView.separated(
                    padding: EdgeInsets.all(8),
                    scrollDirection: Axis.horizontal,
                    itemCount: value.events.length,
                    separatorBuilder: (context, index) => SizedBox(
                      width: 8,
                    ),
                    itemBuilder: (context, index) {
                      return MapCardItem(
                        eventModel: value.events[index],
                        onPress: (double lat, double long) {
                          provider.changeCameraPosition(LatLng(lat, long));
                        },
                      );
                    },
                  )),
            ),
          ],
        ),
      );
    });
  }
}
