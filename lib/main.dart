import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:evently/core/app_theme/app_theme.dart';
import 'package:evently/core/maneger/provider/app_provider.dart';
import 'package:evently/core/routes/app_routes.dart';
import 'package:evently/core/routes/app_routes_name.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppProvider appProvider = AppProvider();
  await appProvider.initProvider();
  runApp(MyApp(appProvider));
}

class MyApp extends StatelessWidget {
  final AppProvider appProvider;

  const MyApp(this.appProvider, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: appProvider,
      child: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: provider.themeMode,
            routes: AppRoutes.routes,
            initialRoute: RoutesName.splash,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            locale: Locale(provider.lan),
          );
        },
      ),
    );
  }
}
