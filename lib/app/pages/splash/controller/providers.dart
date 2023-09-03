import 'dart:developer';

import 'package:poc_login/app/pages/splash/controller/states.dart';
import 'package:poc_login/app/services/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
class SplashController extends _$SplashController {
  @override
  Future<SplashState> build() async {
    //+++ modo lento
    // log('start', name: 'SplashController.build');
    // final msgs = <String>[];
    // msgs.add('Buscando token de último login ...');
    // state = AsyncValue.data(
    //     SplashState(status: SplashStateStatus.initial, msg: msgs));
    // await Future.delayed(const Duration(seconds: 2));
    // final hasToken = await ref.read(userServiceProvider).hasToken();
    // if (hasToken) {
    //   // msgs.length
    //   msgs[msgs.length - 1] = '${msgs[msgs.length - 1]} ✅';
    //   msgs.add('Encontrado. Indo para Home...');
    //   state =
    //       AsyncData(SplashState(status: SplashStateStatus.initial, msg: msgs));
    //   await Future.delayed(const Duration(seconds: 2));
    //   return SplashState(status: SplashStateStatus.logged);
    // } else {
    //   msgs[msgs.length - 1] = '${msgs[msgs.length - 1]} 🚫';
    //   msgs.add('Não encontrado. Indo para Login...');
    //   state =
    //       AsyncData(SplashState(status: SplashStateStatus.initial, msg: msgs));
    //   await Future.delayed(const Duration(seconds: 2));
    // }
    //--- modo lento

    //+++ modo rápido
    await Future.delayed(const Duration(seconds: 2));
    final hasToken = await ref.read(userServiceProvider).hasToken();
    if (hasToken) {
      return SplashState(status: SplashStateStatus.logged);
    }
    //--- modo rápido

    return SplashState(status: SplashStateStatus.login);
  }
}
