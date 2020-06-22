import 'package:e_grocery/helper/helperfunctions.dart';
import 'package:e_grocery/helper/theme.dart';
import 'package:e_grocery/services/auth.dart';
import 'package:e_grocery/services/database.dart';
import 'package:e_grocery/views/chatrooms.dart';
import 'package:e_grocery/views/forgot_password.dart';
import 'package:e_grocery/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn(this.toggleView);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();

  AuthService authService = new AuthService();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  signIn() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signInWithEmailAndPassword(
              emailEditingController.text, passwordEditingController.text)
          .then((result) async {
        if (result != null) {
          QuerySnapshot userInfoSnapshot =
              await DatabaseMethods().getUserInfo(emailEditingController.text);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.documents[0].data["userName"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.documents[0].data["userEmail"]);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        } else {
          setState(() {
            isLoading = false;
            //show snackbar
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Container(
              padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 55.0),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    
                    TextFormField(
                      style: simpleTextStyle(),
                      controller: emailEditingController,
                      decoration: textFieldInputDecoration("E-mail",iconic:Icons.mail),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (!EmailValidator.validate(val)) {
                          return 'Please enter a valid email';
                        }
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      style: simpleTextStyle(),
                      decoration: textFieldInputDecoration("Password",iconic:Icons.lock),
                      controller: passwordEditingController,
                      validator: (val) {
                        return val.length < 8
                            ? "Enter Password 8+ characters"
                            : null;
                      },
                    ),
                    
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                "Forgot Password?",
                                style: simpleTextStyle(),
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        signIn();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xff007EF4),
                                const Color(0xff2A75BC)
                              ],
                            )),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Sign In",
                          style: biggerTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have account? ",
                          style: simpleTextStyle(),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.toggleView();
                          },
                          child: Text(
                            "Register now",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
