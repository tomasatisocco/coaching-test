import 'package:coaching/coaching_test/models/test_model.dart';
import 'package:coaching/coaching_test/models/test_model_keys.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/test_results/widgets/field_score_widget.dart';
import 'package:coaching/test_results/widgets/total_score_widget.dart';
import 'package:coaching/utils/color_getters.dart';
import 'package:flutter/material.dart';

class ResultRowWidget extends StatelessWidget {
  const ResultRowWidget({super.key, required this.test});

  final CoachingTest test;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 250,
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GeneralScoreWidget(
            score: test.totalQualification.toString(),
            radio: 40,
            scoreColor: getTotalColor(
              test.totalQualification,
            ),
          ),
          FieldScoreWidget(
            title: context.l10n.qualityOfService,
            radio: 20,
            score: test.getGroupAnswersTotal(
              AnswerGroup.qualityOfService,
            ),
            scoreColor: getQualityColor(
              test.getGroupAnswersTotal(
                AnswerGroup.qualityOfService,
              ),
            ),
            removeUpperPadding: true,
          ),
          FieldScoreWidget(
            title: context.l10n.businessCreation,
            radio: 20,
            score: test.getGroupAnswersTotal(
              AnswerGroup.business,
            ),
            scoreColor: getQualityColor(
              test.getGroupAnswersTotal(
                AnswerGroup.business,
              ),
            ),
            removeUpperPadding: true,
          ),
          FieldScoreWidget(
            title: context.l10n.personalWellness,
            radio: 20,
            score: test.getGroupAnswersTotal(
              AnswerGroup.personal,
            ),
            scoreColor: getQualityColor(
              test.getGroupAnswersTotal(
                AnswerGroup.personal,
              ),
            ),
            removeUpperPadding: true,
          ),
          FieldScoreWidget(
            title: context.l10n.aportToTheCommunity,
            radio: 20,
            score: test.getGroupAnswersTotal(
              AnswerGroup.community,
            ),
            scoreColor: getQualityColor(
              test.getGroupAnswersTotal(
                AnswerGroup.community,
              ),
            ),
            removeUpperPadding: true,
          ),
        ],
      ),
    );
  }
}
