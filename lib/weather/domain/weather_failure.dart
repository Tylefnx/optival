import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_failure.freezed.dart';

@freezed
class WeatherFailure with _$WeatherFailure {
  const WeatherFailure._();
  const factory WeatherFailure.server({required String error}) = _Server;
  const factory WeatherFailure.storage({required String error}) = _NoInternet;
}
// TODO: 2-) Server(500) Storage(400) hataları için failure nesneleri oluşturuldu.
