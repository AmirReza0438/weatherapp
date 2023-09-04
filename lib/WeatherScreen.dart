import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/secrets.dart';
import 'Additional_information.dart';
import 'package:http/http.dart' as http;

import 'HourlyForecast.dart';

class WheaterScreen extends StatefulWidget {
  const WheaterScreen({super.key});

  @override
  State<WheaterScreen> createState() => _WheaterScreenState();
}

class _WheaterScreenState extends State<WheaterScreen> {
  Future<Map<String, dynamic>> gotCurrentWheater() async {
    try {
      String? cityName = 'Tehran';
      final res = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName,&APPID=$openwheaterAPIkey",
        ),
      );

      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw data['message'];
      }
      return data;
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wheater App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setState(() {});
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: gotCurrentWheater(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: (Text(snapshot.error.toString())));
          }
          final data = snapshot.data;
          final wheatherdata = snapshot.data!['list'][0];
          final currenttemp =
              (wheatherdata['main']['temp'] - 273.15).toStringAsFixed(1);
          final currentwheather = wheatherdata['weather'][0]['main'];
          final presure = wheatherdata['main']['pressure'];
          final humidity = wheatherdata['main']['humidity'];
          final windspeed = wheatherdata['wind']['speed'];

          //['list']['0']['weather'][0]['icon']

          return Container(
            padding: const EdgeInsets.all(13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    //main card
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                currenttemp.toString(),
                                style: const TextStyle(fontSize: 35),
                              ),
                              const SizedBox(height: 5),
                              Icon(
                                currentwheather == 'Clear' ||
                                        currentwheather == 'Clouds'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 45,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                currentwheather.toString(),
                                style: const TextStyle(fontSize: 25),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 17),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hourly Forecast',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 125,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      final t = DateTime.parse(data?['list'][index]['dt_txt']);
                      final hourlytemp =
                          data?['list'][index]['main']['temp'] - 273.15;
                      final hourlyicon = data?['list'][index]['weather'][0]
                                      ['main'] ==
                                  'Clouds' ||
                              data?['list'][index]['weather'][0]['main'] ==
                                  'Rain'
                          ? Icons.cloud
                          : Icons.sunny;
                      return HourlyForecast(
                        time: DateFormat("j").format(t),
                        wheatersing: hourlyicon,
                        celcuis: hourlytemp,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Additional Infromation',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AdditionalInformationCard(
                      info1: 'Humidity',
                      info2: humidity.toString(),
                    ),
                    AdditionalInformationCard(
                      icon: Icons.air,
                      info1: 'wind speed',
                      info2: windspeed.toString(),
                    ),
                    AdditionalInformationCard(
                      icon: Icons.wind_power_sharp,
                      info1: 'pressure',
                      info2: presure.toString(),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
