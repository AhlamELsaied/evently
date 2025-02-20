import 'package:evently/core/app_theme/app_color.dart';
import 'package:evently/core/maneger/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:provider/provider.dart';
//end

class CustomLocation extends StatefulWidget {
  final double lat;
  final double long;

  const CustomLocation({
    super.key,
    required this.lat,
    required this.long,
  });

  @override
  State<CustomLocation> createState() => _CustomLocationState();
}

class _CustomLocationState extends State<CustomLocation> {
  String address = "";

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.primaryColor),
        borderRadius: BorderRadius.circular(16),
        color: theme.scaffoldBackgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.primaryColor,
              border: Border.all(color: theme.primaryColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.gps_fixed,
              size: 32,
              color: theme.scaffoldBackgroundColor,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              address,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: AppColor.primaryColor,
              ),
              textAlign: TextAlign.start,
            ),
          )
        ],
      ),
    );
  }

  Future<void> _getLocation() async {
    if (widget.lat == null || widget.long == null) {
      setState(() {
        address = "Invalid coordinates";
      });
      return;
    }

    try {
      GeoCode geoCode = GeoCode();
      Address res = await geoCode.reverseGeocoding(
          latitude: widget.lat, longitude: widget.long);

      setState(() {
        address = "${res.streetAddress}, ${res.countryName}";
      });
    } catch (e) {
      setState(() {
        address = "Location not found";
      });
      debugPrint("Error fetching location: $e");
    }
  }
}
