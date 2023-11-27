import 'package:flutter/material.dart';
import 'package:fooderlich/models/profile_manger.dart';
import 'package:fooderlich/models/user.dart';
import 'package:provider/provider.dart';

import '../components/circle_image.dart';
import '../models/models.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  final User user;
  final int currentTab;

  const ProfileScreen({
    super.key,
    required this.user,
    required this.currentTab,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            buildProfile(),
            Expanded(
              child: buildMenu(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenu() {
    return ListView(
      children: [
        buildDarkModeRow(),
        ListTile(
          title: const Text('View raywenderlich.com'),
          onTap: () async {
            if (kIsWeb || Platform.isMacOS) {
              await launchUrl(
                Uri.parse('https://www.raywenderlich.com/'),
              );
            } else {}
          },
        ),
        ListTile(
          title: const Text('Log out'),
          onTap: () async {},
        ),
      ],
    );
  }

  Widget buildDarkModeRow() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Dark Mode'),
          Switch(
            value: widget.user.darkMode,
            onChanged: (value) {
              Provider.of<ProfileManger>(context, listen: false).darkMode =
                  value;
            },
          ),
        ],
      ),
    );
  }

  Widget buildProfile() {
    return Column(
      children: [
        CircleImage(
          imageProvider: AssetImage(widget.user.profileImageUrl),
          imageRadius: 60.0,
        ),
        const SizedBox(height: 16),
        Text(
          widget.user.firstName,
          style: const TextStyle(
            fontSize: 21,
          ),
        ),
        Text(widget.user.role),
        Text(
          '${widget.user.points} points',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
