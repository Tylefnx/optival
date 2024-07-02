import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optival/main_screen/application/weather_notifier.dart';
import 'package:optival/weather/infrastructure/weather_repository.dart';
import 'package:optival/weather/infrastructure/weather_service.dart';

final weatherServiceProvider = Provider(
  (ref) => WeatherService(),
);

final weatherRepoProvider = Provider(
  (ref) => WeatherRepository(
    ref.watch(weatherServiceProvider),
  ),
);

final weatherStateNotifierProvider =
    StateNotifierProvider<WeatherStateNotifier, WeatherState>(
  (ref) => WeatherStateNotifier(
    ref.watch(weatherRepoProvider),
  ),
);

// TODO: 6-) service, repository ve state notifier objelerini yaratıp ref.read() gibi riverpod fonksiyonlarıyla kullanabilmek adına provider nesnelerinin içine alıyoruz