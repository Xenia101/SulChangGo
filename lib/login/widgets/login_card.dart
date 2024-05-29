import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sulchanggo/home/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({
    super.key,
  });

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  Future<void> _login(String email, String password) async {
    final supabase = Provider.of<SupabaseClient>(context, listen: false);
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } catch (error) {
      ShadToaster.of(context).show(
        ShadToast.destructive(
          title: const Text('Login failed. Please check your input.'),
          description: Text(error.toString()),
          alignment: Alignment.topCenter,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final formKey = GlobalKey<ShadFormState>();

    return ShadForm(
      key: formKey,
      child: ShadCard(
        width: 350,
        title: Text('SulChangGo', style: theme.textTheme.h4),
        description: const Text('Login to your account'),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ShadInputFormField(
                id: 'email',
                label: const Text('Email'),
                placeholder: const Text('Enter your email'),
                validator: (v) {
                  if (v.length < 2) {
                    return 'Email must be at least 2 characters.';
                  }
                  return null;
                },
              ),
              ShadInputFormField(
                id: 'password',
                label: const Text('Password'),
                placeholder: const Text('Enter your password'),
                obscureText: true,
                validator: (v) {
                  if (v.length < 2) {
                    return 'Password must be at least 2 characters.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        footer: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ShadButton(
              text: const Text(
                'Login',
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                if (formKey.currentState!.saveAndValidate()) {
                  _login(
                    formKey.currentState!.value['email'],
                    formKey.currentState!.value['password'],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
