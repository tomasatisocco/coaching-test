import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/welcome/widgets/welcome_email_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static const name = 'Welcome Page';

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return (sizingInformation.isMobile || sizingInformation.isTablet)
            ? const WelcomePageMobileView()
            : const WelcomePageDesktopView();
      },
    );
  }
}

class WelcomePageMobileView extends StatelessWidget {
  const WelcomePageMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    context.l10n.welcome,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/welcome.png',
                      width: 350,
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: Text(
                      context.l10n.fillForm,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const WelcomeEmailWidget(width: 300),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WelcomePageDesktopView extends StatelessWidget {
  const WelcomePageDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(48),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              width: MediaQuery.of(context).size.width * 0.4,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        context.l10n.welcome,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Text(
                        context.l10n.fillForm,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    WelcomeEmailWidget(
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                  ],
                ),
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
