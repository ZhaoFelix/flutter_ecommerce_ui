import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './src/config/route.dart';
import './src/pages/product_detail.dart';
import './src/widgets/custom_route.dart';
import './src/pages/home_page.dart';
import './src/themes/theme.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce',
      theme: AppTheme.lightTheme.copyWith(
          textTheme: GoogleFonts.muliTextTheme(Theme.of(context).textTheme)),
      debugShowCheckedModeBanner: false,
      routes: Routes.getRoute(),
      onGenerateRoute: (RouteSettings setting) {
        final List<String> pathElements = setting.name.split('/');
        if (pathElements[1].contains('detail')) {
          return CustomRoute<bool>(
              builder: (BuildContext context) => ProductDetailPage());
        }
      },
    );
  }
}
