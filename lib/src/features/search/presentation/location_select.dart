import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatheria/src/core/app_state.dart';
import 'package:weatheria/src/viewmodels/weatheria_view_model.dart';
import 'search_locations_page.dart';

class LocationSelect extends StatelessWidget {
  const LocationSelect({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WeatheriaViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Locations"),
      ),
      body: ListView(
        children: [
          /// 🔄 CURRENT LOCATION TOGGLE
          SwitchListTile(
            title: const Text("Current Location"),
            value: vm.locationMode == LocationMode.gps,
            onChanged: (enabled) {
              if (enabled) {
                vm.loadByGPS();
                Navigator.pop(context);
              }
            },
          ),

          const Divider(),

          /// 📍 CURRENTLY SELECTED LOCATION
          if (vm.locationMode == LocationMode.manual)
            ListTile(
              leading: const Icon(Icons.location_on),
              title: Text(vm.locationLabel),
              trailing: const Icon(Icons.check),
            ),

          const Divider(),

          /// ➕ ADD NEW LOCATION
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text("Add new location"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SearchLocationsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
