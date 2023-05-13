import 'package:coaching/coaching_test/models/test_model.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/test_results/widgets/new_test_button.dart';
import 'package:coaching/test_results/widgets/result_display_widget.dart';
import 'package:coaching/test_results/widgets/result_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CoachingTestResultPage extends StatelessWidget {
  const CoachingTestResultPage({super.key, required this.testModel});

  static const name = 'CoachingTestResultPage';

  final CoachingTest testModel;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.isMobile || sizingInformation.isTablet) {
          return CoachingTestResultMobileView(
            testModel: testModel,
          );
        }
        return CoachingTestResultDesktopView(
          testModel: testModel,
        );
      },
    );
  }
}

class CoachingTestResultMobileView extends StatelessWidget {
  const CoachingTestResultMobileView({
    super.key,
    required this.testModel,
  });

  final CoachingTest testModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  context.l10n.scoreOverviewTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B1A37),
                  ),
                ),
              ),
              ResultsDisplayWidget(
                testModel: testModel,
                isMobile: true,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .9,
                padding: const EdgeInsets.all(16),
                child: const ResultsInformationWidget(fontSize: 20),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: NewTestButton(
                  isMobile: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CoachingTestResultDesktopView extends StatelessWidget {
  const CoachingTestResultDesktopView({
    super.key,
    required this.testModel,
  });

  final CoachingTest testModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  context.l10n.scoreOverviewTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B1A37),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .4,
                    padding: const EdgeInsets.all(16),
                    child: const ResultsInformationWidget(fontSize: 20),
                  ),
                  Column(
                    children: [
                      ResultsDisplayWidget(testModel: testModel),
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: NewTestButton(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
