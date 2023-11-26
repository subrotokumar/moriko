import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moriko/config/config.dart';
import 'package:moriko/features/shared/presentation/widgets/nav_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moriko', style: poppins()),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(CupertinoIcons.heart_fill),
          ),
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
