import 'package:coaching/admin_panel/admin_login/widgets/admin_drawer.dart';
import 'package:coaching/admin_panel/admin_page/cubits/tests_cubit/admin_tests_cubit.dart';
import 'package:coaching/admin_panel/admin_page/cubits/users_cubit/admin_users_cubit.dart';
import 'package:coaching/coaching_test/models/test_model_keys.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/test_results/widgets/field_score_widget.dart';
import 'package:coaching/test_results/widgets/total_score_widget.dart';
import 'package:coaching/utils/color_getters.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AdminUsersCubit(
            firestoreRepository: context.read<FirestoreRepository>(),
          )..init(),
        ),
        BlocProvider(
          create: (context) => AdminTestsCubit(
            firestoreRepository: context.read<FirestoreRepository>(),
          ),
        ),
      ],
      child: const AdminView(),
    );
  }
}

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.admin,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      endDrawer: const AdminDrawer(),
      body: Row(
        children: [
          Column(
            children: [
              Container(
                height: 40,
                width: 250,
                color: Theme.of(context).primaryColor,
                child: const Center(
                  child: Text(
                    'Usuarios',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: 250,
                height: MediaQuery.of(context).size.height - 100,
                color: Colors.grey.shade100,
                child: BlocBuilder<AdminUsersCubit, AdminUsersState>(
                  builder: (context, state) {
                    if (state is! AdminUsersFetched) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final users = state.users
                      ..sort(
                        (a, b) => (b.createdAt ?? DateTime.now()).compareTo(
                          a.createdAt ?? DateTime.now(),
                        ),
                      );
                    return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final userId = users[index].authId;
                        final selectedUserId = state.user?.authId;
                        return ListTile(
                          title: Text(users[index].name ?? ''),
                          subtitle: Text(users[index].email ?? ''),
                          selected: selectedUserId == userId,
                          onTap: () async {
                            if (userId == null) return;
                            await context
                                .read<AdminUsersCubit>()
                                .selectUser(userId);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width - 250,
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Text(
                    context.l10n.results,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 100,
                width: MediaQuery.of(context).size.width - 250,
                child: BlocBuilder<AdminTestsCubit, AdminTestsState>(
                  builder: (context, state) {
                    if (state is AdminTestsFetching) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is AdminTestsFetched) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 250,
                              color: Theme.of(context).primaryColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GeneralScoreWidget(
                                    score: state.test.totalQualification
                                        .toString(),
                                    radio: 40,
                                    scoreColor: getTotalColor(
                                      state.test.totalQualification,
                                    ),
                                  ),
                                  FieldScoreWidget(
                                    title: context.l10n.qualityOfService,
                                    radio: 20,
                                    score: state.test.getGroupAnswersTotal(
                                      AnswerGroup.qualityOfService,
                                    ),
                                    scoreColor: getQualityColor(
                                      state.test.getGroupAnswersTotal(
                                        AnswerGroup.qualityOfService,
                                      ),
                                    ),
                                    removeUpperPadding: true,
                                  ),
                                  FieldScoreWidget(
                                    title: context.l10n.businessCreation,
                                    radio: 20,
                                    score: state.test.getGroupAnswersTotal(
                                      AnswerGroup.business,
                                    ),
                                    scoreColor: getQualityColor(
                                      state.test.getGroupAnswersTotal(
                                        AnswerGroup.business,
                                      ),
                                    ),
                                    removeUpperPadding: true,
                                  ),
                                  FieldScoreWidget(
                                    title: context.l10n.personalWellness,
                                    radio: 20,
                                    score: state.test.getGroupAnswersTotal(
                                      AnswerGroup.personal,
                                    ),
                                    scoreColor: getQualityColor(
                                      state.test.getGroupAnswersTotal(
                                        AnswerGroup.personal,
                                      ),
                                    ),
                                    removeUpperPadding: true,
                                  ),
                                  FieldScoreWidget(
                                    title: context.l10n.aportToTheCommunity,
                                    radio: 20,
                                    score: state.test.getGroupAnswersTotal(
                                      AnswerGroup.community,
                                    ),
                                    scoreColor: getQualityColor(
                                      state.test.getGroupAnswersTotal(
                                        AnswerGroup.community,
                                      ),
                                    ),
                                    removeUpperPadding: true,
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Text(
                                state.test.coachingTestDate.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                context.l10n.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(state.user.name ?? ''),
                            ),
                            ListTile(
                              title: Text(
                                context.l10n.email,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(state.user.email ?? ''),
                            ),
                            ListTile(
                              title: Text(
                                context.l10n.nationality,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(state.user.nationality ?? ''),
                            ),
                            ListTile(
                              title: Text(
                                context.l10n.residenceCountry,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(state.user.residence ?? ''),
                            ),
                            ListTile(
                              title: Text(
                                context.l10n.birthDate,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(state.user.birthDate ?? ''),
                            ),
                            ListTile(
                              title: Text(
                                context.l10n.yearOfCertification,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(state.user.certificateDate ?? ''),
                            ),
                            ...state.test.questions.map((e) {
                              return ListTile(
                                title: Text(e.getQuestion(context.l10n)),
                                subtitle: Text(
                                  e
                                      .answers(context.l10n)
                                      .map(
                                        (key, value) => MapEntry(value, key),
                                      )[e.value ?? 0 ~/ e.multiplier]
                                      .toString(),
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
