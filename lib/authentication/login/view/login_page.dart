import 'package:auth_repository/auth_repository.dart';
import 'package:coaching/admin_panel/admin_login/models/admin_loing_validators.dart';
import 'package:coaching/app/widgets/coaching_app_bar.dart';
import 'package:coaching/app/widgets/coaching_drawer.dart';
import 'package:coaching/authentication/login/cubit/login_cubit.dart';
import 'package:coaching/authentication/register/view/register_page.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/welcome/models/user_date_model.dart';
import 'package:coaching/welcome/view/welcome_page.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const name = 'LoginPage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        firestoreRepository: context.read<FirestoreRepository>(),
        authRepository: context.read<AuthRepository>(),
      ),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoachingAppBar(),
      endDrawer: const CoachingDrawer(),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is! LoginSuccess) return;
          final user = state.userDataModel;
          switch (user.status) {
            case Status.registered:
              return GoRouter.of(context).goNamed(
                WelcomePage.name,
                extra: user,
              );
            case Status.infoCompleted:
            case Status.testPaid:
            case Status.testStarted:
            case Status.testCompleted:
            case Status.resultsSending:
            case Status.resultsSent:
            case null:
          }
        },
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        Text(
                          context.l10n.login,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: context.l10n.email,
                            border: const OutlineInputBorder(),
                          ),
                          controller: _emailController,
                          validator: (value) =>
                              AdminLoginValidators.validateEmail(
                            value,
                            context.l10n,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: context.l10n.password,
                            border: const OutlineInputBorder(),
                          ),
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value) =>
                              AdminLoginValidators.validatePassword(
                            value,
                            context.l10n,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Visibility(
                          visible: state is LoginFailure,
                          child: Text(
                            context.l10n.loginError,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (!formKey.currentState!.validate()) return;
                            context
                                .read<LoginCubit>()
                                .logInWithEmailAndPassword(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                          },
                          child: SizedBox(
                            height: 40,
                            width: 90,
                            child: Center(
                              child: state is LoginLoading
                                  ? const SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Text(context.l10n.login),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () =>
                              GoRouter.of(context).pushNamed(RegisterPage.name),
                          child: Text(
                            context.l10n.register,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}