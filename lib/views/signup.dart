import 'package:e_grocery/helper/helperfunctions.dart';
import 'package:e_grocery/services/auth.dart';
import 'package:e_grocery/services/database.dart';
import 'package:e_grocery/views/chatrooms.dart';
import 'package:e_grocery/widget/widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp(this.toggleView);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController usernameEditingController = new TextEditingController();
  TextEditingController mobileEditingController = new TextEditingController();
  TextEditingController pincodeEditingController = new TextEditingController();
  TextEditingController useraddressEditingController =
      new TextEditingController();

  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isShop = false;

  signUp() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signUpWithEmailAndPassword(
              emailEditingController.text, passwordEditingController.text)
          .then((result) {
        if (result != null) {
          Map<String, Object> userDataMap = {
            "userPin": pincodeEditingController.text,
            "userNumber": mobileEditingController.text,
            "userName": usernameEditingController.text,
            "userAddress": useraddressEditingController.text,
            "userEmail": emailEditingController.text,
            "isShop": isShop.toString()
          };

          databaseMethods.addUserInfo(userDataMap);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              usernameEditingController.text);
          HelperFunctions.saveUserEmailSharedPreference(
              emailEditingController.text);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }
      });
    }
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile Number is Required";
    } else if (value.length != 10) {
      return "Mobile Number must be 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be in digits";
    }
    return null;
  }

  String validatepincode(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Pin Code is Required";
    } else if (value.length != 6) {
      return "Pin Code must 6 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Pin Code must be in digits";
    }
    return null;
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
                key: formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      style: simpleTextStyle(),
                      controller: usernameEditingController,
                      validator: (val) {
                        return val.isEmpty || val.length < 3
                            ? "Enter Username 3+ characters"
                            : null;
                      },
                      decoration: textFieldInputDecoration(
                          "Username or Shop Name",
                          iconic: Icons.person),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      style: simpleTextStyle(),
                      controller: emailEditingController,
                      decoration: textFieldInputDecoration("E-mail",
                          iconic: Icons.mail),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (!EmailValidator.validate(val)) {
                          return 'Please enter a valid email';
                        }
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      obscureText: true,
                      style: simpleTextStyle(),
                      decoration: textFieldInputDecoration("Password",
                          iconic: Icons.lock),
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
                    TextFormField(
                      controller: mobileEditingController,
                      style: simpleTextStyle(),
                      decoration: textFieldInputDecoration("Mobile Number",
                          iconic: Icons.phone),
                      keyboardType: TextInputType.phone,
                      validator: validateMobile,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      style: simpleTextStyle(),
                      controller: useraddressEditingController,
                      validator: (val) {
                        return val.isEmpty ? "Enter Address" : null;
                      },
                      decoration: textFieldInputDecoration("Address",
                          iconic: Icons.home),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                        controller: pincodeEditingController,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration("Pin Code",
                            iconic: Icons.location_on),
                        keyboardType: TextInputType.phone,
                        validator: validatepincode),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          child: SizedBox(
                            width: Checkbox.width,
                            height: Checkbox.width,
                            child: Container(
                              decoration: new BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                ),
                                borderRadius: new BorderRadius.circular(5),
                              ),
                              child: Theme(
                                data: ThemeData(
                                  unselectedWidgetColor: Colors.blue,
                                ),
                                child: Checkbox(
                                  value: isShop,
                                  onChanged: (state) {
                                    setState(() {
                                      isShop = !isShop;
                                    });
                                  },
                                  activeColor: const Color(0xff007EF4),
                                  checkColor: Colors.black87,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.padded,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'SignUp as Seller',
                          //style: biggerTextStyle(),
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        signUp();
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
                          "Sign Up",
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
                          "Already have an account? ",
                          style: simpleTextStyle(),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.toggleView();
                          },
                          child: Text(
                            "SignIn now",
                            style: TextStyle(
                                color: Colors.black,
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
