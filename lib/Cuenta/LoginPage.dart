import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
bool _isLoading = false;
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return cuerpo();
  }
    Widget _showCircularProgress() {
    return Center(child: CircularProgressIndicator());
  }
  Widget cuerpo() {

    if (_isLoading) {
      return Container(
          padding: EdgeInsets.all(16.0),
          child: new Form(
              child: new ListView(shrinkWrap: true, children: <Widget>[
            //showlogo(),
            _showCircularProgress(),
          ])));
    } else {
      return Container(
          padding: EdgeInsets.all(16.0),
          child: new Form(
            child: new ListView(
              shrinkWrap: true,
              children: <Widget>[
                //showlogo(),
                showEmailInput(),
                showPasswordInput(),
                SignInButton(
                  Buttons.Email,
                  text: "Iniciar con Correo",
                  onPressed: () {},
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
                          .then((FirebaseUser user) =>
                              {revisarUsario(user)})
                          .catchError((e) => print(e));
                    },
                  )),
                  Expanded(
                      child: SignInButton(
                    Buttons.Facebook,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      // _isLoading = true;
                      // setState(() {});

                      // _facebooklog(context)
                      //     .then((FirebaseUser user) =>
                      //         {revisarUsuario(context, user)})
                      //     .catchError((e) => print(e));
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
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (BuildContext context) => RegisterPage()));
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
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Correo',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Contraseña',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'El campo de contraseña esta vacio' : null,
      ),
    );
  }
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
void revisarUsario(FirebaseUser user){
print (user.uid);
print (user.email);
print(user.phoneNumber);
print(user.displayName);
print(user.phoneNumber);
print(user.photoUrl);

  
}
