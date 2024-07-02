import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optival/main_screen/presentation/main_screen.dart';

final GoRouter goRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MainPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const MainPage();
          },
        ),
      ],
    ),
  ],
);
