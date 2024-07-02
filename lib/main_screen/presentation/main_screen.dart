import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optival/main_screen/presentation/weather_widget.dart';
import 'package:optival/weather/shared/providers.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(weatherStateNotifierProvider.notifier).fetchWeather());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Hava Durumu',
        ),
      ),
      body: const WeatherWidget(),
    );
  }
}
