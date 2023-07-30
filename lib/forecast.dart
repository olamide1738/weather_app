import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Forecast extends StatelessWidget {
  final String time;
  final String newtemp;
  final String windpower;
  final String rainpercent;
  final IconData icon;
  final Color color;

  const Forecast(
      {super.key,
      required this.time,
      required this.newtemp,
      required this.windpower,
      required this.rainpercent,
      required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            time,
            style: GoogleFonts.openSans(
                fontSize: 20, color: Theme.of(context).primaryColorLight),
          ),
          Icon(icon, size: 25, color: color),
          Text(
            "${newtemp}°C",
            style: GoogleFonts.openSans(
                fontSize: 20, color: Theme.of(context).primaryColorLight),
          ),
          Icon(Icons.wind_power, size: 25, color: Theme.of(context).hintColor),
          Text(
            "$windpower km/h",
            style: GoogleFonts.openSans(
                fontSize: 15, color: Theme.of(context).hintColor),
          ),
          Icon(Icons.umbrella, size: 25, color: Colors.blue.shade800),
          Text(
            "$rainpercent%",
            style:
                GoogleFonts.openSans(fontSize: 15, color: Colors.blue.shade800),
          )
        ],
      ),
    );
  }
}
