import 'package:flutter/material.dart';
import 'package:lecture/presentation/home/home_screen.dart';
import 'package:lecture/presentation/lectures_total/lectures_total_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecture/presentation/web_view/web_veiw.dart';

import 'presentation/home/home_bloc/home_bloc.dart';
import 'presentation/qr/qr_screen.dart';
import 'symbols/screen_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (BuildContext context) => HomeBloc()..add(CoursesFetched()),
      child: MaterialApp(
        title: 'Lecture',
        initialRoute: ScreenList.home,
        onGenerateRoute: (settings) {
          if (settings.name == ScreenList.home) {
            return MaterialPageRoute(builder: (context) {
              return HomeScreen();
            });
          } else if (settings.name == ScreenList.lecturesTotal) {
            return MaterialPageRoute(builder: (context) {
              var argument = settings.arguments;
              if (argument is LectureTotalScreenArgument) {
                return LectureTotalScreen(
                  isFree: argument.isFree,
                  isRecommended: argument.isRecommended,
                  title: argument.title,
                );
              }
              throw ("Type of argument must be LectureTotalScreenArgument");
            });
          } else if (settings.name == ScreenList.qr) {
            return MaterialPageRoute(builder: (context) {
              return QRScreen();
            });
          } else if (settings.name == ScreenList.webView) {
            return MaterialPageRoute(builder: (context) {
              return WebViewScreen(url: settings.arguments as String);
            });
          }
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
