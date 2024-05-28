import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sulchanggo/login/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _getData() async {
    final supabase = Provider.of<SupabaseClient>(context, listen: false);

    print(supabase.auth.currentUser?.email);
  }

  Future<void> _signOut() async {
    final supabase = Provider.of<SupabaseClient>(context, listen: false);

    await supabase.auth.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Row(
                children: [
                  ShadButton(
                    text: const Text('Get Data'),
                    onPressed: () {
                      _getData();
                    },
                  ),
                  ShadButton(
                    text: const Text('Sign Out'),
                    onPressed: () {
                      _signOut();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
