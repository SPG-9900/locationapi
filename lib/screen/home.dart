import 'package:assignment/controller/homecontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomeScreen({super.key, required User user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: controller.searchController,
                  onChanged: (value) {
                    if (value.length >= 3) {
                      controller.fetchData(value);
                    } else {
                      controller.locationData.clear();
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Search for a city or location',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0), // Reduced height
                  ),
                ),
                const SizedBox(height: 16.0), // Add spacing
                Center(
                  child: Obx(() {
                    // Show the image if locationData is empty
                    if (controller.locationData.isEmpty) {
                      return Center(
                        child: Image.asset(
                          'assets/images/searching.png', // Replace with your image path
                          height: 200, // Adjust the height as needed
                        ),
                      );
                    } else {
                      return Container(); // Empty container when data is available
                    }
                  }),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.locationData.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 16.0),
                    child: ListTile(
                      title: Text(
                        'Transporter Name: ${controller.locationData[index].transporterName}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transporter ID: ${controller.locationData[index].transporterId}',
                          ),
                          Text(
                            'Logo: ${controller.locationData[index].logo}',
                          ),
                        ],
                      ),
                      onTap: () {
                        // Handle item click here
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
