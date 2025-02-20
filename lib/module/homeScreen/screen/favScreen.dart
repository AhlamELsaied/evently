import 'package:evently/module/homeScreen/widget/custom_text_field.dart';
import 'package:evently/module/homeScreen/widget/card_event.dart';
import 'package:evently/module/homeScreen/widget/layoutScreenProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/maneger/provider/app_provider.dart';

class FavScreen extends StatefulWidget {
  FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  void initState() {
    Provider.of<LayoutscreenProvider>(context, listen: false)
        .getFavEventStream();

    super.initState();
  }

  final TextEditingController ff = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var providerP = Provider.of<AppProvider>(context);
    return Consumer<LayoutscreenProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              AppLocalizations.of(context)!.fav,
              style: theme.textTheme.bodyLarge!.copyWith(
                  color: theme.primaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2, left: 16, right: 16),
                child: CustomTextField(
                  prefixIcon: Icons.search_outlined,
                  title: AppLocalizations.of(context)!.searchForEvent,
                  borderColor: theme.primaryColor,
                  onChanged: (e) {
                    provider.search(e);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.favEvents.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      child: CardEvent(event: provider.favEvents[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
