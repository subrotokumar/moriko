import 'package:flutter/material.dart';
import 'package:moriko/config/config.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'History',
          style: poppins(
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(PhosphorIcons.broom(PhosphorIconsStyle.fill)),
          ),
        ],
      ),
    );
  }
}
