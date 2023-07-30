import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForecastDays extends StatelessWidget {
  final List days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Froday",
    "Saturday",
    "Sunday"
  ];
  final String day;
  final IconData icon;
  final int minTemp;
  final int maxTemp;
  final Color color;
  ForecastDays(
      {super.key,
      required this.day,
      required this.icon,
      required this.minTemp,
      required this.maxTemp, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 85,
                  child: Text(
                    day,
                    style: GoogleFonts.openSans(fontSize: 15),
                  ),
                ),
                Icon(
                  icon,
                  size: 30,
                  color: color,
                ),
                Text(
                  "$minTemp°C",
                  style: GoogleFonts.openSans(
                      fontSize: 15, color: Colors.grey.shade600),
                ),
                Text(
                  "$maxTemp°C",
                  style: GoogleFonts.openSans(fontSize: 15),
                )
              ],
            ),
          ),
          SizedBox(
            height: 0.2,
            child: Container(
              color: Theme.of(context).dividerColor,
            ),
          ),
        ],
      ),
    );
    ;
  }
}
