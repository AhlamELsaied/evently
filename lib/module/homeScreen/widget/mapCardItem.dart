import 'package:evently/core/app_theme/app_color.dart';
import 'package:evently/core/maneger/firebase/model/eventfiremodel.dart';
import 'package:flutter/material.dart';
//end

class MapCardItem extends StatelessWidget {
  final EventModel eventModel;
  final Function(double, double) onPress;

  const MapCardItem(
      {super.key, required this.eventModel, required this.onPress});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        onPress(eventModel.lat, eventModel.long);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColor.lightBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColor.primaryColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 138 / 74,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  eventModel.categoryImage,
                  height: double.infinity,
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventModel.title,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColor.black,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Text(
                      "${eventModel.lat.floor()}:${eventModel.long.floor()}",
                      maxLines: 1,
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: theme.primaryColor),
                    ))
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
