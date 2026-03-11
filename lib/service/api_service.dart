import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static Future getSchedule() async {

    var response = await http.get(
      Uri.parse("http://localhost:3000/schedule")
    );

    return json.decode(response.body);
  }

}