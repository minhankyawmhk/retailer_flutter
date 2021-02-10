import 'package:flutter/material.dart';

class Colors {
  static const Color mainColor = const Color(0xFFe53935);
  static const Color dropBackgroundColor = const Color(0xFFBDBDBD);
  static const Color iconColor = const Color(0xFF999999);
  static const Color textColor = const Color(0xFFFFFFFF);

  static const Color incdecCartCountColor = const Color.fromRGBO(0, 0, 0, 0.12);

  static const Color borderColor = const Color.fromRGBO(4, 4, 4, 0.1);

  //----------- Shop Complete status ----------------------
  static const Color successColor = const Color(0xFF888888);
}

//---------- Text Style -------------------------
final TextStyle headingTextStyle = TextStyle(
  fontSize: 15.0,
  height: 1.2,
  fontWeight: FontWeight.w500,
  color: Color(0xFF222222),
);

final TextStyle headingPrimaryTextStyle = TextStyle(
  fontSize: 15.0,
  height: 1.2,
  fontWeight: FontWeight.w500,
  color: Colors.mainColor,
);

final TextStyle secondTextStyle = TextStyle(
  fontSize: 13.0,
  height: 1.5,
  color: Color(0xFF222222),
);

final TextStyle secondBoldTextStyle = TextStyle(
  fontSize: 13.0,
  height: 1.5,
  fontWeight: FontWeight.w500,
  color: Color(0xFF222222),
);

final TextStyle whiteTextStyle = TextStyle(
  fontSize: 14.0,
  color: Color(0xFFFFFFFF),
);

final TextStyle statusSuccessTextStyle = TextStyle(
  fontSize: 12.0,
  color: Color(0xFF08d608),
);

final TextStyle statustmpTextStyle = TextStyle(
  fontSize: 12.0,
  color: Color(0xFFFF0000),
);

final TextStyle statuspendingTextStyle = TextStyle(
  fontSize: 12.0,
  color: Color(0xFFdcdc20),
);
