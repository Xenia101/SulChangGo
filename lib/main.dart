import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sulchanggo/home/home.dart';
import 'package:sulchanggo/login/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  const supabaseUrl = 'https://dhrjcsnhoqgyhxkftgtp.supabase.co';

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: "",
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
    realtimeClientOptions: const RealtimeClientOptions(
      logLevel: RealtimeLogLevel.info,
    ),
    storageOptions: const StorageClientOptions(
      retryAttempts: 10,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SupabaseClient>(
          create: (_) => Supabase.instance.client,
        ),
      ],
      child: ShadApp.cupertino(
        darkTheme: ShadThemeData(
          brightness: Brightness.dark,
          colorScheme: const ShadSlateColorScheme.dark(
            background: Colors.blue,
          ),
        ),
        cupertinoThemeBuilder: (context, theme) {
          return theme.copyWith(applyThemeToAll: true);
        },
        materialThemeBuilder: (context, theme) {
          return theme.copyWith(
            appBarTheme: const AppBarTheme(toolbarHeight: 52),
          );
        },
        home: FutureBuilder<User?>(
          future: Future.value(Supabase.instance.client.auth.currentUser),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                if (snapshot.data != null) {
                  return const HomePage();
                } else {
                  return const LoginPage();
                }
              }
            }
          },
        ),
      ),
    );
  }
}
