import 'package:flutter/material.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Future<void> _showMyDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
        title: Text('Hello World'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
            Text('This is a demo alert dialog'),
        ],
        )
        ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('테스트'),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.add_alert),
              onPressed: () {
            print('alert');
              }
          ),
        IconButton(icon: const Icon(Icons.add_alert),
              onPressed: null,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 30,),
            RaisedButton(onPressed: (){
              _showMyDialog();
              print('RaisedButton Clicked');
              },
              child: const Text('Button', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(decoration: BoxDecoration(color:Colors.blue,),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            ),
            ListTile(
                leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                size: 56,
              ),
              title: Text('Profile'),
              subtitle: Text('This is a subtitle'),
            ),
            ListTile(
              leading: Icon(Icons.settings,size: 56,),
              title: Text('Settings'),
              subtitle: Text('This is a subtitle'),
              trailing: Icon(Icons.keyboard_arrow_right,),
            ),
           

          ],
        ),

      ),
       floatingActionButton: FloatingActionButton.extended(
         onPressed: () {
           _showMyDialog();

         },
         icon: Icon(Icons.navigation),
         label: Text('Hello'),
         backgroundColor: Colors.green,
       ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
