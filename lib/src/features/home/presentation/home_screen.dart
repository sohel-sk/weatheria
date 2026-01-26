import 'package:flutter/material.dart';
import 'package:weatheria/src/features/search/presentation/location_select.dart';
import 'package:weatheria/src/features/home/widgets/weather_header.dart';
import '../widgets/current_condition_card.dart';
import '../widgets/hourly_forecast_card.dart';
import '../widgets/daily_forecast_card.dart';
import 'package:weatheria/src/core/app_state.dart';
import 'package:weatheria/src/viewmodels/weatheria_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WeatheriaViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(vm.locationLabel),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LocationSelect()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LocationSelect()),
              );
            },
          ),
          IconButton(
            onPressed: () {
              //
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _buildBody(vm),
    );
  }

  Widget _buildBody(WeatheriaViewModel vm) {
    switch (vm.appStatus) {
      case AppStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case AppStatus.error:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 40),
              const SizedBox(height: 12),
              Text(vm.errorMessage ?? "Something went wrong"),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  if (vm.locationMode == LocationMode.gps) {
                    vm.loadByGPS();
                  }
                },
                child: const Text("Retry"),
              ),
            ],
          ),
        );
      case AppStatus.success:
        return RefreshIndicator(
          onRefresh: () async {
            if (vm.locationMode == LocationMode.gps) {
              await vm.loadByGPS();
            }
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              WeatherHeader(),
              SizedBox(height: 16),
              CurrentConditionsCard(),
              SizedBox(height: 16),
              HourlyForecastCard(),
              SizedBox(height: 16),
              DailyForecastCard(),
              SizedBox(height: 16),
            ],
          ),
        );
      case AppStatus.idle:
        return const Center(child: Text("No data"));
    }
  }
}
