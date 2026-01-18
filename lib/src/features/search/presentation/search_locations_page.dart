import 'package:flutter/material.dart';

class SearchLocationsPage extends StatelessWidget {
  const SearchLocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locations = [
      "Chandrapur, Maharashtra, India",
      "Chandrapura, Jharkhand, India",
      "Chandragiri, Andhra Pradesh, India",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const TextField(
          decoration: InputDecoration(
            hintText: "Search city",
            border: InputBorder.none,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (_, i) => ListTile(
          title: Text(locations[i]),
          onTap: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
