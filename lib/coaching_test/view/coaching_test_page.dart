import 'package:coaching/coaching_test/cubit/coaching_test_cubit.dart';
import 'package:coaching/coaching_test/models/question_model.dart';
import 'package:coaching/coaching_test/view/question_page.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/test_results/view/coaching_test_results_page.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CoachingTestPage extends StatelessWidget {
  const CoachingTestPage({
    required this.email,
    super.key,
  });

  static const name = 'CoachingTestPage';
  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CoachingTestCubit(
        email: email,
        firestoreRepository: context.read<FirestoreRepository>(),
      ),
      child: CoachingTestPageView(localizations: context.l10n),
    );
  }
}

class CoachingTestPageView extends StatefulWidget {
  const CoachingTestPageView({super.key, required this.localizations});
  final AppLocalizations localizations;

  @override
  State<CoachingTestPageView> createState() => _CoachingTestPageViewState();
}

class _CoachingTestPageViewState extends State<CoachingTestPageView> {
  late List<QuestionModel> questionsList;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    questionsList = getQuestions(widget.localizations);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocListener<CoachingTestCubit, CoachingTestState>(
      listenWhen: (previous, current) => current is CoachingTestSuccess,
      listener: (context, state) {
        GoRouter.of(context).goNamed(
          CoachingTestResultPage.name,
          extra: state.testModel,
        );
      },
      child: PageView.builder(
        itemCount: questionsList.length,
        controller: _pageController,
        scrollDirection: height > width ? Axis.horizontal : Axis.vertical,
        itemBuilder: (context, index) {
          return QuestionPage(
            question: questionsList[index],
            pageController: _pageController,
            onCompleted: (key, value) async {
              context.read<CoachingTestCubit>().updateTest(
                    key,
                    value,
                  );
              if (index == questionsList.length - 1) {
                await context.read<CoachingTestCubit>().submitTest();
              }
            },
          );
        },
      ),
    );
  }
}
