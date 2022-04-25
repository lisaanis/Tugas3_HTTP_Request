import 'package:flutter/material.dart';
import 'package:tugas3_httprequest/page_detail_countries.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP Request',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: const PageDetailCountries(),
    );
  }
}
