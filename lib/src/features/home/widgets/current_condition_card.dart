import 'package:flutter/material.dart';

class CurrentConditionsCard extends StatelessWidget {
  const CurrentConditionsCard({super.key});

  Widget _item(String label, String value, IconData icon) {
    return SizedBox.expand(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: const Color.fromARGB(255, 49, 52, 56),
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:  [
              // Icon(Icons.energy_savings_leaf, color: Colors.white),
              Icon(icon, color: Colors.white),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(height: 1),
                  Text(
                    value,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.75,
          ),
          children: [
            _item('AQI', '42',Icons.safety_check_rounded),
            _item('UV Index', 'low', Icons.wb_sunny),
            _item('Wind', '15 km/h',Icons.air),
            _item('Pressure', '1015 hPa', Icons.speed),
            _item('Humidity', '78%', Icons.water_drop),
            _item('Dew Point', '18°', Icons.water_drop),
          ],
        ),
      ),
    );
  }
}
