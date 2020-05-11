import 'package:el_gordo/Cuenta/modelUserdataDb.dart';
import 'package:flutter/material.dart';

import 'UserIndb.dart';

Data args;
bool isloading = false;

class CheckDataPage extends StatefulWidget {
  CheckDataPage({Key key}) : super(key: key);
  @override
  _CheckDataPageState createState() => _CheckDataPageState();
}

class _CheckDataPageState extends State<CheckDataPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameInputController;
  TextEditingController emailInputController;
  TextEditingController phoneinputController;
  @override
  initState() {
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Formato de Correo incorrecto';
    } else {
      return null;
    }
  }

  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    firstNameInputController = new TextEditingController(text: args.nombre);
    emailInputController = new TextEditingController(text: args.email);
    phoneinputController = new TextEditingController(text: args.telefono);
    return isloading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text("Revisa Tus Datos"),
            ),
            body: Container(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                    child: Form(
                      key: _registerFormKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Nombre*',
                            hintText: "Tu Nombre y Apellido"),
                        controller: firstNameInputController,
                        validator: (value) {
                          if (value.length < 5) {
                            return "Nombre y apellido";
                          }
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Correo*',
                            hintText: "Ejemplo@gmail.com"),
                        controller: emailInputController,
                        keyboardType: TextInputType.emailAddress,
                        validator: emailValidator,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Celular*', hintText: "877777777"),
                        controller: phoneinputController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value.length < 10) {
                            return "Numero no valido";
                          }
                        },
                      ),
                      RaisedButton(
                        child: Text("Guardar"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          if (_registerFormKey.currentState.validate()) {
                            setState(() {
                              isloading = true;
                              insertindb();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ))));
  }

  void insertindb() async {
    UserInDb db = new UserInDb();
    try {
      await db.insertarUser(args.uid, firstNameInputController.text,
          phoneinputController.text, emailInputController.text, args.urlImagen);
          args.email=emailInputController.text;
          args.nombre=firstNameInputController.text;
          args.telefono=phoneinputController.text;
      setState(() {
        isloading = false;
        Navigator.of(context)
            .pushReplacementNamed('/Home', arguments:args);
      });
    } catch (e) {
      print("error");
      print(e.message);
    }
  }
}
