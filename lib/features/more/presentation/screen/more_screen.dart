import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:moriko/config/config.dart';
import 'package:moriko/core/core.dart';
import 'package:moriko/features/shared/presentation/widgets/nav_bar.dart';

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
          Text(
            'Moriko',
            textAlign: TextAlign.center,
            style: poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Text(
            'Powered by MangaDex',
            textAlign: TextAlign.center,
            style: poppins(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
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
          MorePageTile(
            onTap: () => HistoryScreenRoute().push(context),
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
          MorePageTile(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Disclaimer',
                              style: poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'The developer of this application does not have any affiliation with the content providers available. Manga Reader is a tool for users to access and read manga titles, and the developer is not responsible for the content provided by external sources.',
                          style: poppins(),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: PhosphorIconsRegular.warning,
            title: 'Disclaimer',
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () =>
                launchUrlString('https://github.com/subrotokumar/moriko'),
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
          const SizedBox(height: 10),
          Text(
            'Version 0.1.0 - alpha',
            style: poppins(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
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
