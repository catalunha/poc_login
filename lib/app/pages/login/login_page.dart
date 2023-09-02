import 'package:flutter/material.dart';
import 'package:poc_login/app/core/app_constants.dart';
import 'package:validatorless/validatorless.dart';

import '../utils/app_messages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AppMessages {
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
                SizedBox(
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
                        Validatorless.email('Campo deve ser um email'),
                      ],
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
                        print('form error');
                        showMessageError(context, 'teste');
                        break;
                      case true:
                        print('form ok');
                        break;
                    }
                  },
                  child: const Text('Solicitar login'),
                ),
                ElevatedButton(
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case (false || null):
                        print('form error');
                        showMessageError(context, 'teste');
                        break;
                      case true:
                        print('form ok');
                        break;
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
