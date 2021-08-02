import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'RecipeList.dart';

class AddRecipeScreen extends StatefulWidget {
  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  Color primarycolor = Color(0xff006083);
  Color secondarycolor = Color(0xff00828d);
  Color logocolor = Color(0xff87c4bc);

  TextEditingController nameController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  TextEditingController ingredientController = TextEditingController();
  TextEditingController instructionController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  Map<String, dynamic> recipeToAdd;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("recipe");

  addRecipe() {
    recipeToAdd = {
      "name": nameController.text,
      "calories": caloriesController.text,
      "ingredient": ingredientController.text,
      "instruction": instructionController.text,
      "imageUrl": imageUrlController.text,
    };

    collectionReference
        .add(recipeToAdd)
        .whenComplete(() => print('Recipe are added'));
  }

  _buildTextField(TextEditingController controller, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: secondarycolor, border: Border.all(color: Colors.blue)),
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
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: secondarycolor, border: Border.all(color: Colors.blue)),
        child: TextField(
          controller: controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.white),
              border: InputBorder.none),
          maxLines: 7,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recipe',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Color(0xff00467F),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.folder_open,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListRecipeScreen()));
              })
        ],
      ),
      backgroundColor: primarycolor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: new BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                child: Text(
                  "",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _buildTextField(nameController, 'Name'),
              SizedBox(
                height: 20,
              ),
              _buildTextField(caloriesController, 'Calories'),
              SizedBox(
                height: 20,
              ),
              _buildMultipleField(ingredientController, 'Ingredient'),
              SizedBox(
                height: 20,
              ),
              _buildMultipleField(instructionController, 'Instruction'),
              SizedBox(
                height: 20,
              ),
              _buildTextField(imageUrlController, 'Image Url'),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Add Recipe'),
                ),
                color: logocolor,
                onPressed: () {
                  if (nameController.text.length < 1) {
                    displayToastMessage(
                        "Name of the meals are required", context);
                  } else if (caloriesController.text.length < 1)
                    displayToastMessage(
                        "Calories of the meals are required", context);
                  else if (ingredientController.text.length < 1)
                    displayToastMessage(
                        "Ingredient of the meals are required", context);
                  else if (instructionController.text.length < 1)
                    displayToastMessage(
                        "Instruction of the meals are required", context);
                  else if (imageUrlController.text.length < 1)
                    displayToastMessage(
                        "url of the image are required", context);
                  else {
                    addRecipe();
                    displayToastMessage("Recipe added successfully", context);
                    nameController.clear();
                    caloriesController.clear();
                    instructionController.clear();
                    ingredientController.clear();
                    imageUrlController.clear();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
