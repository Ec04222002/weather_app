import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather App",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  var location;
  @override
  void initState() {
    super.initState();

    this.getWeather();
  }

  Future getWeather() async {
    var uri = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=Boston&appid=5e0bd7069a467836474e1e088032a020");
    http.Response response = await http.get(uri);
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
      this.location = results['name'];
    });
    print(location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Currently in ${this.location}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  "${this.temp}\u00B0",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "${description}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(children: <Widget>[
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                  title: Text("Temperature"),
                  trailing: Text("${this.temp}\u00b0"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.cloud),
                  title: Text("Weather"),
                  trailing: Text("${this.description}"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.sun),
                  title: Text("Humidity"),
                  trailing: Text("${this.humidity}"),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.wind),
                  title: Text("Wind Speed"),
                  trailing: Text("${this.windSpeed}"),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
