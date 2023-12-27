import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:assignment/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeController extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxList<Transporter> locationData = RxList<Transporter>();

  Future<void> fetchData(String query) async {
    if (query.length >= 3) {
      final url = Uri.parse(
          'https://lorriservice.azurefd.net/api/autocomplete?suggest=$query&amp;limit=20&amp;searchFields=new_locations');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        print(response.body);
        final jsonResponse = json.decode(response.body)['value'];

        final List<Transporter> locations = jsonResponse
            .map<Transporter>((data) => Transporter.fromJson(data))
            .toList();

        locationData.assignAll(locations);
      } else {
        print("error");
        throw Exception('Failed to fetch data');
      }
    } else {
      // Clear the locationData when the query is less than 3 letters
      locationData.clear();
    }
  }

  @override
  void dispose() {
    // Dispose of the controller when it is no longer needed
    searchController.dispose();
    super.dispose();
  }
}
