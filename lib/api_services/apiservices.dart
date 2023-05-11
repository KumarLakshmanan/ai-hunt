import 'dart:convert';

import 'package:http/http.dart' as http;

class Apiservice {
  List toolsdata = [];
  List ainewsdta = [];
  String aiTools =
      "http://api.frontendforever.com/ai/api.php?mode=fetch&start=0&limit=10&category=3d,art";
  String aiNews =
      "http://api.frontendforever.com/ai/api.php?mode=news&start=0&limit=10";
  Future toolsData() async {
    http.Response responce = await http.get(Uri.parse(aiTools));
    if (responce.statusCode == 200) {
      var result = await jsonDecode(responce.body)["data"];
      print(result);
      toolsdata = result;
    } else {
      print("result");
    }
  }

  Future ainewsData() async {
    http.Response responce = await http.get(Uri.parse(aiNews));
    if (responce.statusCode == 200) {
      var result = await jsonDecode(responce.body)["data"];
      // print(result);
      return result;
    } else {
      null;
    }
  }
}
