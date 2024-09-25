import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/speed_provider2.dart';
import 'dart:math';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'speedomter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final counter = ref.watch(speedProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: switch (counter) {
          AsyncData(:final value) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "4 × ${(value[1].time / 4).toString()} ms",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${value[1].speed.toString().substring(0, min(5, value[1].speed.toString().length))} km/h",
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "2 × ${(value[3].time / 2).toString()} ms",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${value[3].speed.toString().substring(0, min(5, value[3].speed.toString().length))} km/h",
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${(value[0].time).toString()} ms",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${value[0].speed.toString().substring(0, min(5, value[0].speed.toString().length))} km/h",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${(value[2].time).toString()} ms",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${value[2].speed.toString().substring(0, min(5, value[2].speed.toString().length))} km/h",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          AsyncError(:final error) => Text(
              error.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          _ => const CircularProgressIndicator(),
        },
      ),
    );
  }
}
