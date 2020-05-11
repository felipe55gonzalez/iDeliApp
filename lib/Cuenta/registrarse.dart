import 'package:el_gordo/Cuenta/UserIndb.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

bool _isloading = false;

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;
  TextEditingController phoneinputController;

  @override
  initState() {
    firstNameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
    phoneinputController = new TextEditingController();
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

  String pwdValidator(String value) {
    if (value.length < 6) {
      return 'Minimo 6 Caracteres';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Registrarse"),
        ),
        body: cuerpo());
  }

  void signUp(FirebaseUser user) async {
    UserInDb db = new UserInDb();
    try {
      await user.sendEmailVerification();
      await db.insertarUser(user.uid, firstNameInputController.text,
          phoneinputController.text, emailInputController.text, "https://scontent.fntr6-2.fna.fbcdn.net/v/t1.0-9/p960x960/96276824_3258191320860829_191860892101509120_o.jpg?_nc_cat=106&_nc_sid=e007fa&_nc_eui2=AeFObmuiyhxKr6eYn-xmTgj6LyZ1ZVaXz18vJnVlVpfPX0Dnsv3jkI4czi0IpqCGIGlH2YVaeyh_QkX1LmgKJTPb&_nc_ohc=SaA3tApBF6gAX8FajIU&_nc_ht=scontent.fntr6-2.fna&_nc_tp=6&oh=83ffa5b7ec71e2e38a6b39fb65519595&oe=5EDDF046");
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Verificacion"),
              content: Text("Se te ah enviado un correo de verificacion"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Regresar"),
                  onPressed: () async {
                    _isloading = false;
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                )
              ],
            );
          });
    } catch (e) {
      print("error");
      print(e.message);
    }
  }

  Widget _showCircularProgress() {
    return Center(child: CircularProgressIndicator());
  }

  Widget cuerpo() {
    if (_isloading) {
      return _showCircularProgress();
    } else {
      return Container(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Form(
            key: _registerFormKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Nombre*', hintText: "Tu Nombre y Apellido"),
                  controller: firstNameInputController,
                  validator: (value) {
                    if (value.length < 5) {
                      return "Nombre.";
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Correo*', hintText: "Ejemplo@gmail.com"),
                  controller: emailInputController,
                  keyboardType: TextInputType.emailAddress,
                  validator: emailValidator,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Celular*', hintText: "8777777"),
                  controller: phoneinputController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value.length < 10) {
                      return "Numero no valido";
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Contraseña*', hintText: "********"),
                  controller: pwdInputController,
                  obscureText: true,
                  validator: pwdValidator,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Confirma tu contraseña*',
                      hintText: "********"),
                  controller: confirmPwdInputController,
                  obscureText: true,
                  validator: pwdValidator,
                ),
                RaisedButton(
                  child: Text("Registrarse"),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    notificarNum();
                  },
                ),
                Text("¿Ya tienes Cuenta?"),
                FlatButton(
                  child: Text("!Inicia sesion Aqui¡"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          )));
    }
  }

  Future<void> createuser() async {
    if (_registerFormKey.currentState.validate()) {
      if (pwdInputController.text == confirmPwdInputController.text) {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailInputController.text,
                  password: pwdInputController.text)
              .then((currentuser) => {signUp(currentuser.user)});
        } on PlatformException catch (exception) {
          switch (exception.code) {
            case 'ERROR_EMAIL_ALREADY_IN_USE':
              showerrorDialog();
              break;
          }
        }
        
      } else {
        print("Las contraseñas no coinciden");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("Las contraseñas no coinciden"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Cerrar"),
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                        _isloading = false;
                      });
                    },
                  )
                ],
              );
            });
      }
    }
  }

  void showerrorDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(
                "Ha ocurrido un error verifica tus datos, este mensaje puede aparecer cuando el correo que intentas registrar ya esta en uso"),
            actions: <Widget>[
              FlatButton(
                child: Text("Volver"),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              )
            ],
          );
        });
  }

  void notificarNum() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Atencion"),
            content: Text(
                "El numero proporcionado debe de ser real, ya que este se usara para contactar al usuario en caso de necesitarlo"),
            actions: <Widget>[
              FlatButton(
                child: Text("Registrar este numero"),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                    _isloading = true;
                    createuser();
                  });
                },
              ),
              FlatButton(
                child: Text("Cambiar el Numero"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
