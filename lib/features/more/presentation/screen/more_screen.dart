import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moriko/config/config.dart';
import 'package:moriko/core/core.dart';
import 'package:moriko/features/shared/presentation/widgets/nav_bar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      appBar: AppBar(
        backgroundColor: transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'More',
          style: poppins(),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Assets.icons.game.image(
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Divider(),
          MorePageTile(
            icon: PhosphorIconsRegular.moonStars,
            title: 'Dark Mode',
            trailing: Consumer(
              builder: (context, ref, child) {
                final themeMode = ref.watch(currentThemeProvider);
                return Visibility(
                  visible: themeMode != ThemeMode.system,
                  child: CupertinoSwitch(
                    activeColor: Colors.indigo,
                    value: themeMode != ThemeMode.light,
                    onChanged: (v) {
                      ref.read(currentThemeProvider.notifier).toggle();
                    },
                  ),
                );
              },
            ),
          ),
          MorePageTile(
            icon: PhosphorIconsRegular.hardDrives,
            title: 'Data Saver',
            trailing: Consumer(builder: (context, ref, child) {
              final dataSaverEnabled = ref.watch(dataSaverModeProvider);
              return CupertinoSwitch(
                activeColor: Colors.indigo,
                value: dataSaverEnabled,
                onChanged: (v) {
                  ref.read(dataSaverModeProvider.notifier).toggle();
                },
              );
            }),
          ),
          const Divider(),
          const MorePageTile(
            icon: PhosphorIconsRegular.detective,
            title: 'History',
          ),
          const MorePageTile(
            icon: PhosphorIconsRegular.gear,
            title: 'Settings',
          ),
          const MorePageTile(
            icon: PhosphorIconsRegular.appWindow,
            title: 'About',
          ),
          const MorePageTile(
            icon: PhosphorIconsRegular.warning,
            title: 'Disclaimer',
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => launchUrlString('github.com/subrotokumar/moriko'),
            child: Chip(
              avatar: Assets.icons.github
                  .image(color: context.theme.iconTheme.color, height: 20),
              label: Text(
                'GitHub',
                style: poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MorePageTile extends StatelessWidget {
  const MorePageTile({
    super.key,
    required this.title,
    this.onTap,
    required this.icon,
    this.trailing,
  });
  final String title;
  final VoidCallback? onTap;
  final IconData icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      leading: Icon(icon),
      title: Text(
        title,
        style: poppins(fontWeight: FontWeight.w400, fontSize: 20),
      ),
      trailing: trailing,
    );
  }
}
