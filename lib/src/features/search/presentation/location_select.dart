import 'package:flutter/material.dart';
import 'search_locations_page.dart';

class LocationSelect extends StatelessWidget {
  const LocationSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Locations")),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Current Location"),
            value: true,
            onChanged: (_) {},
          ),
          ListTile(
            title: const Text("Nagpur, Maharashtra"),
            trailing: const Icon(Icons.close),
          ),
          ListTile(
            title: const Text("Chandrapur, Maharashtra"),
            trailing: const Icon(Icons.close),
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text("Add new location"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchLocationsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
