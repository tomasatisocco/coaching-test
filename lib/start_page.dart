import 'package:coaching/authentication/login/view/login_page.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  static const name = 'StartPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: Colors.blue,
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              await showDialog<void>(
                context: context,
                builder: (context) => const LoginPage(),
              );
            },
            child: const Text('Start'),
          ),
        ),
      ),
    );
  }
}
