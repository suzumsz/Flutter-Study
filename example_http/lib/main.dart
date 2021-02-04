import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _getPostsResult;
  String _userId;
  String _id;
  String _title;
  String _body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            //GET /posts
            FlatButton(onPressed: _getPosts,
              child: Text(
                'GET /posts',
              ),
              color: Colors.blue,
              textColor: Colors.white,
            ),
            Text(
              _getPostsResult != null ? _getPostsResult : '',
            ),

            //GET /posts/1
            FlatButton(onPressed: _getPosts1,
              child: Text(
                'GET /posts/1',
              ),
              color: Colors.blue,
              textColor: Colors.white,
            ),
            Text(
              _userId != null ? 'userId: $_userId' : '',
            ),
            Text(
              _id != null ? 'id: $_id' : '',
            ),
            Text(
              _title != null ? 'title: $_title' : '',
            ),
            Text(
              _body != null ? 'body: $_body' : '',
            ),
          ],
        ),
      ),
    );
  }

  //GET /posts
  void _getPosts() async {
    var url = 'https://jsonplaceholder.typicode.com/posts';

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      //var itemCount = jsonResponse['totalItems'];
      //print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

    //GET /posts/1
    void _getPosts1() async {
      var url = 'https://jsonplaceholder.typicode.com/posts/1';

      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        var userId = jsonResponse['userId'];
        var id = jsonResponse['id'];
        var title = jsonResponse['title'];
        var body = jsonResponse['body'];

        if(userId != null && id != null && title != null && body != null)
          setState(() {
            _userId = userId.toString();
            _id = id.toString();
            _title = title.toString();
            _body = body.toString();
          });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }

}