import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poc_login/app/pages/splash/controller/providers.dart';

import '../../routes.dart';
import 'controller/states.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final splashController = ref.watch(splashControllerProvider);
    ref.listen(splashControllerProvider, (previous, next) {
      next.when(
        data: (data) {
          switch (data.status) {
            case SplashStateStatus.login:
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoute.login.name, (route) => false);
            case SplashStateStatus.logged:
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoute.home.name, (route) => false);
            case _:
              break;
          }
        },
        error: (error, stackTrace) {
          return Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoute.login.name, (route) => false);
        },
        loading: () {},
      );
    });
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('SplashPage'),
        // ),
        body: splashController.when(
      data: (data) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              for (String msg in data.msg) Text(msg)
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return const Center(
          child: Text('Oops. Ocorreu algum erro'),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}
