import 'package:flutter/cupertino.dart';

class Address {
  String placeFormattedAddress;
  String placeName;
  double latitude;
  double longitude;

  Address(
      {@required this.placeFormattedAddress,
      @required this.placeName,
      @required this.latitude,
      @required this.longitude});
}
