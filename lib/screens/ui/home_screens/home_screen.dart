import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:restaurant_app/infrastructure/response/restaurant_response_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, Map<String, List<Map<String, dynamic>>>>> groupedAndFilteredDataList = [];

  testttt() {
    for (var menu in restaurantResponse['description']["menus"]) {
      Map<String, Map<String, List<Map<String, dynamic>>>> groupedAndFilteredData = {};

      for (var entry in menu["entries"]) {
        var meatStatus = entry["dish"]["meatStatus"];
        var category = entry["category"];

        if (!groupedAndFilteredData.containsKey(meatStatus)) {
          groupedAndFilteredData[meatStatus] = {};
        }

        if (!groupedAndFilteredData[meatStatus]!.containsKey(category)) {
          groupedAndFilteredData[meatStatus]![category] = [];
        }

        groupedAndFilteredData[meatStatus]![category]!.add(entry);
      }

      groupedAndFilteredDataList.add(groupedAndFilteredData);
    }

    inspect(groupedAndFilteredDataList);
  }

  @override
  void initState() {
    testttt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: [],
      ),
    );
  }
}
