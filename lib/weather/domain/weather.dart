import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';
part 'weather.g.dart';

@freezed
class Weather with _$Weather {
  const Weather._();
  const factory Weather({
    required String location,
    required double degree,
  }) = _Weather;

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json); // fromJson fonksiyonu eklendi ve json_serializable g.dart dosyası oluşturdu
}
// TODO: 1-) Freezed class ı oluşturuldu