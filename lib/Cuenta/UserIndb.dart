import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'modelUserdataDb.dart';

class UserInDb {
  Future<void> insertarUser(
      String uid, String name, String phone, String email, String urli) async {
    try {
      var url =
          "https://expertsystemsacuna.000webhostapp.com/AcountMagnament/InsertUser.php";
      var response = await http.post(url, body: {
        "uid": uid,
        "email": email,
        "phone": phone,
        "name": name,
        "UrlImagen": urli
      });
      print(response.body);
    } catch (_) {}
  }

  Future<Data> revisarUser(FirebaseUser user) async {
    Data userdata;
    UserDataDb db;
    try {
      var url =
          "https://expertsystemsacuna.000webhostapp.com/AcountMagnament/RevisarUser.php";
      var response = await http.post(url, body: {
        "uid": user.uid,
      });
      if (response.body != "0") {
        // print("========ConvertingData======");
        final jsonResponse = json.decode(response.body);
        db = new UserDataDb.fromJson(jsonResponse);
        userdata = db.data[0];
        return userdata;
      } else {
        // print("========New User======");
        // print("========data must be captured======");
        db = new UserDataDb.fromJson({
          "Data": [
            {
              "IdUser": "0",
              "Uid": user.uid,
              "Nombre": user.displayName,
              "email": user.email,
              "Telefono": user.phoneNumber,
              "UrlImagen": user.photoUrl
            }
          ]
        });
        userdata = db.data[0];
        //print("===========default data wrote===========");
        return userdata;
      }
    } catch (_) {}
  }
    Future<FirebaseUser> isUsersignedin() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
print("revisandousuario");
    if (user != null) {
      print("logeado");
      return user;

    } else {
       print("nologeado");
      return user;

    }
  }
  
  revisarUsariologeado(FirebaseUser user,BuildContext context) async {
    this.revisarUser(user).then((data) {
      if (data.idUser != "0") {

        Navigator.of(context).pushReplacementNamed('/Home', arguments: data);
      } else {

        Navigator.of(context).pushReplacementNamed('/Data', arguments: data);
      }
    });
  }
}
