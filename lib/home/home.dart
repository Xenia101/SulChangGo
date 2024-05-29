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
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final supabase = Provider.of<SupabaseClient>(context, listen: false);
      final res =
          await supabase.from('SulChangGo').select().count(CountOption.exact);

      if (res.count > 0) {
        setState(() {
          data = res.data as List<dynamic>;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
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
            data.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final item = data[index];
                        return ListTile(
                          leading: Image.network(
                            'https://picsum.photos/200',
                            fit: BoxFit.cover,
                          ),
                          title: Text(item['name'].toString()),
                          subtitle: Text(item['ml'].toString()),
                        );
                      },
                    ),
                  )
                : const Text('No data available'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
