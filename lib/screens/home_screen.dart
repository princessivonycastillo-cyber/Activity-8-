import 'package:flutter/material.dart';

import '../widgets/app_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('BrewHaven')),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButton(
                label: 'Open Login',
                onPressed: () => Navigator.pushNamed(context, '/login'),
              ),
              const SizedBox(height: 16),
              AppButton(
                label: 'Report an Issue',
                onPressed: () => Navigator.pushNamed(context, '/report'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
