import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retailer/screens/main/main-screen.dart';
import 'package:retailer/screens/public/widget.dart';
import 'package:retailer/services/functional_provider.dart';
import 'package:retailer/style/theme.dart' as Style;

class SyncData extends StatefulWidget {
  @override
  _SyncDataState createState() => _SyncDataState();
}

class _SyncDataState extends State<SyncData> {
  ViewModelFunction model;
  String _selectedType = 'Download';
  bool _isloading = false;
  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<ViewModelFunction>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Data'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 45,
                color: Style.Colors.mainColor,
                child: Center(
                  child: Text(
                    'Sync',
                    style: Style.whiteTextStyle,
                  ),
                ),
              ),
              _isloading
                  ? Padding(
                      padding:
                          EdgeInsets.only(right: 8, top: 8, left: 8, bottom: 8),
                      child: Center(
                        child: new Stack(
                            fit: StackFit.passthrough,
                            children: <Widget>[
                              Container(
                                height: 20,
                                child: LinearProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Style.Colors.mainColor),
                                  backgroundColor: Colors.grey[300],
                                  value: _value,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Align(
                                  alignment: Alignment.lerp(Alignment.topLeft,
                                      Alignment.topRight, _value * 0.5),
                                  child: Text(
                                    (_value * 100).toStringAsFixed(0) + '%',
                                    style: Style.whiteTextStyle,
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    )
                  : Container(),
              InkWell(
                onTap: () {
                  showToSelected();
                },
                child: Container(
                    margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Type',
                              style: Style.headingTextStyle,
                            ),
                            Spacer(),
                            Text(
                              _selectedType,
                              style: Style.headingTextStyle,
                            ),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey[400],
                        )
                      ],
                    )),
              ),
              IgnorePointer(
                ignoring: _isloading,
                child: Container(
                  margin: EdgeInsets.all(8),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: RaisedButton(
                    color:
                        _isloading ? Colors.red[300] : Style.Colors.mainColor,
                    onPressed: () async {
                      if (_isloading == false) {
                        getConectivity().then((ConnectivityResult value) async {
                          if (value == ConnectivityResult.none) {
                            getToast(context, "Check your internet Conection");
                          } else {
                            await syncDataFunction()
                                .timeout(Duration(seconds: 15), onTimeout: () {
                              getToast(context, "Internet connection error !.");
                              setState(() {
                                _isloading = false;
                                this._value = 0.0;
                                Navigator.pop(context, true);
                              });
                            });
                          }
                        });
                      } else {
                        return null;
                      }
                    },
                    child: Center(
                      child: Text(
                        'Start',
                        style: Style.whiteTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future syncDataFunction() async {
    setState(() {
      _isloading = true;
    });

    await model.getMainList();
    await model.getStockList();
    await Future.doWhile(() async {
      await Future.delayed(Duration(milliseconds: 1));
      setState(() {
        _value += 0.01;
      });
      if (_value >= 1) {
        return false;
      }
      return true;
    }).timeout(Duration(seconds: 5));
    setState(() {
      _isloading = false;
      _value = 0.0;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
    });
  }

  showToSelected() {
    return showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return new Align(
          alignment: Alignment(0.9, -0.4),
          child: Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: Container(
              width: 200,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 40,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedType = 'Download';
                            Navigator.pop(context, true);
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Download',
                              style: Style.headingTextStyle,
                              textAlign: TextAlign.center,
                            ),
                            Spacer(),
                            _selectedType == 'Download'
                                ? Icon(
                                    Icons.radio_button_checked,
                                    color: Style.Colors.mainColor,
                                  )
                                : Icon(
                                    Icons.radio_button_off,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    Spacer(),
                    Container(
                      height: 40,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedType = 'Upload';
                            Navigator.pop(context, true);
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Upload',
                              style: Style.headingTextStyle,
                              textAlign: TextAlign.center,
                            ),
                            Spacer(),
                            _selectedType == 'Upload'
                                ? Icon(
                                    Icons.radio_button_checked,
                                    color: Style.Colors.mainColor,
                                  )
                                : Icon(
                                    Icons.radio_button_off,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
