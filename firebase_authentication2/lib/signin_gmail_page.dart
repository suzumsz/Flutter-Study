import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignInGmailPage extends StatefulWidget {
  final String title = 'Gmail 인증';

  @override
  State<StatefulWidget> createState() => _SignInGmailPageState();
}

class _SignInGmailPageState extends State<SignInGmailPage>{

  bool _success;
  String _userId;
  String _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return FlatButton(
              child: const Text('로그아웃'),
              textColor: Theme.of(context).buttonColor,
              onPressed: () async{
                final User user = await _auth.currentUser;
                if (user == null) {
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('로그인 정보가 없습니다.'),
                    ),
                  );
                  return;
                }else {
                  await _auth.signOut();
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('로그아웃 되었습니다.'),
                    ),
                  );
                };
              },
            );
          }),
        ],
      ),
      body: Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: const Text(
                  'Gmail 인증',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.center,
              ),

              //사용자 로그인 처리
              Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
                child: SignInButtonBuilder(
                  icon: Icons.person_add,
                  backgroundColor: Colors.blue,
                  onPressed: (){
                    _signIn();
                  },
                  text: '사용자 로그인',
                ),
              ),

              //사용자 등록 처리 결과
              Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Text(_success == null
                        ? ''
                        : (_success
                        ? '사용자 로그인에 성공하였습니다.\n 아이디: '+_userId
                        : '사용자 로그인에 실패하였습니다'
                    )
                    ),
                    SizedBox(height: 16,),
                    Text(_error == null
                        ? ''
                        : _error
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //사용자 로그인 처리
  void _signIn() async {
    try {
      UserCredential userCredential;
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final GoogleAuthCredential googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      userCredential = await _auth.signInWithCredential(googleAuthCredential);
      final user =  userCredential.user;

      if (user != null){
        setState(() {
          _success = true;
          _userId = user.uid;
        });
      }else{
        setState(() {
          _success = false;
        });
      }

    } catch (e) {
      print(e);
      setState(() {
        _error = e.toString();
        _success = false;
      });
    }
  }
}

