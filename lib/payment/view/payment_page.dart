// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui_web' as ui;

import 'package:coaching/app/widgets/coaching_app_bar.dart';
import 'package:coaching/app/widgets/coaching_drawer.dart';
import 'package:coaching/coaching_test/view/coaching_test_page.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/payment/cubit/payment_cubit.dart';
import 'package:coaching/payment/widgets/payment_method_widget.dart';
import 'package:coaching/welcome/models/subscription.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functions_repository/functions_repository.dart';
import 'package:go_router/go_router.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key, this.isSuccess});

  static const name = 'PaymentPage';
  final bool? isSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(
        firestoreRepository: context.read<FirestoreRepository>(),
        dataPersistenceRepository: context.read<DataPersistenceRepository>(),
        functionsRepository: context.read<FunctionsRepository>(),
      ),
      child: PaymentView(isSuccess: isSuccess ?? false),
    );
  }
}

class PaymentView extends StatefulWidget {
  const PaymentView({super.key, this.isSuccess});

  final bool? isSuccess;

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  static const viewID = 'wallet_container';
  static const htmlCode = '''
    <div class="wallet_container">
       <div id="wallet_container"></div>
       <div className="wallet_container"></div>
    </div>
  ''';

  @override
  void initState() {
    if (widget.isSuccess ?? false) {
      context.read<PaymentCubit>().updatePaidUser();
    }
    ui.platformViewRegistry.registerViewFactory(
      viewID,
      (int id) => html.DivElement()
        ..appendHtml(htmlCode)
        ..style.height = '100%'
        ..style.width = '100%'
        ..style.border = 'none',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4),
                  Text(context.l10n.paymentError),
                ],
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
        if (state is PaymentSuccess) {
          return context.goNamed(CoachingTestPage.name);
        }
        if (state is PaymentSelected) {
          showDialog<void>(
            context: context,
            builder: (context) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    height: 100,
                    width: 300,
                    child: HtmlElementView(
                      key: UniqueKey(),
                      viewType: viewID,
                      onPlatformViewCreated: (id) => js.context.callMethod(
                        'myFunction',
                        [state.preferenceId],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
      child: Scaffold(
        appBar: const CoachingAppBar(),
        endDrawer: const CoachingDrawer(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.l10n.choosePlan,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  context.l10n.choosePlanDescription,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PaymentMethodWidget(subscription: Subscription.basic),
                      PaymentMethodWidget(subscription: Subscription.premium),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
