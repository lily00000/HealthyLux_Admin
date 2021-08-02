import 'package:flutter/material.dart';

import 'Recipe.dart';

class AdminLoginn extends StatefulWidget {
  @override
  _AdminLoginn createState() => _AdminLoginn();
}

class _AdminLoginn extends State<AdminLoginn> {
  final String code = "Admintesting123";
  TextEditingController myController = TextEditingController();

  showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminLoginn()),
        );
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text("Invalid code, please re-enter again."),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  adminLogin() {
    if (myController.text == code) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddRecipeScreen()),
      );
    } else {
      showAlertDialog(context);
    }
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Admin Login'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              TextFormField(
                controller: myController,
                obscureText: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Admin Code",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Enter Admin Code",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
              RaisedButton(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  onPressed: adminLogin,
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.orange),
            ],
          ),
        ),
      ),
    );
  }
}
