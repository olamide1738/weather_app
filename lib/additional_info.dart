import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdditionalInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AdditionalInfo(
      {super.key,
      required this.icon,
      required this.label,
      required this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
            height: 100,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    icon,
                    size: 25,
                    color: Colors.blue.shade800,
                  ),
                  Text(
                    label,
                    style: GoogleFonts.openSans(fontSize: 15),
                  ),
                  Text(
                    value,
                    style: GoogleFonts.openSans(fontSize: 15),
                  ),
                ],
              ),
            )));
  }
}
