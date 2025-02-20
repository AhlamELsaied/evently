import 'package:evently/module/homeScreen/page/floating_event_screen/provider_event/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDate extends StatelessWidget {
  final String time;
  final String date;

  CustomDate({super.key, required this.date, required this.time});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.primaryColor),
        borderRadius: BorderRadius.circular(16),
        color: theme.scaffoldBackgroundColor,
      ),
      child: Row(
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
              Icons.calendar_month_outlined,
              size: 32,
              color: theme.scaffoldBackgroundColor,
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(time),
            ],
          )
        ],
      ),
    );
  }
}
