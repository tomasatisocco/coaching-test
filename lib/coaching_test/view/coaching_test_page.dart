import 'package:coaching/coaching_test/cubit/coaching_test_cubit.dart';
import 'package:coaching/coaching_test/models/question_model.dart';
import 'package:coaching/coaching_test/view/question_page.dart';
import 'package:coaching/test_results/view/coaching_test_results_page.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storage_repository/storage_repository.dart';

class CoachingTestPage extends StatelessWidget {
  const CoachingTestPage({super.key});

  static const name = 'CoachingTestPage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CoachingTestCubit(
        firestoreRepository: context.read<FirestoreRepository>(),
        dataPersistenceRepository: context.read<DataPersistenceRepository>(),
        storageRepository: context.read<StorageRepository>(),
      )..init(),
      child: const CoachingTestPageView(),
    );
  }
}

class CoachingTestPageView extends StatefulWidget {
  const CoachingTestPageView({super.key});

  @override
  State<CoachingTestPageView> createState() => _CoachingTestPageViewState();
}

class _CoachingTestPageViewState extends State<CoachingTestPageView> {
  late List<QuestionModel> questionsList;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    questionsList =
        context.read<CoachingTestCubit>().state.testModel.questions.toList();
    final initialPage =
        questionsList.where((element) => element.value != null).length;
    _pageController = PageController(initialPage: initialPage);
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
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        scrollDirection: height > width ? Axis.horizontal : Axis.vertical,
        itemBuilder: (context, index) {
          return QuestionPage(
            question: questionsList[index],
            pageController: _pageController,
            currentPageIndex: index,
            onCompleted: (key, value) async {
              await context.read<CoachingTestCubit>().updateTest(
                    key,
                    value,
                  );
              if (!mounted) return;
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
