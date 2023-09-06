import 'package:flutter/material.dart';
import 'package:weather_app/Weather_Screen.dart';

TextEditingController citycontroller = TextEditingController();

class CityTextField extends StatefulWidget {
  const CityTextField({super.key});

  @override
  State<CityTextField> createState() => _CityTextFieldState();
}

class _CityTextFieldState extends State<CityTextField> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Enter city',
            style: TextStyle(fontSize: 25),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: TextField(
                controller: citycontroller,
                onSubmitted: (value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WheaterScreen(),
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
