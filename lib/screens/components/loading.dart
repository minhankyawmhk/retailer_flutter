// import 'package:flutter/material.dart';
// import '../../style/theme.dart' as Style;

// class LoadingScreen extends StatefulWidget {
//   _LoadingScreenState loadingState = new _LoadingScreenState();
//   @override
//   _LoadingScreenState createState() => _LoadingScreenState();
//   _onLoading2() {
//     loadingState._onLoading1();
//   }

//   var hello = "hello";
// }

// class _LoadingScreenState extends State<LoadingScreen> {
//   void _onLoading1() {
//     showDialog(
//       context: context,
//       barrierColor: Colors.black12,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Dialog(
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           child: new Center(
//   child: new CircularProgressIndicator(
//       // backgroundColor: Colors.black12,
//       valueColor:
//           AlwaysStoppedAnimation<Color>(Style.Colors.mainColor)),
// ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
