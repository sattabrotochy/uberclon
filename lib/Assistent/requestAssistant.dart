
import 'dart:convert';

import 'package:http/http.dart' as http;





class RequestAssistant{

static Future<dynamic> getRequest(String url)async
{
  try{
    http.Response response=await http.get(url);
    if(response.statusCode==200)
    {
      String jsonData= response.body;

      var decodeData=jsonDecode(jsonData);
      return decodeData;
    }
    else
    {
      return "failed";
    }
  }
  catch(e)
  {
    return "failed";

  }
  }

}