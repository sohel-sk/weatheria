import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/weatheria_view_model.dart';

class SearchLocationsPage extends StatelessWidget {
  const SearchLocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WeatheriaViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Search city or place",
            border: InputBorder.none,
          ),
          onChanged: vm.searchLocation,
        ),
      ),
      body: _buildBody(vm, context),
    );
  }

  Widget _buildBody(WeatheriaViewModel vm, BuildContext context) {
    if (vm.isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.places.isEmpty) {
      return const Center(child: Text("No locations found"));
    }

    return ListView.builder(
      itemCount: vm.places.length,
      itemBuilder: (_, index) {
        final place = vm.places[index];

        return ListTile(
          leading: const Icon(Icons.location_on),
          title: Text(place.name),
          subtitle: Text(place.address),
          onTap: () async {
            await vm.selectPlace(place);
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        );
      },
    );
  }
}
