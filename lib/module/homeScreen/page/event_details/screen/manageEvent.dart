import 'package:evently/core/maneger/firebase/model/eventfiremodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../core/app_theme/app_color.dart';
import '../../../../../core/constant/categoryData.dart';
import '../../../../../core/constant/customBottom.dart';
import '../../../../../core/maneger/provider/app_provider.dart';
import '../../../../../core/routes/app_routes_name.dart';
import '../../../widget/custom_text_field.dart';
import '../../floating_event_screen/provider_event/event_provider.dart';

class ManageEvent extends StatefulWidget {
  final EventModel? eventModel;

  ManageEvent({super.key, required this.eventModel});

  @override
  State<ManageEvent> createState() => _ManageEventState();
}

class _ManageEventState extends State<ManageEvent> {
  EventProvider eventProvider = EventProvider();

  @override
  void initState() {
    eventProvider.loadCategories();
    super.initState();
    if (widget.eventModel != null) {
      eventProvider.initData(widget.eventModel!);
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);

    return ChangeNotifierProvider.value(
      value: eventProvider,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          iconTheme: IconThemeData(color: theme.primaryColor),
          backgroundColor: provider.themeMode == ThemeMode.dark
              ? theme.scaffoldBackgroundColor
              : Colors.transparent,
          centerTitle: true,
          title: Text(
            eventProvider.eventModel == null
                ? AppLocalizations.of(context)!.addEvent
                : AppLocalizations.of(context)!.editEvent,
            style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
        ),
        body: Consumer<EventProvider>(
          builder: (context, value, child) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      CategoryData.categories[value.tabIndex].image,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DefaultTabController(
                    length: CategoryData.categories.length,
                    child: Consumer<EventProvider>(
                      builder: (context, value, child) {
                        return TabBar(
                          onTap: (index) => value.changeTabIndex(index),
                          labelColor: AppColor.white,
                          isScrollable: true,
                          unselectedLabelColor: theme.primaryColor,
                          indicatorColor: Colors.transparent,
                          indicatorPadding: const EdgeInsets.all(4),
                          dividerColor: Colors.transparent,
                          tabAlignment: TabAlignment.start,
                          tabs: CategoryData.categories.map((e) {
                            int currentIndex =
                                CategoryData.categories.indexOf(e);
                            return Tab(
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: value.tabIndex == currentIndex
                                      ? theme.primaryColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(26),
                                  border: Border.all(color: theme.primaryColor),
                                ),
                                child: Row(
                                  children: [
                                    Icon(e.icon,
                                        color: value.tabIndex == currentIndex
                                            ? AppColor.white
                                            : theme.primaryColor),
                                    const SizedBox(width: 4),
                                    Text(
                                      e.name,
                                      style: TextStyle(
                                        color: value.tabIndex == currentIndex
                                            ? AppColor.white
                                            : theme.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.title,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: value.titleController,
                    title: AppLocalizations.of(context)!.eventTitle,
                    prefixIcon: Icons.edit_note_outlined,
                    borderColor: provider.themeMode == ThemeMode.dark
                        ? theme.primaryColor
                        : AppColor.gray,
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.des,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    child: CustomTextField(
                      borderColor: provider.themeMode == ThemeMode.dark
                          ? theme.primaryColor
                          : AppColor.gray,
                      controller: value.descController,
                      title: AppLocalizations.of(context)!.eventDes,
                      maxLin: null,
                      minLin: null,
                      isExda: true,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.date_range_outlined),
                      const SizedBox(width: 10),
                      Text(AppLocalizations.of(context)!.eventDat,
                          style: theme.textTheme.bodyMedium),
                      Spacer(),
                      InkWell(
                        onTap: () => value.chooseDate(context),
                        child: Text(
                          value.selectData == null && value.eventModel == null
                              ? AppLocalizations.of(context)!.chooseDa
                              : value.selectData == null
                                  ? value.eventModel?.date ?? ""
                                  : DateFormat("dd-MM-yyyy")
                                      .format(value.selectData!),
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: theme.primaryColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.access_time_outlined),
                      const SizedBox(width: 10),
                      Text(AppLocalizations.of(context)!.eventTime,
                          style: theme.textTheme.bodyMedium),
                      const Spacer(),
                      InkWell(
                        onTap: () => value.chooseTime(context),
                        child: Text(
                          value.timeOfDay == null && value.eventModel == null
                              ? AppLocalizations.of(context)!.chooseTime
                              : value.timeOfDay == null
                                  ? DateFormat("hh:mm a").format(
                                      DateTime(0, 1, 1, value.eventModel!.hour,
                                          value.eventModel!.minute),
                                    )
                                  : DateFormat("hh:mm a").format(
                                      DateTime(0, 1, 1, value.timeOfDay!.hour,
                                          value.timeOfDay!.minute),
                                    ),
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: theme.primaryColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.location,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RoutesName.positionLocation,
                            arguments: value);
                      },
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 1, color: theme.primaryColor),
                          padding: EdgeInsets.all(8),
                          foregroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(
                                  width: 1, color: theme.primaryColor))),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Icon(
                              Icons.gps_fixed,
                              color: theme.scaffoldBackgroundColor,
                              size: 25,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                            value.eventLat == null
                                ? AppLocalizations.of(context)!.chooseLocation
                                : "Location,${value.eventLat!.latitude},${value.eventLat!.longitude}",
                            style: theme.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.primaryColor,
                              fontSize: 20,
                            ),
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: theme.primaryColor,
                            size: 25,
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  CustomBottom(
                      text: value.eventModel == null
                          ? AppLocalizations.of(context)!.addEvent
                          : AppLocalizations.of(context)!.editEvent,
                      onTab: () {
                        if (value.eventModel == null) {
                          value.addEvent(context);
                        } else {
                          value.updateEvent();
                        }
                        Navigator.pop(context);
                      }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
