import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailer/database/merchar_imageHelper.dart';
import 'package:retailer/models/image_sqflite_M.dart';
import 'package:retailer/screens/public/widget.dart';
import 'package:retailer/screens/user/sign_up.dart';
import 'package:retailer/screens/user/syncData/syncData.dart';
import 'package:retailer/services/functional_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../style/theme.dart' as Style;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ImageDbHelper imageDbHelper = ImageDbHelper();
  List<Photo> photoList;
  @override
  void initState(){
    super.initState();
    _checkDate();
  }
  _checkDate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String _date = preferences.getString('Date');
    if(_date == null){
      print('date was null');
      print(getDate);
      preferences.setString("Date", getDate);
    }else{
      print("here is date $_date");
      var date = DateTime.now();
      DateFormat dateFormat = DateFormat("yyyyMMdd");
      String sampleDate = dateFormat.format(date);

      if(_date == sampleDate){
        print("didn't delete database");
      }else{
        print('delete database');
        this.imageDbHelper.deleteAllPhoto();
        setState(() {
          photoList.remove(photoList);
        });
      }
    }
}

  final _formKey = GlobalKey<FormState>();
  var width;
  TextEditingController userIdController = TextEditingController();
  TextEditingController passController = TextEditingController();
  ViewModelFunction model;

  String userIdErr;
  String passErr;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<ViewModelFunction>(context);
    width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        return back();
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  PopupMenuButton<dynamic>(
                    offset: Offset(10, 10),
                    onSelected: (value) => onMenuSelection(value),
                    icon: Icon(Icons.more_vert, color: Colors.black),
                    itemBuilder: (BuildContext contex) {
                      return [
                        PopupMenuItem<PopupMenuChoices>(
                          height: 30,
                          enabled: false,
                          child: Center(
                              child: Text(
                            'Setting',
                            style: TextStyle(color: Colors.black),
                          )),
                        ),
                        PopupMenuDivider(
                          height: 2,
                        ),
                        PopupMenuItem<PopupMenuChoices>(
                          height: 50,
                          value: PopupMenuChoices.url,
                          child: Container(
                            child: Row(
                              children: [
                                Text(
                                  "URL",
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: width * 0.2,
                                  ),
                                  child: Icon(Icons.keyboard_arrow_right),
                                )
                              ],
                            ),
                          ),
                        ),
                        PopupMenuItem<PopupMenuChoices>(
                          enabled: false,
                          height: 30,
                          child: Container(
                            child: Row(
                              children: [
                                Text(
                                  "Version 1.2.43",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/login.png',
                        height: MediaQuery.of(context).size.height / 3,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Login Now',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Please sign in to continue',
                        style: TextStyle(color: Colors.black)),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (val) {
                        String pattern = r'(^(?:[+]9)?[0-9]{3,12}$)';
                        RegExp regExp = new RegExp(pattern);
                        setState(() {
                          if (val.length == 0) {
                            userIdErr = 'please fill Phone number';
                          } else if (!regExp.hasMatch(val)) {
                            userIdErr = 'Invalid Phone number';
                          }
                        });

                        return null;
                      },
                      style: TextStyle(),
                      controller: userIdController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorText: userIdErr,
                        labelText: 'User Id',
                        labelStyle: TextStyle(fontSize: 15),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(
                            15,
                          ),
                          child: ImageIcon(
                            AssetImage('assets/icon/id.png'),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          userIdErr = null;
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
                            passErr = 'please fill Password';
                          }
                        });
                        return null;
                      },
                      style: TextStyle(),
                      controller: passController,
                      decoration: InputDecoration(
                        errorText: passErr,
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
                          passErr = null;
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Center(
                          child: Text(
                        'Forgot Password?',
                        style: Style.headingPrimaryTextStyle,
                      )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FlatButton(
                      color: Style.Colors.mainColor,
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onPressed: () async {
                        _formKey.currentState.validate();
                        if (userIdErr == null && passErr == null) {
                          getConectivity().then((ConnectivityResult value) async {
                            if (value == ConnectivityResult.none) {
                              getToast(context, "Check your internet Conection");
                            } else {
                              await check().timeout(Duration(seconds: 10),
                                  onTimeout: () {
                                getToast(context, "Internet connection error !.");
                                Navigator.pop(context, true);
                              });
                            }
                          });
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
                          'Don\'t have an account? ',
                          style: TextStyle(),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => SignUpPage()));
                          },
                          child: Text(
                            ' Sign up',
                            style: Style.headingPrimaryTextStyle,
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> back() {
    exit(0);
  }

  check() async {
    loading(
      context,
    );
    String formatPhone = getPhoneFormat(userIdController.text);
    await model.login(formatPhone, this.passController.text);
    if (model.statusCode == 200) {
      if (model.getLoginDetail != null) {
        if (model.getLoginDetail.orgId != "" &&
            model.getLoginDetail.orgId != null &&
            model.getLoginDetail.userId != '' &&
            model.getLoginDetail.userType == "saleperson" ||
            model.getLoginDetail.userType == "storeowner") {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SyncData()));
        } else {
          getToast(context, 'Invalid User ID (or) Password');
          Navigator.pop(context, true);
        }
      } else {
        getToast(context, 'Invalid User ID (or) Password');
        Navigator.pop(context, true);
      }
    } else if (model.statusCode == 404) {
      getToast(context, 'Invalid URL !. Please check your URL');
      Navigator.pop(context, true);
    } else if (model.statusCode == 401 ||
        model.statusCode == 403 ||
        model.statusCode == 500 ||
        model.statusCode == 502) {
      getToast(context, 'Server error !. Try again later');
      Navigator.pop(context, true);
    } else if (model.statusCode == 0) {
      getToast(context, 'Internet connection error !.');
      Navigator.pop(context, true);
    } else {
      getToast(context, "Server error !. Try again later");
      Navigator.pop(context, true);
    }
  }

  onMenuSelection(PopupMenuChoices value) async {
    switch (value) {
      case PopupMenuChoices.url:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ChangeUrlPage();
          }),
        );
        break;
      default:
    }
  }
}

enum PopupMenuChoices { url }

class ChangeUrlPage extends StatefulWidget {
  @override
  _ChangeUrlPageState createState() => _ChangeUrlPageState();
}

class _ChangeUrlPageState extends State<ChangeUrlPage> {
  final _fomkey = GlobalKey<FormState>();
  TextEditingController urlController = TextEditingController();
  SharedPreferences preferences;
  bool enable = false;
  String urlErr;

  @override
  Widget build(BuildContext context) {
    if (urlController.text.isEmpty) {
      getUrl();
    }
    return WillPopScope(
      onWillPop: () {
        return back();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('URL'),
          centerTitle: true,
        ),
        body: Form(
          key: _fomkey,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                Text(
                  'URL',
                  style: TextStyle(color: enable ? Colors.black : Colors.grey),
                ),
                TextFormField(
                  onTap: () {
                    setState(() {
                      this.urlErr = null;
                    });
                  },
                  validator: (val) {
                    if (val.length == 0) {
                      setState(() {
                        urlErr = 'Please fill url';
                      });
                    }
                    return null;
                  },
                  enabled: enable,
                  style: TextStyle(color: enable ? Colors.black : Colors.grey),
                  controller: urlController,
                  decoration: InputDecoration(
                    errorText: urlErr,
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Style.Colors.mainColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Style.Colors.mainColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Style.Colors.mainColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                    color: Style.Colors.mainColor,
                    onPressed: () {
                      setState(() {
                        if (enable == false) {
                          enable = true;
                        } else if (enable == true) {
                          _fomkey.currentState.validate();
                          preferences.setString("mainUrl", urlController.text);
                          getUrl();
                          if (urlErr == null) {
                            getToast(context, "update successful");
                            Navigator.pop(context, true);
                          }
                        }
                      });
                    },
                    child: Center(
                      child: Text(
                        enable ? 'Save' : 'Update',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        );
      }

  Future<bool> back() async {
    bool ba;
    _fomkey.currentState.validate();
    setState(() {
      if (enable == false) {
        ba = true;
      } else if (enable == true) {
        if (urlErr == null && urlController.text != null) {
          ba = true;
        } else if (urlErr != null && urlController.text == null) {
          ba = false;
        }
      }
    });
    return ba;
  }

  getUrl() async {
    preferences = await SharedPreferences.getInstance();
    urlController.text =
        preferences.getString('mainUrl') ?? 'http://52.255.142.115:8084/madbrepository/';
  }
}
