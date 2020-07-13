import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermestutos/screens/contacts.dart';
import 'package:fluttermestutos/screens/discussions.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
   int _currentIndx =0;
   final List<Widget> _children = [Discussions(),Contacts()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children[_currentIndx],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          onTap: onTapTabBar,
          currentIndex: _currentIndx,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 40,
                      child: IconButton(
                        icon: Image.asset('assets/images/message.png', fit: BoxFit.fitHeight,),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        height: 21,
                        width: 21,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.5)),
                          color: Colors.redAccent,
                          border: Border.all(color: Colors.black, width: 3),
                        ),
                        child: Center(
                          child: Text(
                            '2',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ),
                      top: 2,
                      right: 0,
                    ),
                  ],
                ),
              ),
              title: Text('Discussions', style: TextStyle(color: Colors.white),),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_add, color: Colors.white,),
              title: Text('Contacts', style: TextStyle(color: Colors.white),),
            )

          ],
        ),
    );
   }

   void onTapTabBar (int value){
    setState(() {
      _currentIndx = value;
    });
   }
}
