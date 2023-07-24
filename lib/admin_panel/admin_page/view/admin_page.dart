import 'package:coaching/admin_panel/admin_login/widgets/admin_drawer.dart';
import 'package:coaching/admin_panel/admin_page/cubits/tests_cubit/admin_tests_cubit.dart';
import 'package:coaching/admin_panel/admin_page/cubits/users_cubit/admin_users_cubit.dart';
import 'package:coaching/admin_panel/admin_page/widgets/users_column.dart';
import 'package:coaching/l10n/l10n.dart';
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
          const UsersColumn(),
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
