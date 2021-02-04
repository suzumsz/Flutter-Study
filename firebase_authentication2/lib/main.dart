import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import './register_page.dart';
import './signin_email_password_page.dart';
import './signin_anonymously_page.dart';
import './signin_Gmail_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase 인증',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Firebase 인증'),
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
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          //사용자 등록 화면으로 넘어가는 버튼
          Container(
            child: SignInButtonBuilder(
              padding: const EdgeInsets.all(10),
              icon: Icons.person_add,
              backgroundColor: Colors.indigo,
              text: '사용자 등록',
              onPressed: () {
                _pushPage(context, RegisterPage());

              },
            ),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
          ),

          //사용자 로그인(이메일, 비밀번호 인증) 화면으로 넘어가는 버튼
          Container(
            child: SignInButtonBuilder(
              padding: const EdgeInsets.all(10),
              icon: Icons.email,
              backgroundColor: Colors.deepPurple,
              text: '사용자 로그인\n이메일, 비밀번호 인증',
              onPressed: () {
                _pushPage(context, SignInEmailPasswordPage());

              },
            ),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
          ),

          //사용자 로그인(Anonymously 인증) 화면으로 넘어가는 버튼
          Container(
            child: SignInButtonBuilder(
              padding: const EdgeInsets.all(10),
              icon: Icons.android,
              backgroundColor: Colors.brown,
              text: '사용자 로그인\nAnonymously 인증',
              onPressed: () {
                _pushPage(context, SignInAnonymouslyPage());

              },
            ),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
          ),

          //사용자 로그인(gmail 인증) 화면으로 넘어가는 버튼
          Container(
            child: SignInButtonBuilder(
              padding: const EdgeInsets.all(10),
              icon: Icons.verified_user,
              backgroundColor: Colors.teal,
              text: '사용자 로그인\nGmail 인증',
              onPressed: () {
                _pushPage(context, SignInGmailPage());

              },
            ),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  void _pushPage(BuildContext context, Widget page){
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}

