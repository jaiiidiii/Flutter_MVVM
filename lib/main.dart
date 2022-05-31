import 'package:flutter/material.dart';
import 'package:flutter_mvvm/view_models/movie_list_view_model.dart';
import 'package:flutter_mvvm/views/dashboard_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moview List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: ChangeNotifierProvider(
          create: (context) => MoviesListViewModel(),
          child: const DashboardPage()),
    );
  }
}
