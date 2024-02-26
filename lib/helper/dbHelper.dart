import 'package:http/http.dart' as http;
import 'dart:convert';

class DbHelper {
  final String baseUrl = "https://dev-api.arminadaily.id/mobiledev/getall/";
  final String token = "TESTING";

  Future getData() async {
    final response = await http.get(Uri.parse(baseUrl), headers: {
      'adsignature': '$token',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == true && data['responseCode'] == '00') {
        return data['data'];
      } else {
        throw Exception('Failed to load data');
      }
    } 
  }
  
}
