import 'package:coaching/admin_panel/admin_page/cubits/tests_cubit/admin_tests_cubit.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestExpandableWidget extends StatefulWidget {
  const TestExpandableWidget({super.key, required this.testIds});

  final List<String>? testIds;

  @override
  State<TestExpandableWidget> createState() => _TestExpandableWidgetState();
}

class _TestExpandableWidgetState extends State<TestExpandableWidget> {
  int selected = -1;
  late List<String>? testIds;

  @override
  void initState() {
    if (widget.testIds?.isEmpty ?? false) {
      testIds = null;
    } else {
      testIds = widget.testIds?.reversed.toList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width - 250,
      height: 300,
      child: Visibility(
        visible: testIds?.isNotEmpty ?? false,
        child: ListView.builder(
          itemCount: testIds?.length ?? 0,
          itemBuilder: (context, index) {
            return BlocProvider(
              key: ValueKey(testIds?[index]),
              create: (context) => AdminTestsCubit(
                firestoreRepository: context.read<FirestoreRepository>(),
                testId: testIds?[index] ?? '',
              ),
              child: ExpansionTile(
                title: Text(testIds?[index] ?? ''),
                initiallyExpanded: index == selected,
                onExpansionChanged: (newState) {
                  setState(() {
                    selected = newState ? index : -1;
                  });
                },
                children: const [
                  ResultsWidget(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ResultsWidget extends StatelessWidget {
  const ResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width - 250,
      child: BlocBuilder<AdminTestsCubit, AdminTestsState>(
        builder: (context, state) {
          if (state is AdminTestsInitial) {
            context.read<AdminTestsCubit>().getTest();
          }
          if (state is AdminTestsFetching) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AdminTestsFetched) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                    child: ListTile(
                      title: Text(
                        state.test.coachingTestDate.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ...state.test.questions.map((e) {
                    return SizedBox(
                      height: 40,
                      child: ListTile(
                        title: Text(e.getQuestion(context.l10n)),
                        subtitle: Text(
                          e
                              .answers(context.l10n)
                              .map(
                                (key, value) => MapEntry(value, key),
                              )[e.value ?? 0 ~/ e.multiplier]
                              .toString(),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          }
          return Center(
            child: Text(context.l10n.notSelected),
          );
        },
      ),
    );
  }
}
