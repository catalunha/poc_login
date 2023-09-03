import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poc_login/app/repositories/providers.dart';
import 'package:poc_login/app/services/providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meUser = ref.watch(meUserProvider);
    final meProfile = ref.watch(meProfileProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () {
                ref.read(logoutProvider);
              },
            ),
            Card(
              margin: const EdgeInsets.all(8),
              child: meUser.when(
                data: (data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('User'),
                      Text('id: ${data.id}'),
                      Text('UserName: ${data.username}'),
                    ],
                  );
                },
                error: (error, stackTrace) {
                  return const Text('Nao foi possivel obter me');
                },
                loading: () {
                  return const CircularProgressIndicator();
                },
              ),
            ),
            Card(
              child: meProfile.when(
                data: (data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Profile'),
                      Text('id: ${data.id}'),
                      Text('userId: ${data.userId}'),
                      Text('UserName: ${data.userName}'),
                      Text('Name: ${data.name}'),
                    ],
                  );
                },
                error: (error, stackTrace) {
                  return const Text('Nao foi possivel obter me');
                },
                loading: () {
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
