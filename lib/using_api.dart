import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutterinfinitescrolling/recipe_response.dart';

import 'package:http/http.dart' as http;

class DataWIthAPIRoute extends StatefulWidget {
  DataWIthAPIRoute();

  @override
  DataWIthAPIRouteState createState() =>
      DataWIthAPIRouteState(
      );
}


class DataWIthAPIRouteState extends State<DataWIthAPIRoute> {

  DataResponse recipeResponse;

  var _pairList = <Recipe>[];
  Future myFuture;
  ScrollController _scrollController = ScrollController(
  );

  @override
  void initState() {
    super.initState(
    );

    // assign this variable your Future
    myFuture = getRecipeData(
    );
    _scrollController.addListener(
            () {
          print(
              _scrollController.position.pixels );
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            print(
                "inside" );
            print(
                _scrollController.position.pixels );
            getMoreRecipeData(
            );
          }
        } );
  }

  @override
  void dispose() {
    _scrollController.dispose(
    );
    super.dispose(
    );
  }

  Future<List<Recipe>> getRecipeData() async {
    final response = await http.get(
        'http://58.84.34.65:9090/api/recipe/list/?limit=10' );
    final dataResponse = dataResponseFromJson(
        response.body );
    print(
        dataResponse.results[0].recipeTitle );
    setState(
            () {
          _pairList = dataResponse.results;
          recipeResponse = dataResponse;
        } );
    print(
        recipeResponse.next );
    print(
        recipeResponse.count );
    return dataResponse.results;
  }

  Future<List<Recipe>> getMoreRecipeData() async {
    print(
        recipeResponse.next );
    if (recipeResponse.next != null || recipeResponse.next != "") {
      final response = await http.get(
          recipeResponse.next );
      final dataResponse = dataResponseFromJson(
          response.body );
      print(
          dataResponse.results[0].recipeTitle );
      setState(
              () {
            _pairList.addAll(
                dataResponse.results );
            recipeResponse = dataResponse;
          } );
      print(
          recipeResponse.next );
      print(
          recipeResponse.count );
      print(
          "_pairList count" );
      print(
          _pairList.length );


      return dataResponse.results;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(
              'Load Data' ),
        ),
        body: futureWidget(
        ),
      ),
    );
  }

  Widget futureWidget() {
    return new FutureBuilder<List<Recipe>>(
      future: myFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          return new ListView.builder(
            controller: _scrollController,
            itemExtent: 80,
            itemCount: _pairList.length,
            //_hasMore ? _pairList.length : _pairList.length,
            //_pairList.length,//snapshot.data.length ,
            // _hasMore ? snapshot.data.length + 1 : snapshot.data.length,
            itemBuilder: (context, i) {
              return ListTile(
                title: Text(
                    snapshot.data[i].recipeTitle.toString(
                    ) ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return new Text(
              "${snapshot.error}" );
        }
        return Center(
            child: new CircularProgressIndicator(
            ) );
      },
    );
  }

  Future _getMoreData() async {


  }

}

class Network {
  final String url;

  Network(this.url);

  Future fetchData() async {
    print(
        url );
    http.Response response = await http.get(
        Uri.encodeFull(
            url ) );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(
          response.statusCode );
    }
  }
}

class _ItemFetcher {
  final _count = 103;
  final _itemsPerPage = 5;
  int _currentPage = 0;

  // This async function simulates fetching results from Internet, etc.
  Future<List<Recipe>> fetch() async {
    final list = <Recipe>[];
//    final n = min(_itemsPerPage, _count - _currentPage * _itemsPerPage);
//    // Uncomment the following line to see in real time now items are loaded lazily.
//    // print('Now on page $_currentPage');
//    await Future.delayed(Duration(seconds: 1), () {
//      for (int i = 0; i < n; i++) {
//        list.add(WordPair.random());
//      }
//    });
    final response = await http.get(
        'http://58.84.34.65:9090/api/recipe/list/?limit=30' );
    final dataResponse = dataResponseFromJson(
        response.body );
    print(
        dataResponse.results[0].recipeTitle );

    return dataResponse.results;
    _currentPage++;
    return list;
  }
}
