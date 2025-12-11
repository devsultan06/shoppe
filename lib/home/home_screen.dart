import 'package:flutter/material.dart';
import 'package:shoppe/widgets/my_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: const Color(0xFF6200EE),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Home Screen"),
            const SizedBox(height: 16),
            MyButton(
              label: "Click Me",
              color: Colors.green,
              onPressed: () {
                print("Button clicked!");
              },
            ),
          ],
        ),
      ),
    );
  }
}
