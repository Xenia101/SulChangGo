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
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRocmpjc25ob3FneWh4a2Z0Z3RwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY4NTE5OTMsImV4cCI6MjAzMjQyNzk5M30.lDjJXAzA9p2k2fZ5EEP_f1tj5PgGhGnVDn16_8neiDg",
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
                // return snapshot.data != null
                //     ? const HomePage()
                //     : const LoginPage();
                return const HomePage();
              }
            }
          },
        ),
      ),
    );
  }
}
