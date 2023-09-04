import 'dart:ui';

import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  final String time;
  final IconData wheatersing;
  final double celcuis;

  const HourlyForecast({
    required this.time,
    required this.wheatersing,
    required this.celcuis,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: SizedBox(
              width: 90,
              child: Column(
                children: [
                  Text(
                    time.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Icon(
                    wheatersing,
                    size: 20,
                  ),
                  const SizedBox(height: 10),
                  Text(celcuis.toStringAsFixed(1),
                      style: const TextStyle(fontSize: 17)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  toStringAsFixed(int i) {}
}
