import 'package:flutter/material.dart';

class AdditionalInformationCard extends StatelessWidget {
  final IconData icon;
  final String info1;
  final String info2;

  const AdditionalInformationCard({
    this.info1 = 'Humidity',
    this.icon = Icons.water_drop,
    this.info2 = '94',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 122,
      child: Card(
        elevation: 0,
        child: Column(
          children: [
            Icon(
              icon,
              size: 30,
            ),
            const SizedBox(height: 5),
            Text(
              info1,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 5),
            Text(
              info2,
              style: const TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
