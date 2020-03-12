import 'package:flutter/material.dart';
import '../pages/main_page.dart';
import '../pages/product_detail.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{'/': (_) => MainPage()};
  }
}
