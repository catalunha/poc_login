import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poc_login/app/core/app_config.dart';
import 'package:poc_login/app/pages/login/controller/providers.dart';
import 'package:poc_login/app/pages/login/controller/states.dart';
import 'package:poc_login/app/routes.dart';
import 'package:validatorless/validatorless.dart';

import '../utils/app_loader.dart';
import '../utils/app_messages.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>
    with AppMessages, AppLoader {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      loginControllerProvider,
      (previous, next) {
        switch (next.status) {
          case LoginStateStatus.initial:
            break;
          case LoginStateStatus.loaging:
            showLoader(context);
          case LoginStateStatus.success:
            hideLoader(context);
            Navigator.of(context)
                .pushNamedAndRemoveUntil(AppRoute.home.name, (route) => false);
          case LoginStateStatus.error:
            hideLoader(context);
            showMessageError(context, next.error!);
        }
      },
    );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text('Seja vem vindo ao'),
                const Text('POC Login'),
                const Text('com DjangoREST, Riverpod'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        label: Text('email'),
                      ),
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      validator: Validatorless.multiple(
                        [
                          Validatorless.required('Campo obrigatório'),
                          // Validatorless.email('Campo deve ser um email'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: password,
                    // obscureText: true,
                    decoration: const InputDecoration(
                      label: Text('password'),
                    ),
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Campo obrigatório'),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case (false || null):
                        showMessageInfo(
                            context, 'Alguns campos estão inválidos');

                      case true:
                        ref
                            .read(loginControllerProvider.notifier)
                            .login(email.text, password.text);
                    }
                  },
                  child: const Text('Solicitar login'),
                ),
                ElevatedButton(
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case (false || null):
                        print('form error');
                        showMessageError(context,
                            'Ainda não implementado. Mas... Alguns campos estão inválidos');
                        break;
                      case true:
                        ref
                            .read(loginControllerProvider.notifier)
                            .create(email.text, password.text);
                    }
                  },
                  child: const Text('Registrar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
