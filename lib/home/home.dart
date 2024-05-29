import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sulchanggo/login/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> data = [];
  File? _image;

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

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ShadInput(
          placeholder: Text('Search'),
          suffix: Padding(
            padding: EdgeInsets.all(4.0),
            child: ShadImage.square(size: 18, LucideIcons.search),
          ),
        ),
      ),
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
                        final DateTime createdAt =
                            DateTime.parse(item['created_at']);
                        final String formattedDate =
                            DateFormat('yyyy-MM-dd HH:mm:ss').format(createdAt);
                        final bool isWithinOneMonth =
                            DateTime.now().difference(createdAt).inDays <= 30;
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                            top: 4.0,
                            bottom: 4.0,
                          ),
                          child: ShadCard(
                            content: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          if (isWithinOneMonth)
                                            const ShadBadge.destructive(
                                              text: Text('New'),
                                            ),
                                          const SizedBox(width: 8),
                                          Text(
                                            item['name'].toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "용량: ${item['ml'].toString()}ml",
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "도수: ${item['alcohol'].toString()}%",
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    'https://picsum.photos/100',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            footer: Text(
                              formattedDate,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const Text('No data available'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showShadDialog(
            context: context,
            builder: (context) => ShadDialog.alert(
              title: const Text('Update SulChangGo'),
              description: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  children: [
                    const ShadInput(
                      placeholder: Text('Name'),
                    ),
                    const SizedBox(height: 8),
                    const ShadInput(
                      placeholder: Text('Volume (ml)'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 8),
                    const ShadInput(
                      placeholder: Text('Alcohol (%)'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 8),
                    if (_image != null)
                      Image.file(
                        _image!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: ShadButton.outline(
                              text: const Text('Add Image'),
                              onPressed: () => _showPicker(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                ShadButton(text: const Text('Add'), onPressed: () {}),
              ],
            ),
          );
        },
      ),
    );
  }
}
