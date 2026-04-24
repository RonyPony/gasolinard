import 'package:flutter/cupertino.dart';
import 'package:gasolinard/screens/allFuels.dart/allFuelsScreen.dart';
import 'package:gasolinard/screens/getHistory/historyScreen.dart';
import 'package:gasolinard/screens/home/homeScreen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      HomeScreen.routeName: (context) => const HomeScreen(),
      AllFuelsScreen.routeName: (context) => const AllFuelsScreen(),
      HistoryFuels.routeName: (context) => const HistoryFuels(),
    };
  }
}
