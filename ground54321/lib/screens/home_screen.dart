import 'package:flutter/material.dart';
import 'stepper_screen.dart';

/// Home screen showing the begin button.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ground54321')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const StepperScreen()),
            );
          },
          child: const Text('Begin Grounding'),
        ),
      ),
    );
  }
}
