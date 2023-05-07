import 'package:coaching/coaching_test/view/coaching_test_page.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  static const name = 'Welcome Page';

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late TextEditingController _textEditingController;
  bool isError = false;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(48),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(64),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 64),
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      context.l10n.welcome,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2FA0F3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    context.l10n.fillEmail,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Color(0xFF2FA0F3),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(36),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        hintText: 'example@email.com',
                        fillColor: Colors.blueGrey.shade100,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 24),
                      ),
                      onSubmitted: (value) {
                        final isEmailValid = validateEmail(
                          value,
                        );
                        setState(() {
                          isError = !isEmailValid;
                        });
                        if (!isEmailValid) return;
                        GoRouter.of(context).goNamed(
                          CoachingTestPage.name,
                          extra: value,
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: isError,
                    child: Text(
                      context.l10n.emailError,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      final isEmailValid = validateEmail(
                        _textEditingController.text,
                      );
                      setState(() {
                        isError = !isEmailValid;
                      });
                      if (!isEmailValid) return;
                      GoRouter.of(context).goNamed(
                        CoachingTestPage.name,
                        extra: _textEditingController.text,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA6FAAC),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        context.l10n.getStarted,
                        style: const TextStyle(
                          fontSize: 36,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Image.asset('assets/images/welcome.png'),
            ),
          )
        ],
      ),
    );
  }

  bool validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
