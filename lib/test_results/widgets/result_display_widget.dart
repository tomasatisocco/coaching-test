import 'package:coaching/coaching_test/models/test_model.dart';
import 'package:coaching/coaching_test/models/test_model_keys.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/test_results/widgets/field_score_widget.dart';
import 'package:coaching/test_results/widgets/total_score_widget.dart';
import 'package:coaching/utils/color_getters.dart';
import 'package:flutter/material.dart';

class ResultsDisplayWidget extends StatelessWidget {
  const ResultsDisplayWidget({
    super.key,
    required this.testModel,
    this.isMobile = false,
  });

  final CoachingTest testModel;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMobile
          ? MediaQuery.of(context).size.width * .9
          : MediaQuery.of(context).size.width * .45,
      decoration: const BoxDecoration(
        color: Color(0xFF0B1A37),
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FieldScoreWidget(
            title: context.l10n.qualityOfService,
            radio: isMobile ? 30 : MediaQuery.of(context).size.width * .035,
            score: testModel.getGroupAnswersTotal(
              AnswerGroup.qualityOfService,
            ),
            scoreColor: getQualityColor(
              testModel.getGroupAnswersTotal(
                AnswerGroup.qualityOfService,
              ),
            ),
            removeUpperPadding: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FieldScoreWidget(
                title: context.l10n.businessCreation,
                radio: isMobile ? 30 : MediaQuery.of(context).size.width * .035,
                score: testModel.getGroupAnswersTotal(
                  AnswerGroup.business,
                ),
                scoreColor: getBusinessColor(
                  testModel.getGroupAnswersTotal(
                    AnswerGroup.business,
                  ),
                ),
              ),
              GeneralScoreWidget(
                score: testModel.totalQualification.toString(),
                radio: isMobile ? 50 : MediaQuery.of(context).size.width * .06,
                scoreColor: getTotalColor(
                  testModel.totalQualification,
                ),
              ),
              FieldScoreWidget(
                title: context.l10n.personalWellness,
                radio: isMobile ? 30 : MediaQuery.of(context).size.width * .035,
                score: testModel.getGroupAnswersTotal(
                  AnswerGroup.personal,
                ),
                scoreColor: getWellnessColor(
                  testModel.getGroupAnswersTotal(
                    AnswerGroup.personal,
                  ),
                ),
              ),
            ],
          ),
          FieldScoreWidget(
            title: context.l10n.aportToTheCommunity,
            radio: isMobile ? 30 : MediaQuery.of(context).size.width * .035,
            score: testModel.getGroupAnswersTotal(
              AnswerGroup.community,
            ),
            scoreColor: getCommunityColor(
              testModel.getGroupAnswersTotal(
                AnswerGroup.community,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
