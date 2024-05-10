import 'package:code_timer/code_timer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:orange/orange.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton.extended(
              onPressed: () async {
                await Orange.init();
                CodeTimer.start();
                for (int i = 0; i < 10000; i++) {
                  Orange.setInt('$i', i);
                }
                CodeTimer.stop(label: 'orange 🍊 write performance test');
              },
              label: const Text('orange write performance test'),
            ),
            const Gap(20),
            FloatingActionButton.extended(
              onPressed: () async {
                await Orange.init();
                CodeTimer.start();
                for (int i = 0; i < 10000; i++) {
                  Orange.getInt('$i');
                }
                CodeTimer.stop(label: 'orange 🍊read performance test');
              },
              label: const Text('orange read performance test'),
            ),
            const Gap(20),
            FloatingActionButton.extended(
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                CodeTimer.start();
                for (int i = 0; i < 10000; i++) {
                  await pref.setInt('$i', i);
                }
                CodeTimer.stop(label: 'shared_preferences write performance test');
              },
              label: const Text('shared_preferences write performance test'),
            ),
            const Gap(20),
            FloatingActionButton.extended(
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                CodeTimer.start();
                for (int i = 0; i < 10000; i++) {
                  pref.getInt('$i');
                }
                CodeTimer.stop(label: 'shared_preferences read performance test');
              },
              label: const Text('shared_preferences read performance test'),
            ),
          ],
        ),
      ),
    );
  }
}
