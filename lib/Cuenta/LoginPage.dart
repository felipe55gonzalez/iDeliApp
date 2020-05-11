import 'package:el_gordo/Cuenta/UserIndb.dart';
import 'package:el_gordo/Cuenta/registrarse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'modelUserdataDb.dart';

bool _isLoading = false;
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;
UserDataDb userData;
UserInDb userIndb = new UserInDb();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  Widget build(BuildContext context) {
    return cuerpo();
  }

  Widget _showCircularProgress() {
    return Center(child: CircularProgressIndicator());
  }

  Widget cuerpo() {
    print(_isLoading);
    if (_isLoading) {
      return Container(
          padding: EdgeInsets.all(16.0),
          child: new Form(
              child: new ListView(shrinkWrap: true, children: <Widget>[
            showlogo(),
            _showCircularProgress(),
          ])));
    } else {
      return Container(
          padding: EdgeInsets.all(16.0),
          child: new Form(
            child: new ListView(
              shrinkWrap: true,
              children: <Widget>[
                showlogo(),
                showEmailInput(),
                showPasswordInput(),
                SignInButton(
                  Buttons.Email,
                  text: "Iniciar con Correo",
                  onPressed: () {
                    emailsingIn(
                            emailInputController.text, pwdInputController.text)
                        .then((FirebaseUser user) {
                      if (user.uid != null) {
                        revisarUsario(user);
                      }
                    });
                  },
                ),
                Row(
                  children: <Widget>[
                    Expanded(child: Divider()),
                    Text(
                      "Conectarse Con",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                Row(children: <Widget>[
                  Expanded(
                      child: SignInButton(
                    Buttons.Google,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    text: "Gmail",
                    onPressed: () {
                      _isLoading = true;
                      setState(() {});

                      googlelogin()
                          .then((FirebaseUser user) => {revisarUsario(user)})
                          .catchError((e) => print(e));
                    },
                  )),
                  Expanded(
                      child: SignInButton(
                    Buttons.Facebook,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      _isLoading = true;
                      setState(() {});

                      _facebooklog(context)
                          .then((FirebaseUser user) => {revisarUsario(user)})
                          .catchError((e) => print(e));
                    },
                    text: "Facebook",
                  ))
                ]),
                Row(
                  children: <Widget>[
                    Expanded(child: Divider()),
                    Text(
                      "O",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SignInButton(
                  Buttons.Email,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => RegisterPage()));
                  },
                  text: "Registrarse con Correo",
                )
              ],
            ),
          ));
    }
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: emailInputController,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Correo',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Campo vacio' : null,
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        controller: pwdInputController,
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Contraseña',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) =>
            value.isEmpty ? 'El campo de contraseña esta vacio' : null,
      ),
    );
  }

  Future<FirebaseUser> _facebooklog(BuildContext context) async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        AuthCredential fbCredential = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);
        FirebaseUser user =
            (await _auth.signInWithCredential(fbCredential)).user;
        return user;
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("cancelado");
        break;
      case FacebookLoginStatus.error:
        print(result.errorMessage.toString());
        break;
    }
  }

  Future<FirebaseUser> emailsingIn(String email, String password) async {
    try {
      FirebaseUser user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      assert(user != null);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      return user;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_USER_NOT_FOUND':
        showerrorDialog("Usuario no encontrado");
        break;
      case 'ERROR_WRONG_PASSWORD':
        showerrorDialog("La contraseña es incorrecta");
        break;
    }
  }

  void showerrorDialog(String error) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(error),
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

  Future<FirebaseUser> googlelogin() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    print(googleUser.toString());
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    print(googleAuth.toString());
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print(credential.toString());
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;

    return user;
  }

  revisarUsario(FirebaseUser user) async {
    userIndb.revisarUser(user).then((data) {
      if (data.idUser != "0") {
        print("========recievedData======");
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushReplacementNamed('/Home', arguments: data);
      } else {
        print("===========opening check data page===========");
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushReplacementNamed('/Data', arguments: data);
      }
    });
  }
}

Widget showlogo() {
  return Container(
    height: 100,
    decoration: BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage('assets/images/logo.png'),
      ),
    ),
  );
}
