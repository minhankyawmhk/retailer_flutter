import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retailer/screens/public/widget.dart';
import 'package:retailer/screens/user/login.dart';
import 'package:retailer/services/functional_provider.dart';
import '../../style/theme.dart' as Style;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String nameError;
  String phoneError;
  String passError;
  String comfirmPassError;
  TextEditingController nameController = TextEditingController();
  TextEditingController phNumberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  ViewModelFunction newLoginViewModel;

  TextEditingController comfirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    newLoginViewModel = Provider.of<ViewModelFunction>(context);

    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Create Account',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        setState(() {
                          nameError = 'please fill Name';
                        });
                      }
                      return null; // Return null to handle error manually.
                    },
                    style: TextStyle(),
                    controller: nameController,
                    decoration: InputDecoration(
                      errorText: nameError,
                      labelText: 'Name',
                      labelStyle: TextStyle(fontSize: 15),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(
                          15,
                        ),
                        child: ImageIcon(
                          AssetImage('assets/icon/user.png'),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        nameError = null;
                      });
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (val) {
                      String pattern = r'(^(?:[+]9)?[0-9]{3,12}$)';
                      RegExp regExp = new RegExp(pattern);
                      setState(() {
                        if (val.length == 0) {
                          phoneError = 'please fill Phone number';
                        } else if (!regExp.hasMatch(val)) {
                          phoneError = 'Invalid Phone number';
                        }
                      });

                      return null;
                    },
                    style: TextStyle(),
                    controller: phNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorText: phoneError,
                      labelText: 'Phone number',
                      labelStyle: TextStyle(fontSize: 15),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(
                          15,
                        ),
                        child: ImageIcon(
                          AssetImage('assets/icon/contact.png'),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        phoneError = null;
                      });
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (val) {
                      setState(() {
                        if (val.length == 0) {
                          passError = 'please fill Password';
                        }
                      });

                      return null;
                    },
                    style: TextStyle(),
                    controller: passwordController,
                    decoration: InputDecoration(
                      errorText: passError,
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: 15),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(
                          15,
                        ),
                        child: ImageIcon(
                          AssetImage('assets/icon/lock.png'),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        passError = null;
                      });
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (val) {
                      setState(() {
                        if (val.length == 0) {
                          comfirmPassError = 'please fill Comfirm password';
                        } else if (comfirmpasswordController.text !=
                            passwordController.text) {
                          comfirmPassError = "Password don't match";
                        }
                      });

                      return null;
                    },
                    style: TextStyle(),
                    controller: comfirmpasswordController,
                    decoration: InputDecoration(
                      errorText: comfirmPassError,
                      labelText: 'Comfirm password',
                      labelStyle: TextStyle(fontSize: 15),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(
                          15,
                        ),
                        child: ImageIcon(
                          AssetImage('assets/icon/lock.png'),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        comfirmPassError = null;
                      });
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FlatButton(
                    color: Style.Colors.mainColor,
                    child: Center(
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () async {
                      _formKey.currentState.validate();
                      if (nameError == null &&
                          phoneError == null &&
                          passError == null &&
                          comfirmPassError == null) {
                        check();
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(color: Colors.black),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: Text(
                          ' Login now',
                          style: Style.headingPrimaryTextStyle,
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  check() async {
    loading(
      context,
    );

    String formatPhone = getPhoneFormat(phNumberController.text);
    await newLoginViewModel.signUp(
        nameController.text, formatPhone, passwordController.text);

    if (newLoginViewModel.statusCode == 200) {
      if (newLoginViewModel.signUpDetail != null) {
        if (newLoginViewModel.signUpDetail == "SUCCESS") {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login()));
        } else if (newLoginViewModel.signUpDetail == "IDEXIST") {
          getToast(context, 'User Id already exist');
          Navigator.pop(context, true);
        } else if (newLoginViewModel.signUpDetail == "Fail") {
          getToast(context, 'Saving Fail');
          Navigator.pop(context, true);
        }
      } else {
        getToast(context, 'Saving Fail');
        Navigator.pop(context, true);
      }
    } else if (newLoginViewModel.statusCode == 404) {
      getToast(context, 'Invalid URL !. Please check your URL');
      Navigator.pop(context, true);
    } else if (newLoginViewModel.statusCode == 401 ||
        newLoginViewModel.statusCode == 403 ||
        newLoginViewModel.statusCode == 500 ||
        newLoginViewModel.statusCode == 502) {
      getToast(context, 'Server error !. Try again later');
      Navigator.pop(context, true);
    } else {
      getToast(context, "Invalid User ID (or) Password");
      Navigator.pop(context, true);
    }
  }
}
