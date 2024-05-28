// home page

import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('SulChangGo'),
      ),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('Welcome to SulChangGo!', style: TextStyle(fontSize: 24)),
            SizedBox(height: 16),
            Text('This is the home page.', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
