import 'package:auth_repository/auth_repository.dart';
import 'package:coaching/admin_panel/admin_login/models/admin_loing_validators.dart';
import 'package:coaching/authentication/login/cubit/login_cubit.dart';
import 'package:coaching/authentication/register/view/register_page.dart';
import 'package:coaching/coaching_test/view/coaching_test_page.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/payment/view/payment_page.dart';
import 'package:coaching/test_results/view/congratulations_page.dart';
import 'package:coaching/welcome/models/user_date_model.dart';
import 'package:coaching/welcome/view/welcome_page.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
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
        dataPersistenceRepository: context.read<DataPersistenceRepository>(),
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
  var _isPasswordVisible = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is! LoginSuccess) return;
          final user = state.userDataModel;
          switch (user.status) {
            case Status.registered:
              return context.goNamed(WelcomePage.name);
            case Status.infoCompleted:
              return context.goNamed(PaymentPage.name);
            case Status.testPaid:
            case Status.testStarted:
              return context.goNamed(CoachingTestPage.name);
            case Status.testCompleted:
            case Status.resultsSending:
            case Status.resultsSent:
              return context.goNamed(CongratulationsPage.name);
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: context.pop,
                              icon: Icon(
                                Icons.close,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
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
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              icon: _isPasswordVisible
                                  ? const Icon(Icons.visibility_outlined)
                                  : const Icon(Icons.visibility_off_outlined),
                            ),
                          ),
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          validator: (value) =>
                              AdminLoginValidators.validatePassword(
                            value,
                            context.l10n,
                          ),
                          onFieldSubmitted: (_) {
                            if (!formKey.currentState!.validate()) return;
                            context
                                .read<LoginCubit>()
                                .logInWithEmailAndPassword(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                          },
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
                          onPressed: () {
                            context.pop();
                            showDialog<void>(
                              context: context,
                              builder: (context) => const RegisterPage(),
                            );
                          },
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
