import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retailer/screens/public/widget.dart';
import 'package:retailer/screens/user/login.dart';
import 'package:retailer/services/functional_provider.dart';

class PasswordWidget extends StatefulWidget {
  @override
  _PasswordWidgetState createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass = TextEditingController();

  TextEditingController comfirmPass = TextEditingController();
  String currentErr;
  String newPassErr;
  String comfirmPassErr;
  final _formKey = GlobalKey<FormState>();

  ViewModelFunction model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<ViewModelFunction>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              validator: (val) {
                if (val.length == 0) {
                  setState(() {
                    currentErr = "Please fill current password";
                  });
                }
                return null;
              },
              onTap: () {
                setState(() {
                  currentErr = null;
                });
              },
              controller: currentPass,
              decoration: InputDecoration(
                  errorText: currentErr, labelText: 'Current Password'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              onTap: () {
                setState(() {
                  newPassErr = null;
                });
              },
              validator: (val) {
                if (val.length == 0) {
                  setState(() {
                    newPassErr = "Please fill new password";
                  });
                }
                return null;
              },
              controller: newPass,
              decoration: InputDecoration(
                  errorText: newPassErr, labelText: 'New Password'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              onTap: () {
                setState(() {
                  comfirmPassErr = null;
                });
              },
              validator: (val) {
                if (val.length == 0 || newPass.text != comfirmPass.text) {
                  setState(() {
                    comfirmPassErr = "password don't match";
                  });
                }
                return null;
              },
              controller: comfirmPass,
              decoration: InputDecoration(
                  errorText: comfirmPassErr, labelText: 'Confirm Password'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Text('Save'),
              onPressed: () async {
                _formKey.currentState.validate();
                if (this.currentErr == null &&
                    this.newPassErr == null &&
                    this.comfirmPassErr == null) {
                  await model.resetPassword(currentPass.text, comfirmPass.text);
                  if (model.statusCode == 200) {
                    if (model.status == "SUCCESS!") {
                      getToast(context,
                          "Password reset successful !. Please login agian");

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    }
                    if (model.status == "FAIL") {
                      getToast(context, " Incorrect password ");
                    }
                  } else if (model.statusCode != 200) {
                    getToast(context, "Server error !. Try again later");
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
