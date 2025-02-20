import 'package:evently/core/maneger/firebase/model/eventfiremodel.dart';
import 'package:evently/core/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/app_theme/app_color.dart';
import '../../../core/maneger/provider/app_provider.dart';
import 'layoutScreenProvider.dart';

class CardEvent extends StatelessWidget {
  const CardEvent({super.key, required this.event});

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<AppProvider>(context);
    var providerDa = Provider.of<LayoutscreenProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.eventDetails, arguments: event);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Container(
              height: 230,
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: theme.primaryColor),
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(event.categoryImage),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: provider.themeMode == ThemeMode.dark
                          ? theme.scaffoldBackgroundColor
                          : AppColor.white,
                    ),
                    child: Column(
                      children: [
                        Text(
                          DateFormat("d").format(DateTime.parse(event.date)),
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat("MMM").format(DateTime.parse(event.date)),
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: provider.themeMode == ThemeMode.dark
                          ? theme.scaffoldBackgroundColor
                          : AppColor.white,
                    ),
                    child: Row(
                      children: [
                        Text(
                          event.title,
                          style: theme.textTheme.bodyMedium,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            providerDa.eventFavorite(event);
                          },
                          child: Icon(
                            event.isFav
                                ? Icons.favorite
                                : Icons.favorite_outline_sharp,
                            color: event.isFav ? theme.primaryColor : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
