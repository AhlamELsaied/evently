import 'package:evently/core/routes/app_routes_name.dart';
import 'package:evently/module/homeScreen/page/event_details/screen/manageEvent.dart';
import 'package:evently/module/homeScreen/page/event_details/screen/event_Deta.dart';
import 'package:evently/module/homeScreen/page/floating_event_screen/pages/event_screen.dart';
import 'package:evently/module/homeScreen/page/floating_event_screen/provider_event/event_provider.dart';
import 'package:evently/module/homeScreen/page/screen/positionLocationScreen.dart';
import 'package:evently/module/login_screen/page/createAccountScreen.dart';
import 'package:evently/module/login_screen/page/login_screen.dart';
import 'package:evently/module/login_screen/page/password.dart';
import 'package:evently/module/onboarding/page/first_screen.dart';
import 'package:evently/module/onboarding/page/onboarding_screen.dart';
import 'package:evently/module/splash/screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import '../../module/homeScreen/page/screen/layout_Screen.dart';
import '../maneger/firebase/model/eventfiremodel.dart';
//end

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    RoutesName.splash: (_) => SplashScreen(),
    RoutesName.firstScreen: (_) => FirstScreen(),
    RoutesName.onboarding: (_) => OnboardingScreen(),
    RoutesName.login: (_) => LoginScreen(),
    RoutesName.createAccount: (_) => CreateAccountScreen(),
    RoutesName.password: (_) => PasswordScreen(),
    RoutesName.layout: (_) => LayoutScreen(),
    RoutesName.event: (context) => EventScreen(),
    RoutesName.positionLocation: (context) {
      var proivder =
          ModalRoute.of(context)?.settings.arguments as EventProvider;
      return PositionLocationScreen(
        provider: proivder,
      );
    },
    RoutesName.eventDetails: (context) {
      final event = ModalRoute.of(context)!.settings.arguments as EventModel;
      return EventDetails(event: event);
    },
    RoutesName.addEvent: (context) {
      final event = ModalRoute.of(context)!.settings.arguments as EventModel;
      return ManageEvent(eventModel: event);
    },
  };
}
