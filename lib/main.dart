import 'package:devcafe_app/status_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        return StatusBarProgress(
          child: child!,
        );
      },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    ScrollNotificationObserverState? scrollNotificationObserverState =
        ScrollNotificationObserver.of(context);
    scrollNotificationObserverState?.removeListener(_onScroll);
    scrollNotificationObserverState?.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello'),
      ),
      body: Scrollbar(
        child: ListView(
          children: List<int>.generate(100, (i) => i).map((i) {
            return ListTile(
              title: Text('Item $i'),
            );
          }).toList(growable: false),
        ),
      ),
    );
  }

  void _onScroll(ScrollNotification scrollNotification) {
    StatusBarProgressController.of(context)?.progress =
        scrollNotification.metrics.pixels /
            scrollNotification.metrics.maxScrollExtent;
  }
}
