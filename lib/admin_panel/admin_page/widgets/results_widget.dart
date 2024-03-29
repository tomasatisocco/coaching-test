import 'package:coaching/admin_panel/admin_page/cubits/tests_cubit/admin_tests_cubit.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functions_repository/functions_repository.dart';

class TestExpandableWidget extends StatefulWidget {
  const TestExpandableWidget({
    super.key,
    required this.testIds,
    this.isMobile = false,
  });

  final List<String>? testIds;
  final bool isMobile;

  @override
  State<TestExpandableWidget> createState() => _TestExpandableWidgetState();
}

class _TestExpandableWidgetState extends State<TestExpandableWidget> {
  int selected = -1;
  List<String>? testIds;

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
  void didUpdateWidget(covariant TestExpandableWidget oldWidget) {
    if (widget.testIds?.isEmpty ?? false) {
      testIds = null;
    } else {
      testIds = widget.testIds?.reversed.toList();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.isMobile
          ? MediaQuery.sizeOf(context).width
          : MediaQuery.sizeOf(context).width - 250,
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
                functionsRepository: context.read<FunctionsRepository>(),
                testId: testIds?[index] ?? '',
              ),
              child: Builder(
                builder: (context) {
                  return ExpansionTile(
                    title: Text(testIds?[index] ?? ''),
                    // trailing: ElevatedButton(
                    //   child: Text('Reenviar resultados'),
                    //   onPressed: () {
                    //     context
                    //         .read<AdminTestsCubit>()
                    //         .reSendTest(testIds?[index]);
                    //   },
                    // ),
                    initiallyExpanded: index == selected,
                    onExpansionChanged: (newState) {
                      setState(() {
                        selected = newState ? index : -1;
                      });
                    },
                    children: [
                      ResultsWidget(
                        isMobile: widget.isMobile,
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class ResultsWidget extends StatelessWidget {
  const ResultsWidget({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: isMobile
          ? MediaQuery.sizeOf(context).width
          : MediaQuery.sizeOf(context).width - 250,
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
                  ListTile(
                    title: Text(
                      state.test.coachingTestDate.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...state.test.questions.map((e) {
                    return ListTile(
                      title: Text(e.getQuestion(context.l10n)),
                      subtitle: Text(e.answerText(context.l10n)),
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
