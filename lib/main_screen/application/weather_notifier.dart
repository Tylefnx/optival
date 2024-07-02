import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optival/weather/domain/weather.dart';
import 'package:optival/weather/infrastructure/weather_repository.dart';

part 'weather_notifier.freezed.dart';

@freezed
class WeatherState with _$WeatherState {
  const WeatherState._();
  const factory WeatherState.initial() = _Initial;
  const factory WeatherState.loading() = _Loading;
  const factory WeatherState.done(Weather weather) = _Done;
  const factory WeatherState.failed(String errorMessage) = _Failed;
}

class WeatherStateNotifier extends StateNotifier<WeatherState> {
  final WeatherRepository repository;
  WeatherStateNotifier(this.repository) : super(const WeatherState.initial());

  Future<void> fetchWeather() async {
    final failureOrWeather = await repository.fetchWeather();

    state = failureOrWeather.fold(
      (failure) => WeatherState.failed(failure.error),
      (weather) => WeatherState.done(weather),
    );
  }
}
