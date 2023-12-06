
import 'package:calculator/views/calculator_view.dart';

class AppRoute {
  AppRoute._();
  static const String calcRoute = "/";

  static getApplicationRoute() {
    return {
      calcRoute: (context) => CalculatorView(),
    };
  }
}
