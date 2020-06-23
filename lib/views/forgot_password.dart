import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_grocery/services/auth.dart';
import 'package:e_grocery/services/database.dart';
import 'package:e_grocery/widget/widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

AuthService authService = new AuthService();

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController useremailEditingController =
      new TextEditingController();

  bool visible = false;
  bool visible1 = false;
  QuerySnapshot emailsnap;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  checkData(String email) async {
    Firestore.instance
        .collection("users")
        .where('userEmail', isEqualTo: email)
        .getDocuments()
        .then((snapshot) {
      emailsnap = snapshot;
      print(emailsnap.documents.length);
      if (emailsnap.documents.length != 0) {
        setState(() {
          visible = true;
          visible1 = false;
        });
      } else {
        setState(() {
          visible1 = true;
          visible = false;
        });
      }
    });
  }

  forgetpass() async {
    if (formKey.currentState.validate()) {
      await authService.resetPass(useremailEditingController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarMain(context),
      body: Container(
        padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 55.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                validator: (val) {
                  if (!EmailValidator.validate(val)) {
                    return 'Please enter a valid email';
                  }
                },
                style: simpleTextStyle(),
                controller: useremailEditingController,
                keyboardType: TextInputType.emailAddress,
                decoration: textFieldInputDecoration("Enter your E-mail",
                    iconic: Icons.mail),
              ),
              SizedBox(
                height: 25,
              ),
              visible
                  ? new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "E-mail Sent\nPlease Check your inbox",
                          textAlign: TextAlign.center,
                          style: simpleTextStyle(),
                        )
                      ],
                    )
                  : new Container(),
              visible1
                  ? new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "E-mail ID not found\nPlease check you E-mail ID",
                          textAlign: TextAlign.center,
                          style: simpleTextStyle(),
                        )
                      ],
                    )
                  : new Container(),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  checkData(useremailEditingController.text);
                  forgetpass();
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
                    "Reset Password",
                    style: biggerTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
