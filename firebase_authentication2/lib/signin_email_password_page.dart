import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_builder.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignInEmailPasswordPage extends StatefulWidget {
  final String title = '이메일, 비밀번호 인증';

  @override
  State<StatefulWidget> createState() => _SignInEmailPasswordPageState();
}

class _SignInEmailPasswordPageState extends State<SignInEmailPasswordPage>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _success;
  String _userEmail;
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
      body: Form(
        key: _formKey,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                //이메일 입력폼
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: '이메일',
                  ),
                  validator: (String value){
                    if (value.isEmpty){
                      return '이메일을 입력하세요';
                    }
                    return null;
                  },
                ),

                //비밀번호 입력폼
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: '비밀번호',
                  ),
                  validator: (String value){
                    if (value.isEmpty){
                      return '비밀번호를 입력하세요';
                    }
                    return null;
                  },
                  obscureText: true,
                ),

                //사용자 등록 버튼
                Container(
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: SignInButtonBuilder(
                    icon: Icons.person_add,
                    backgroundColor: Colors.blue,
                    onPressed: (){
                      if (_formKey.currentState.validate()){
                        _signIn();
                      }
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
                          ? '사용자 로그인에 성공하였습니다.\n 이메일: '+_userEmail
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
      ),

    );
  }
  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //사용자 로그인 처리
  void _signIn() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      )).user;

      if (user != null){
        setState(() {
          _success = true;
          _userEmail = user.email;
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