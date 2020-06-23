import 'package:e_grocery/services/auth.dart';
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
  bool isLoading = false;
  bool visible = false;
  bool isEmail = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  forgetpass() async {
    
      await authService.resetPass(useremailEditingController.text);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 55.0),
              child: Form(
                child: ListView(
                  children: [
                    TextFormField(
                      style: simpleTextStyle(),
                      controller: useremailEditingController,
                      validator: (val){
                        if (!EmailValidator.validate(val)) {
                          return 'Please enter a valid email';
                        } else {
                          setState(() {
                            isEmail = true;
                          });
                        }
                      },
                      decoration: textFieldInputDecoration("Enter your E-mail",
                          iconic: Icons.mail),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    visible
                        ? new Row(
                            children: <Widget>[
                              Text(
                                "Mail Sent. Please Check your inbox",
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
                        
                          forgetpass();
                          setState(() {
                            visible = true;
                          });
                        
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
