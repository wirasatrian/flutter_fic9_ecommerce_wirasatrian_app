import 'package:fic9_ecommerce_template_app/data/datasources/auth_local_datasource.dart';
import 'package:fic9_ecommerce_template_app/presentation/auth/login_page.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onPressed: () {
          AuthLocalDatasource().removeAuthData();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        },
        child: const Text('Log Out'),
      ),
    ));
  }
}
