import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:weather_app/7day_forecast.dart';
import 'package:weather_app/additional_info.dart';
import 'package:weather_app/api_key.dart';
import 'package:weather_app/forecast.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final List days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  @override
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = "Lagos";
      final res = await http.get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/forecast?q=$cityName,&APPID=$apiKey"),
      );
      final data = jsonDecode(res.body);
      if (data["cod"] != "200") {
        throw "An unexpected error occured";
      }
      return data;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> _onRefresh() async {
    var order;
    setState(() {
      getCurrentWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        actions: [
          IconButton(
              enableFeedback: true,
              splashRadius: 50,
              highlightColor: Colors.blue.shade800,
              onPressed: () {
                _onRefresh();
              },
              icon: Icon(
                Icons.refresh,
                size: 30,
              ))
        ],
        title: Text("Weather App", style: GoogleFonts.openSans(fontSize: 20)),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text(
              snapshot.error.toString(),
              style: GoogleFonts.openSans(fontSize: 30),
            ));
          }

          final data = snapshot.data!;
          final curWeatherData = data["list"][0];
          final curTemp = (data["list"][0]["main"]["temp"]).toInt() - 273;
          final curWeather = data["list"][0]["weather"][0]["main"];
          final curPressure = curWeatherData["main"]["pressure"];
          final curSpeed = curWeatherData["wind"]["speed"];
          final curHumidity = curWeatherData["main"]["humidity"];
          final curSky = curWeatherData["weather"][0]["main"];
          final curTempMin =
              (data["list"][0]["main"]["temp_min"]).toInt() - 273;
          final curTempMax =
              (data["list"][0]["main"]["temp_max"]).toInt() - 271;

          return LiquidPullToRefresh(
            color: Colors.blue.shade700,
            backgroundColor: Theme.of(context).primaryColor,
            springAnimationDurationInMilliseconds: 1200,
            animSpeedFactor: 4,
            onRefresh: _onRefresh,
            child: ListView(physics: BouncingScrollPhysics(), children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Lagos",
                                style: GoogleFonts.openSans(fontSize: 40),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Today",
                                  style: GoogleFonts.openSans(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w300))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("$curTemp°C",
                                  style: GoogleFonts.openSans(
                                      fontSize: 70,
                                      color: Colors.blue.shade800)),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 0.1,
                            width: 150,
                            child: Container(
                                color: Theme.of(context).primaryColorLight),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("$curWeather",
                                  style: GoogleFonts.openSans(fontSize: 20))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("$curTempMin°C",
                                  style: GoogleFonts.openSans(
                                      fontSize: 20,
                                      color: Colors.blue.shade200)),
                              Text(" / ",
                                  style: GoogleFonts.openSans(fontSize: 20)),
                              Text("$curTempMax°C",
                                  style: GoogleFonts.openSans(
                                      fontSize: 20,
                                      color: Colors.blue.shade800))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10, left: 15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Hourly Forecast",
                                style: GoogleFonts.openSans(fontSize: 22))
                          ]),
                    ),
                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, int i) {
                          final time = DateTime.parse(
                              data["list"][i + 1]['dt_txt'].toString());
                          return Forecast(
                            time: DateFormat.Hm().format(time),
                            newtemp:
                                (data["list"][i + 1]['main']["temp"].toInt() -
                                        273)
                                    .toString(),
                            windpower:
                                data["list"][i + 1]['wind']['speed'].toString(),
                            rainpercent: 2.toString(),
                            icon: data["list"][i + 1]["weather"][0]["main"] ==
                                    "Clouds"
                                ? Icons.cloud
                                : data["list"][i + 1]["weather"][0]["main"] ==
                                        "Rain"
                                    ? Icons.water
                                    : Icons.sunny,
                            color: data["list"][i + 1]["weather"][0]["main"] ==
                                        "Clouds" ||
                                    data["list"][i + 1]["weather"][0]["main"] ==
                                        "Rain"
                                ? Colors.blue
                                : Colors.yellow,
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Text(
                                    "7-day forecast",
                                    style: GoogleFonts.openSans(fontSize: 20),
                                  )
                                ],
                              )),
                          SizedBox(
                            height: 0.2,
                            child: Container(
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 350,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 7,
                        itemBuilder: (context, i) {
                          return ForecastDays(
                              color: data["list"][i * 5]["weather"][0]["main"] ==
                                          "Clouds" ||
                                      data["list"][i * 5]["weather"][0]
                                              ["main"] ==
                                          "Rain"
                                  ? Colors.blue
                                  : Colors.yellow,
                              day: days[i],
                              icon: data["list"][i * 5]["weather"][0]["main"] ==
                                      "Clouds"
                                  ? Icons.cloud
                                  : data["list"][i * 5]["weather"][0]["main"] ==
                                          "Rain"
                                      ? Icons.water
                                      : Icons.sunny,
                              minTemp: (data["list"][i * 5]["main"]["temp_min"])
                                      .toInt() -
                                  273,
                              maxTemp: (data["list"][i * 5]["main"]["temp_min"])
                                      .toInt() -
                                  271);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              "Additional Infomation",
                              style: GoogleFonts.openSans(fontSize: 20),
                            )
                          ],
                        )),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AdditionalInfo(
                              icon: Icons.water_drop,
                              label: "Humidity",
                              value: "$curHumidity%"),
                          AdditionalInfo(
                              icon: Icons.wind_power_outlined,
                              label: "Wind Speed",
                              value: "$curSpeed km/h"),
                          AdditionalInfo(
                              icon: Icons.beach_access,
                              label: "Pressure",
                              value: "$curPressure Hg")
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}
