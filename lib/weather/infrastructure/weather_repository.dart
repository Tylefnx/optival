import 'dart:math';

import 'package:example/weather/domain/weather.dart';
import 'package:example/weather/domain/weather_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:example/weather/infrastructure/weather_service.dart';

class WeatherRepository {
  WeatherRepository(this.service);
  
  final WeatherService service;
  
  Future<Either<WeatherFailure, Weather>> fetchWeather() async {
    int randomResponse = Random().nextInt(6);

    switch (randomResponse) {
      case 1:
        return left(
          const WeatherFailure.server(
            error: 'There is a problem with the server',
          ),
        );

      case 2:
        return left(
          const WeatherFailure.storage(
            error: "No internet",
          ),
        );

      default:
        return right(service.fetchWeather());
    }
  }
}
// TODO: 4-) Attığımız requestlerin düzgün çalışıp çalışmadığını kontrol ediyoruz duruma göre yarattığımız data classını veya failure objelerini döndürüyoruz.
// Burada bir request yapamadığımız için bi şeyleri feykledik
