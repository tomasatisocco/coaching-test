import 'package:coaching/coaching_test/models/test_model.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/test_results/widgets/field_score_widget.dart';
import 'package:coaching/test_results/widgets/total_score_widget.dart';
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
                    Container(
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0B1A37),
                        borderRadius: BorderRadius.all(
                          Radius.circular(64),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FieldScoreWidget(
                            title: context.l10n.qualityOfService,
                            radio: 30,
                            score: testModel.getQualityOfServiceQualification,
                            scoreColor: getScoreColor(
                              testModel
                                  .getQualityOfServiceQualificationPercentage,
                            ),
                            removeUpperPadding: true,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FieldScoreWidget(
                                title: context.l10n.businessCreation,
                                radio: 30,
                                score:
                                    testModel.getBusinessCreationQualification,
                                scoreColor: getScoreColor(
                                  testModel
                                      .getBusinessCreationQualificationPercentage,
                                ),
                              ),
                              GeneralScoreWidget(
                                score: testModel.totalQualification.toString(),
                                radio: 50,
                                scoreColor: getScoreColor(
                                  testModel.getTotalQualificationPercentage,
                                ),
                              ),
                              FieldScoreWidget(
                                title: context.l10n.personalWellness,
                                radio: 30,
                                score:
                                    testModel.getPersonalWellnessQualification,
                                scoreColor: getScoreColor(
                                  testModel
                                      .getPersonalWellnessQualificationPercentage,
                                ),
                              ),
                            ],
                          ),
                          FieldScoreWidget(
                            title: context.l10n.aportToTheCommunity,
                            radio: 30,
                            score: testModel
                                .getContributionsToProfessionalCommunityQualification,
                            scoreColor: getScoreColor(
                              testModel
                                  .getContributionsToProfessionalCommunityQualification,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .9,
                      padding: const EdgeInsets.all(16),
                      child: const ResultsInformationWidget(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Scaffold(
          backgroundColor: const Color(0xFFF3F3F3),
          body: Padding(
            padding: const EdgeInsets.all(32),
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
                      height: MediaQuery.of(context).size.height * .75,
                      padding: const EdgeInsets.all(16),
                      child: const SingleChildScrollView(
                        child: ResultsInformationWidget(fontSize: 20),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .45,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0B1A37),
                        borderRadius: BorderRadius.all(
                          Radius.circular(64),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FieldScoreWidget(
                            title: context.l10n.qualityOfService,
                            radio: MediaQuery.of(context).size.width * .035,
                            score: testModel.getQualityOfServiceQualification,
                            scoreColor: getScoreColor(
                              testModel
                                  .getQualityOfServiceQualificationPercentage,
                            ),
                            removeUpperPadding: true,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FieldScoreWidget(
                                title: context.l10n.businessCreation,
                                radio: MediaQuery.of(context).size.width * .035,
                                score:
                                    testModel.getBusinessCreationQualification,
                                scoreColor: getScoreColor(
                                  testModel
                                      .getBusinessCreationQualificationPercentage,
                                ),
                              ),
                              GeneralScoreWidget(
                                score: testModel.totalQualification.toString(),
                                radio: MediaQuery.of(context).size.width * .06,
                                scoreColor: getScoreColor(
                                  testModel.getTotalQualificationPercentage,
                                ),
                              ),
                              FieldScoreWidget(
                                title: context.l10n.personalWellness,
                                radio: MediaQuery.of(context).size.width * .035,
                                score:
                                    testModel.getPersonalWellnessQualification,
                                scoreColor: getScoreColor(
                                  testModel
                                      .getPersonalWellnessQualificationPercentage,
                                ),
                              ),
                            ],
                          ),
                          FieldScoreWidget(
                            title: context.l10n.aportToTheCommunity,
                            radio: MediaQuery.of(context).size.width * .035,
                            score: testModel
                                .getContributionsToProfessionalCommunityQualification,
                            scoreColor: getScoreColor(
                              testModel
                                  .getContributionsToProfessionalCommunityQualification,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ResultsInformationWidget extends StatelessWidget {
  const ResultsInformationWidget({
    required this.fontSize,
    super.key,
  });

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.testDescription,
          style: TextStyle(
            fontSize: fontSize,
            color: const Color(0xFF0B1A37),
          ),
        ),
        SizedBox(
          height: fontSize,
        ),
        Text(
          context.l10n.testLevels,
          style: TextStyle(
            fontSize: fontSize,
            color: const Color(0xFF0B1A37),
          ),
        ),
        Text(
          ' • ${context.l10n.qualityOfService} \n • ${context.l10n.businessCreation} \n • ${context.l10n.personalWellness} \n • ${context.l10n.aportToTheCommunity}',
          style: TextStyle(
            fontSize: fontSize,
            color: const Color(0xFF0B1A37),
          ),
        ),
        SizedBox(
          height: fontSize,
        ),
        Text(
          context.l10n.disclaimer,
          style: TextStyle(
            fontSize: fontSize,
            color: const Color(0xFF0B1A37),
          ),
        ),
      ],
    );
  }
}

Color getScoreColor(int score) {
  if (score < 33) return Colors.redAccent;
  if (score < 66) return Colors.orangeAccent;
  return const Color(0xFF92D148);
}
