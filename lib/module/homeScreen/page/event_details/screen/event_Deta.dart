import 'package:evently/core/maneger/firebase/screen/fireBaseManeger.dart';
import 'package:evently/core/routes/app_routes_name.dart';
import 'package:evently/module/homeScreen/page/event_details/widget/customDate.dart';
import 'package:evently/module/homeScreen/page/event_details/widget/customLocation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../core/maneger/firebase/model/eventfiremodel.dart';
import '../../../../../core/maneger/provider/app_provider.dart';

class EventDetails extends StatefulWidget {
  final EventModel event;
  static const String routeName = "/eventDetails";

  const EventDetails({super.key, required this.event});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: theme.primaryColor),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.eventDetails,
          style: theme.textTheme.bodyLarge!.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 26),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.addEvent,
                    arguments: widget.event);
              },
              icon: Icon(
                Icons.edit,
                color: theme.primaryColor,
                size: 25,
              )),
          IconButton(
              onPressed: () {
                _deleteEvent();
              },
              icon: Icon(
                Icons.delete_rounded,
                color: Colors.red,
                size: 25,
              )),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 138 / 78,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.asset(
                      widget.event.categoryImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    widget.event.title,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomDate(
                  date: DateFormat("yyyy-MM-dd").format(
                    DateTime.parse(widget.event.date),
                  ),
                  time: DateFormat("hh:mm a").format(
                    DateTime(0, 0, 0, widget.event.hour, widget.event.minute),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomLocation(
                  lat: widget.event.lat,
                  long: widget.event.long,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 1, color: theme.primaryColor)),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(widget.event.lat, widget.event.long),
                          zoom: 17),
                      scrollGesturesEnabled: false,
                      tiltGesturesEnabled: false,
                      zoomGesturesEnabled: false,
                      markers: {
                        Marker(
                            markerId: MarkerId("0"),
                            position:
                                LatLng(widget.event.lat, widget.event.long))
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    textAlign: TextAlign.start,
                    AppLocalizations.of(context)!.des,
                    style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    textAlign: TextAlign.start,
                    widget.event.desc,
                    style: theme.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _deleteEvent() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          title: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
    await FirebaseDatabase.deleteData(widget.event.id ?? "");
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
