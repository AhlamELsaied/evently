import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../core/constant/categoryData.dart';
import '../../../../../core/maneger/firebase/screen/fireBaseManeger.dart';
import '../../../../../core/maneger/firebase/model/eventfiremodel.dart';
//end

class EventProvider extends ChangeNotifier {
  int tabIndex = 0;
  DateTime? selectData;
  TimeOfDay? timeOfDay;
  loc.Location location = loc.Location();
  String locationMassage = "";
  LatLng? eventLat;
  String eventAddress = "";
  EventModel? eventModel;

  late GoogleMapController googleMapController;
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 17,
  );

  Set<Marker> markers = {
    Marker(
      markerId: MarkerId("0"),
      position: LatLng(37.42796133580664, -122.085749655962),
    )
  };

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  List<CategoryData> categories = [];
  late AnimationController animationController;

  void initAnimationController(TickerProvider vsync) {
    animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    );
  }

  void changeTabIndex(int index) {
    tabIndex = index;
    notifyListeners();
  }

  void loadCategories() {
    List<CategoryData> categoryList = [];
    categoryList.addAll(CategoryData.categories);
    categories = categoryList;
    notifyListeners();
  }

  chooseDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: selectData ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((value) {
      if (value != null) {
        selectData = value;
        notifyListeners();
      }
    });
  }

  chooseTime(BuildContext context) {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      if (value != null) {
        timeOfDay = value;
        notifyListeners();
      }
    });
  }

  Future<void> addEvent(BuildContext context) async {
    if (eventLat == null) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.enterLocation,
          backgroundColor: Colors.redAccent,
          fontSize: 16,
          textColor: Colors.white);
      return;
    }
    if (selectData == null) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.enterDate,
          backgroundColor: Colors.redAccent,
          fontSize: 16,
          textColor: Colors.white);
      return;
    }
    if (timeOfDay == null) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.enterTime,
          backgroundColor: Colors.redAccent,
          fontSize: 16,
          textColor: Colors.white);
      return;
    }
    if (titleController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.enterTitle,
          backgroundColor: Colors.redAccent,
          fontSize: 16,
          textColor: Colors.white);
      return;
    }
    if (descController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.enterDes,
          backgroundColor: Colors.redAccent,
          fontSize: 16,
          textColor: Colors.white);
      return;
    }

    EventModel data = EventModel(
      title: titleController.text,
      desc: descController.text,
      date: selectData.toString(),
      hour: timeOfDay!.hour,
      minute: timeOfDay!.minute,
      categoryId: CategoryData.categories[tabIndex].id,
      categoryName: CategoryData.categories[tabIndex].name,
      categoryImage: CategoryData.categories[tabIndex].image,
      lat: eventLat!.latitude,
      long: eventLat!.longitude,
    );

    await FirebaseDatabase.addEvent(data);
    Navigator.pop(context);
  }

  Future<void> updateEvent() async {
    eventModel!.title = titleController.text;
    eventModel!.desc = descController.text;
    eventModel!.date = selectData.toString();
    eventModel!.hour = timeOfDay!.hour;
    eventModel!.minute = timeOfDay!.minute;
    eventModel!.categoryId = CategoryData.categories[tabIndex].id;
    eventModel!.categoryName = CategoryData.categories[tabIndex].name;
    eventModel!.categoryImage = CategoryData.categories[tabIndex].image;
    eventModel!.lat = eventLat!.latitude;
    eventModel!.long = eventLat!.longitude;

    return FirebaseDatabase.updateEvent(eventModel!);
  }

  void initData(EventModel event) {
    loadCategories();
    eventModel = event;
    titleController.text = event.title;
    descController.text = event.desc;
    eventLat = LatLng(event.lat, event.long);
    selectData = DateTime.parse(event.date);
    timeOfDay = TimeOfDay(hour: event.hour, minute: event.minute);
    tabIndex =
        categories.indexWhere((element) => element.id == event.categoryId);
    notifyListeners();
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
    loc.LocationData locationData = await location.getLocation();
    cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      zoom: 17,
    );
    markers.add(
      Marker(
        markerId: MarkerId("0"),
        position:
            LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      ),
    );
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();
    locationMassage =
        "You Are At ${locationData.latitude} : ${locationData.longitude}";
    notifyListeners();
  }

  void locationLise() {
    location.changeSettings(accuracy: loc.LocationAccuracy.high);
    location.onLocationChanged.listen((event) {
      changeLocation(event);
    });
  }

  void changeLocation(loc.LocationData locationData) {
    cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      zoom: 17,
    );
    markers.add(
      Marker(
        markerId: MarkerId("0"),
        position:
            LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      ),
    );
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
    if (permission == loc.PermissionStatus.denied) {
      permission = await location.requestPermission();
    }
    return permission == loc.PermissionStatus.granted;
  }

  void changeNewLocation(LatLng newLocation) {
    eventLat = newLocation;
    notifyListeners();
  }
}
