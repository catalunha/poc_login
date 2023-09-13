import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../routes.dart';
import '../utils/app_loader.dart';
import '../utils/app_messages.dart';
import 'controller/providers.dart';
import 'controller/states.dart';

class NewPasswordPage extends ConsumerStatefulWidget {
  final String email;
  const NewPasswordPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  ConsumerState<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends ConsumerState<NewPasswordPage>
    with AppMessages, AppLoader {
  final formKey = GlobalKey<FormState>();
  final number = TextEditingController();
  final password = TextEditingController();
  final repeatPassword = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    number.dispose();
    password.dispose();
    repeatPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      newPasswordControllerProvider,
      (previous, next) {
        switch (next.status) {
          case NewPasswordStateStatus.initial:
            break;
          case NewPasswordStateStatus.loading:
            showLoader(context);

          case NewPasswordStateStatus.success:
            hideLoader(context);
            Navigator.of(context)
                .pushNamedAndRemoveUntil(AppRoute.home.name, (route) => false);
          case NewPasswordStateStatus.error:
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
                const Text('Verifique o email informado'),
                Text(widget.email),
                const Text('Anote o código contido nele e informe aqui'),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: number,
                    // obscureText: true,
                    decoration: const InputDecoration(
                      label: Text('Número'),
                    ),
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Campo obrigatório'),
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
                      label: Text('Senha'),
                    ),
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Campo obrigatório'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: repeatPassword,
                    // obscureText: true,
                    decoration: const InputDecoration(
                      label: Text('Repita a senha'),
                    ),
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Campo obrigatório'),
                        Validatorless.compare(password, 'Senhas não confere')
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    formKey.currentState?.reset();
                    switch (formKey.currentState?.validate()) {
                      case (false || null):
                        showMessageInfo(context,
                            'Campos obrigatórios não foram preenchidos');

                      case true:
                        ref
                            .read(newPasswordControllerProvider.notifier)
                            .newpassword(
                              email: widget.email,
                              number: number.text,
                              password: password.text,
                            );
                    }
                  },
                  child: const Text('Solicitar login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
