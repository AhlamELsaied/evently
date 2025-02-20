import 'package:evently/core/app_theme/app_asstes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CategoryData{
  String id;
  String name;
  String image;
  final IconData icon;
  CategoryData({required this.id,required this.name,required this.image ,required this.icon});

   static List<CategoryData>categories=[
    CategoryData(id: "sport", name: "Sport", image: AppAssets.sport,icon:Icons.directions_bike_outlined),
    CategoryData(id: "birthday", name: "Birthday", image: AppAssets.birthday,icon:Icons.cake_outlined),
    CategoryData(id: "book", name: "BookClub", image: AppAssets.book,icon:Icons.menu_book_outlined),
    CategoryData(id: "meeting", name: "Meeting", image: AppAssets.meeting,icon:Icons.meeting_room_outlined),
    CategoryData(id: "eating", name: "Eating", image: AppAssets.eating,icon:Icons.fastfood_outlined),
    CategoryData(id: "work", name: "WorkShop", image: AppAssets.work,icon:Icons.work),
    CategoryData(id: "holiday", name: "Holiday", image: AppAssets.holiday,icon:Icons.holiday_village_rounded),
    CategoryData(id: "gaming", name: "Gaming", image: AppAssets.gaming,icon:Icons.games_outlined),
    CategoryData(id: "exhibition", name: "Exhibition", image: AppAssets.exh,icon:Icons.show_chart_outlined),

  ];



}