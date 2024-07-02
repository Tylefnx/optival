import 'dart:math';

import 'package:optival/weather/domain/weather.dart';

class WeatherService {
  Weather fetchWeather() {
    return Weather(
      location: "Karabük",
      degree: Random().nextInt(35).toDouble(),
    );
  }
}
// TODO: 3-) Servis olauşturuldu requestleri ana repoda buradan atacağız