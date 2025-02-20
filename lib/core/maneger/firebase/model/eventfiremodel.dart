import 'package:firebase_auth/firebase_auth.dart';

class EventModel {
  String? userId;
  String title;
  String desc;
  String date;
  int hour;
  int minute;
  String categoryId;
  String categoryImage;
  String categoryName;
  String? id;
  bool isFav;
  double lat;
  double long;

  EventModel({
    this.id,
    this.lat = 0,
    this.long = 0,
    this.isFav = false,
    required this.title,
    required this.desc,
    required this.date,
    required this.hour,
    required this.minute,
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
  }) {
    userId = FirebaseAuth.instance.currentUser!.uid;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "desc": desc,
      "date": date,
      "hour": hour,
      "minute": minute,
      "categoryId": categoryId,
      "categoryName": categoryName,
      "categoryImage": categoryImage,
      "isFav": isFav,
      "userId": userId,
      "lat": lat,
      "long": long,
    };
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json["id"],
      title: json["title"],
      desc: json["desc"],
      date: json["date"],
      hour: json["hour"] ?? 0,
      minute: json["minute"] ?? 0,
      isFav: json["isFav"] ?? false,
      categoryId: json["categoryId"],
      categoryName: json["categoryName"],
      categoryImage: json["categoryImage"],
      lat: (json["lat"] ?? 0).toDouble(),
      long: (json["long"] ?? 0).toDouble(),
    );
  }
}
