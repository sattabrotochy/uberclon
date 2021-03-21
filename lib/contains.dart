import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

final String SIGN_IN = 'loginscrenn';
final String SIGN_UP = 'registartionscreen';
final String Home_page = 'mainscreen';

DisplayToastMessage(String message, BuildContext context) {
  Toast.show(message, context,
      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
}
