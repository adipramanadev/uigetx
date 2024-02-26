import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController extends GetxController {
  var users = [].obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  final String getUrl = "https://dev-api.arminadaily.id/mobiledev/getall/";
  final String token = "TESTING";

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(getUrl), headers: {
        'adsignature': '$token',
      });
      if (response.statusCode == 200) {
        // Map<String, dynamic> data = json.decode(response.body);
        final jsonData = json.decode(response.body);
        users.assignAll(
          jsonData['data'].map((user) {
            return {
              'users_nm': user['users_nm'],
              'users_email': user['users_email'],
            };
          }).toList(),
        );
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  final String storeUrl = "https://dev-api.arminadaily.id/mobiledev/create/";
  
  //store data
  Future storeData(String name, String email) async {
    try {
      final response = await http.post(Uri.parse(storeUrl), headers: {
        'adsignature': '$token',
      }, body: {
        'users_nm': name,
        'users_email': email,
      });
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'User added successfully',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        throw Exception('Failed to store data');
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'Failed to store data',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
