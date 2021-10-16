
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/pages/home/home_page.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _input = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xff40e0d0),
                Color(0xffff8c00),
                Color(0xffff0080)
              ],
          ),
        ),
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lock_outline, size: 80, color: Colors.black.withOpacity(0.4),),
                        Text("LOGIN", style: Theme.of(context).textTheme.headline1,),
                        Text("Enter PIN to login", style: Theme.of(context).textTheme.bodyText2,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for(int i=0;i<_input.length;++i)
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    width: 25.0,
                                    height: 25.0,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                              for(int i=0;i<6-_input.length;++i)
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    width: 25.0,
                                    height: 25.0,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black.withOpacity(0.4)
                                    ),
                                  ),
                                ),
                            ],),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              [1, 2, 3],
                              [4, 5, 6],
                              [7, 8, 9],
                              [-2, 0, -1],
                            ].map((row) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: row.map((e) => LoginButton(
                                number: e,
                                onClick: () { _handleClickButton(e);},
                              )).toList(),
                            )).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isLoading ? Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.5)
              ),
              child:SafeArea(
                child: SpinKitRing(
                  color: Colors.white,
                  size: 80.0,
                ),
              ),
            ):SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  void _handleClickButton(int num){
    setState(()  {
      if(num == -1){
        if(_input.length > 0)
          _input = _input.substring(0, _input.length - 1);
      }else{
        _input = "$_input$num";
      }
      if(_input.length == 6){
        isLoading = true;
        var url = Uri.parse('https://cpsu-test-api.herokuapp.com/login');
        var response =  http.post(url,
          headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'pin': _input,
          }),
        );
        response.then((value) {
          if(value.statusCode == 200){
            Map<String, dynamic> jsonBody = json.decode(value.body);
            if(jsonBody['data'])
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            else
              _showMaterialDialog("ERROR !", "Invalid PIN. Please try again.");

            setState(() {
              isLoading = false;
            });
          }
        });
        _input = '';
      }
    });
    print(_input);
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}

class LoginButton extends StatelessWidget {
  final int number;
  final Function() onClick;

  const LoginButton({
    Key? key,
    required this.number,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: CircleBorder(),
          onTap: number == -2 ? null :
              onClick,
          child: number == -1 ? Container(width: 80.0, height: 80.0,child: Icon(Icons.backspace_outlined, size: 28,)): Container(
            width: 80.0,
            height: 80.0,
            decoration: number == -2 ? null :
            BoxDecoration(
              shape: BoxShape.circle,
              //border: Border.all(width: 2.0, color: Colors.black),
              color: Colors.white.withOpacity(0.15)
            ),
            child: number == -2 ? SizedBox.shrink() :
            Center(child: Text('$number', style: Theme.of(context).textTheme.bodyText1, )
            ),
          ),
        ),
      ),
    );
  }
}
