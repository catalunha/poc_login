import 'dart:developer';

import 'package:poc_login/app/pages/splash/controller/states.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
class SplashController extends _$SplashController {
  @override
  Future<SplashState> build() async {
    // log('start', name: 'SplashController.build');
    // final msgs = <String>[];
    // msgs.add('Iniciando...');
    // state = AsyncValue.data(
    //     SplashState(status: SplashStateStatus.initial, msg: msgs));
    // await Future.delayed(const Duration(seconds: 5));
    // // msgs.length
    // msgs[msgs.length - 1] = '${msgs[msgs.length - 1]} ✅';

    // log('5 secs', name: 'SplashController.build');
    // msgs.add('Obtendo dados de ...');
    // state =
    //     AsyncData(SplashState(status: SplashStateStatus.initial, msg: msgs));

    // await Future.delayed(const Duration(seconds: 5));
    // log('10 secs', name: 'SplashController.build');
    return SplashState(status: SplashStateStatus.login);
  }
}
