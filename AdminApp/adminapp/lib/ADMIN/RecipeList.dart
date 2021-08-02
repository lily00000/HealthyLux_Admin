import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class ListRecipeScreen extends StatefulWidget {
  @override
  _ListRecipeScreenState createState() => _ListRecipeScreenState();
}

class _ListRecipeScreenState extends State<ListRecipeScreen> {
  Color primarycolor = Color(0xff006083);
  Color secondarycolor = Color(0xff00828d);
  Color logocolor = Color(0xff87c4bc);

  TextEditingController nameController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  TextEditingController ingredientController = TextEditingController();
  TextEditingController instructionController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  _buildTextField(TextEditingController controller, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: primarycolor, border: Border.all(color: Colors.blue)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            border: InputBorder.none),
      ),
    );
  }

  _buildMultipleField(TextEditingController controller, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: primarycolor, border: Border.all(color: Colors.blue)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            border: InputBorder.none),
        maxLines: 8,
      ),
    );
  }

  CollectionReference ref = FirebaseFirestore.instance.collection("recipe");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Recipe List',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Color(0xff00467F),
        elevation: 0,
      ),
      backgroundColor: primarycolor,
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  var doc = snapshot.data.docs[index];
                  return Container(
                    child: Container(
                      width: 180,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24.0),
                        child: ListTile(
                          leading: IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.white,
                            onPressed: () {
                              nameController.text = doc['name'];
                              caloriesController.text = doc['calories'];
                              ingredientController.text = doc['ingredient'];
                              instructionController.text = doc['instruction'];
                              imageUrlController.text = doc['imageUrl'];
                              showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                        child: Container(
                                          color: primarycolor,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListView(
                                              children: <Widget>[
                                                _buildTextField(
                                                    nameController, 'Name'),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                _buildTextField(
                                                    caloriesController,
                                                    'Calories'),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                _buildMultipleField(
                                                    ingredientController,
                                                    'Ingredient'),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                _buildMultipleField(
                                                    instructionController,
                                                    'Instruction'),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                _buildTextField(
                                                    imageUrlController,
                                                    'Image Url'),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                FlatButton(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      child:
                                                          Text('Update Recipe'),
                                                    ),
                                                    color: logocolor,
                                                    onPressed: () {
                                                      if (nameController
                                                              .text.length <
                                                          1) {
                                                        displayToastMessage(
                                                            "Name of the meals are required",
                                                            context);
                                                      } else if (caloriesController
                                                              .text.length <
                                                          1)
                                                        displayToastMessage(
                                                            "Calories of the meals are required",
                                                            context);
                                                      else if (ingredientController
                                                              .text.length <
                                                          1)
                                                        displayToastMessage(
                                                            "Ingredient of the meals are required",
                                                            context);
                                                      else if (instructionController
                                                              .text.length <
                                                          1)
                                                        displayToastMessage(
                                                            "Instruction of the meals are required",
                                                            context);
                                                      else if (imageUrlController
                                                              .text.length <
                                                          1)
                                                        displayToastMessage(
                                                            "url of the image are required",
                                                            context);
                                                      else {
                                                        snapshot
                                                            .data
                                                            .docs[index]
                                                            .reference
                                                            .update({
                                                          "name": nameController
                                                              .text,
                                                          "calories":
                                                              caloriesController
                                                                  .text,
                                                          "ingredient":
                                                              ingredientController
                                                                  .text,
                                                          "instruction":
                                                              instructionController
                                                                  .text,
                                                          "imageUrl":
                                                              imageUrlController
                                                                  .text,
                                                        }).whenComplete(() =>
                                                                Navigator.pop(
                                                                    context));
                                                      }
                                                    }),
                                                SizedBox(
                                                  height: 20.0,
                                                ),
                                                FlatButton(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Text(
                                                      'Delete Recipe',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  color: Colors.red,
                                                  onPressed: () async {
                                                    final res =
                                                        await showDialog(
                                                            context: context,
                                                            builder: (_) =>
                                                                _AlertDialog());
                                                    if (res) {
                                                      snapshot.data.docs[index]
                                                          .reference
                                                          .delete()
                                                          .whenComplete(() =>
                                                              Navigator.pop(
                                                                  context));
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                            },
                          ),
                          title: Text(
                            doc['name'],
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            children: <Widget>[],
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                          trailing: Image.network(
                            doc['imageUrl'],
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } else
            return Text('');
        },
      ),
    );
  }
}

class _AlertDialog extends StatelessWidget {
  const _AlertDialog({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Confirmation'),
      content: Text('Do you wanted to delete this recipe'),
      actions: [
        FlatButton(
          child: Text("Yes"),
          onPressed: () => Navigator.pop(context, true),
        ),
        FlatButton(
          child: Text("No"),
          onPressed: () => Navigator.pop(context, false),
        ),
      ],
    );
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
