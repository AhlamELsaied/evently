import 'package:evently/core/constant/categoryData.dart';
import 'package:evently/module/homeScreen/screen/favScreen.dart';
import 'package:evently/module/homeScreen/screen/homeScreen.dart';
import 'package:evently/module/homeScreen/screen/mapScreen.dart';
import 'package:evently/module/homeScreen/screen/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../../core/maneger/firebase/screen/fireBaseManeger.dart';
import '../../../core/maneger/firebase/model/eventfiremodel.dart';

class LayoutscreenProvider extends ChangeNotifier {
  List<Widget> screen = [
    Homescreen(),
    MapScreen(),
    FavScreen(),
    ProfileScreen(),
  ];
  List<EventModel> events = [];
  List<EventModel> favEvents = [];
  int selectIndex = 0;
  int tabIndex = 0;
  Location location = Location();
  String locationMassage = "";

  late GoogleMapController googleMapController;
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 17,
  );
  Set<Marker> markers = {
    Marker(
        markerId: MarkerId("0"),
        position: LatLng(37.42796133580664, -122.085749655962))
  };

  void changeBottNav(int value) {
    selectIndex = value;
    notifyListeners();
  }

  void changeTabIndex(int value) {
    tabIndex = value;
    getEventStream(value == 0 ? "All" : CategoryData.categories[value - 1].id);
    notifyListeners();
  }

  Future<void> getEvent() async {
    var data = await FirebaseDatabase.getEvent();
    events.clear();
    for (var e in data) {
      events.add(e.data());
    }
    notifyListeners();
  }

  void getEventStream(String category) async {
    events.clear();
    var data = await FirebaseDatabase.getEventStream(category).listen((event) {
      events.clear();
      for (var e in event.docs) {
        events.add(e.data());
      }
      notifyListeners();
    });
  }

  void getFavEventStream() {
    favEvents.clear();
    notifyListeners();

    FirebaseDatabase.getFavStream().listen((event) {
      final newFavEvents = <EventModel>[];
      for (var e in event.docs) {
        newFavEvents.add(e.data());
      }
      favEvents = newFavEvents;
      notifyListeners();
    });
  }

  void search(String e) {
    if (e.isEmpty) {
      return getFavEventStream();
    } else {
      favEvents = favEvents.where(
        (value) {
          return value.title.toLowerCase().contains(e.toLowerCase());
        },
      ).toList();
      notifyListeners();
    }
  }

  Future<void> eventFavorite(EventModel event) async {
    event.isFav = !event.isFav;
    notifyListeners();
    await FirebaseDatabase.updateFavoriteStatus(event);
  }

  Future<void> getLocation() async {
    locationMassage = "Check Your Location Service";
    bool locationPer = await _getLocationPer();
    if (!locationPer) {
      locationMassage = "Location Permission Denied";
      notifyListeners();
      return;
    }
    bool locationSerEn = await _getLocationEnable();
    if (!locationSerEn) {
      locationMassage = "Location Permission Denied";
      notifyListeners();
      return;
    }
    locationMassage = "We are Getting Your Location";
    notifyListeners();
    LocationData locationData = await location.getLocation();
    cameraPosition = CameraPosition(
        target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
        zoom: 17);
    markers.add(
      Marker(
          markerId: MarkerId("0"),
          position:
              LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0)),
    );
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();
    locationMassage =
        "You Are At${locationData.latitude} : ${locationData.longitude}";
    notifyListeners();
  }

  void locationLise() {
    location.changeSettings(accuracy: LocationAccuracy.high);
    location.onLocationChanged.listen(
      (event) {
        changeLocation(event);
      },
    );
  }

  void changeLocation(LocationData locationData) {
    cameraPosition = CameraPosition(
        target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
        zoom: 17);
    markers.add(
      Marker(
          markerId: MarkerId("0"),
          position:
              LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0)),
    );
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();
  }

  void changeCameraPosition(LatLng lat) {
    cameraPosition =
        CameraPosition(target: LatLng(lat.latitude, lat.longitude), zoom: 17);
    markers = {
      Marker(
          markerId: MarkerId("0"),
          position: LatLng(lat.latitude ?? 0, lat.longitude)),
    };
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();
  }

  Future<bool> _getLocationEnable() async {
    bool locationEnable = await location.serviceEnabled();
    if (!locationEnable) {
      locationEnable = await location.requestService();
    }
    return locationEnable;
  }

  Future<bool> _getLocationPer() async {
    var permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
    }
    return permission == PermissionStatus.granted;
  }
}
