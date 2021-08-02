import 'package:adminapp/ADMIN/Recipe.dart';
import 'package:adminapp/ADMIN/Video/Myvideo.dart';
import 'package:adminapp/ADMIN/adminLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Admin Home Page'),
          backgroundColor: Color(0xff00467F),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: Container(
          width: 450,
          height: 760,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xFF005AA7), Color(0xFFFdfdfd)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Stack(
            children: <Widget>[
              Container(
                height: 250.0,
                width: 400.0,
                margin: EdgeInsets.only(top: 50.0, left: 15),

                decoration: new BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(4.0, 4.0),
                    )
                  ],
                  image: DecorationImage(
                    image: AssetImage('images/ADMINRECIPE.PNG'),
                    fit: BoxFit.fill,
                  ),
                ),
                // ignore: deprecated_member_use
                child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddRecipeScreen()),
                      );
                    },
                    child: null),
              ),
              Positioned(
                top: 320,
                child: Container(
                  width: 400,
                  height: 250,
                  margin: EdgeInsets.only(top: 30.0, left: 15),

                  decoration: new BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(4.0, 4.0),
                      )
                    ],
                    image: DecorationImage(
                      image: AssetImage('images/ADMINVIDEO.PNG'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyVideo()),
                        );
                      },
                      child: null),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
