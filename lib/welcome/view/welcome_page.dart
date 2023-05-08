import 'package:coaching/coaching_test/view/coaching_test_page.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/welcome/widgets/start_button.dart';
import 'package:coaching/welcome/widgets/welcome_email_widget.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

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

  Future<void> onSubmit(BuildContext context) async {
    final isEmailValid = validateEmail(
      _textEditingController.text,
    );
    setState(() {
      isError = !isEmailValid;
    });
    if (!isEmailValid) return;
    await context.read<DataPersistenceRepository>().setEmail(
          _textEditingController.text,
        );
    if (!mounted) return;
    GoRouter.of(context).goNamed(
      CoachingTestPage.name,
      extra: _textEditingController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.isMobile || sizingInformation.isTablet) {
          return WelcomePageMobileView(
            textEditingController: _textEditingController,
            onSubmit: onSubmit,
            isError: isError,
          );
        }
        return WelcomePageDesktopView(
          textEditingController: _textEditingController,
          onSubmit: onSubmit,
          isError: isError,
        );
      },
    );
  }

  bool validateEmail(String email) {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
  }
}

class WelcomePageMobileView extends StatelessWidget {
  const WelcomePageMobileView({
    super.key,
    required this.onSubmit,
    required this.textEditingController,
    required this.isError,
  });

  final void Function(BuildContext context) onSubmit;
  final TextEditingController textEditingController;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(64),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  context.l10n.welcome,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2FA0F3),
                  ),
                ),
                Visibility(
                  visible: MediaQuery.of(context).viewInsets.bottom == 0,
                  child: Center(
                    child: Image.asset(
                      'assets/images/welcome.png',
                      width: 350,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  context.l10n.fillEmail,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Color(0xFF2FA0F3),
                  ),
                ),
                const SizedBox(height: 14),
                WelcomeEmailWidget(
                  onSubmit: onSubmit,
                  textEditingController: textEditingController,
                  isError: isError,
                  width: 300,
                ),
                const Spacer(),
                StartButton(
                  onSubmit: onSubmit,
                  fontSize: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WelcomePageDesktopView extends StatelessWidget {
  const WelcomePageDesktopView({
    super.key,
    required this.onSubmit,
    required this.textEditingController,
    required this.isError,
  });

  final void Function(BuildContext context) onSubmit;
  final TextEditingController textEditingController;
  final bool isError;

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
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Color(0xFF2FA0F3),
                    ),
                  ),
                  const SizedBox(height: 14),
                  WelcomeEmailWidget(
                    onSubmit: onSubmit,
                    textEditingController: textEditingController,
                    isError: isError,
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  const Spacer(),
                  StartButton(
                    onSubmit: onSubmit,
                    fontSize: 32,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Image.asset('assets/images/welcome.png'),
            ),
          ),
        ],
      ),
    );
  }
}
