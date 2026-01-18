import 'package:flutter/material.dart';
import 'package:weatheria/src/features/home/presentation/home_screen.dart';
import 'package:weatheria/src/core/theme.dart';
import 'package:provider/provider.dart';
import 'package:weatheria/src/model/daily_forecast_model.dart';
import 'package:weatheria/src/model/hourly_forecast_model.dart';
import 'package:weatheria/src/model/weather_model.dart';
import 'package:weatheria/src/viewmodels/weatheria_view_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Hive.initFlutter();

  Hive.registerAdapter(WeatherModelAdapter());
  Hive.registerAdapter(HourlyForecastAdapter());
  Hive.registerAdapter(DailyForecastAdapter());

  
  runApp(
    ChangeNotifierProvider(create: (_) => WeatheriaViewModel(),
      child: const WeatheriaApp(),
    ),
  );
}

class WeatheriaApp extends StatelessWidget {
  const WeatheriaApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weatheria',
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
