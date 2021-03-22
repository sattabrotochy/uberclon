import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/Assistent/requestAssistant.dart';
import 'package:uber_clone/ConfigMap/configmaps.dart';
import 'package:uber_clone/Models/address.dart';
import 'package:uber_clone/Provider/data_handler.dart';

class assistantMethods{

  static Future<String> searchCoordinatesAddress(Position position,context)async

  {

    String placeAddress='';
    String url="https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&${mapkey}";

    var response=await RequestAssistant.getRequest(url);
    if(response !="failed")
      {
        placeAddress=response['results'][0]['formatted_address'];

        Address userPickUpAddress;
        userPickUpAddress.longitude=position.longitude;
        userPickUpAddress.latitude=position.latitude;
        userPickUpAddress.placeName=placeAddress;
        Provider.of<AppData>(context,listen: false).updatePickUpLocation(userPickUpAddress);

      }
    else{
      return placeAddress;
    }
  }

}