import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants/assets.dart';
import '../utils/prefs.dart';
import '../utils/routes.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: PopupMenuButton(
            icon: CircleAvatar(
              child: Image.asset(Assets.iconProfile),
            ),
            offset: const Offset(0.0, kToolbarHeight),
            onSelected: (int val) async {
              await Supabase.instance.client.auth.signOut();
              Prefs.setIsLogin(false);
              Navigator.pushReplacementNamed(context, Routes.login);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}