import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/widgets/mobile_frame.dart';
import 'features/admin/admin_shell.dart';
import 'features/customer/customer_shell.dart';
import 'features/provider/provider_shell.dart';
import 'features/role_select/role_select_screen.dart';

class AtYourServiceApp extends StatelessWidget {
  const AtYourServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'At Your Service',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      builder: (context, child) => MobileFrame(child: child!),
      initialRoute: RoleSelectScreen.routeName,
      routes: {
        RoleSelectScreen.routeName: (_) => const RoleSelectScreen(),
        CustomerShell.routeName: (_) => const CustomerShell(),
        ProviderShell.routeName: (_) => const ProviderShell(),
        AdminShell.routeName: (_) => const AdminShell(),
      },
    );
  }
}
