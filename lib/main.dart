import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:optival/core/presentation/app_widget.dart';

void main() => runApp(
      const ProviderScope(
        child: AppWidget(),
      ),
    );
