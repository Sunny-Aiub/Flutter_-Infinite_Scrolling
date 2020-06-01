import 'package:flutter/material.dart';
import 'package:flutterinfinitescrolling/lazy_loading.dart';
import 'package:flutterinfinitescrolling/using_api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lazy Loading',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DataWIthAPIRoute(),//LazyLoadingRoute(),//DataWIthAPIRoute(),
    );
  }
}