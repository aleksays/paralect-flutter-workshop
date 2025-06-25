import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/injection/injection_container.dart' as di;
import 'features/posts/presentation/providers/posts_provider.dart';
import 'features/posts/presentation/pages/posts_provider_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => di.sl<PostsProvider>(),
      child: MaterialApp(
        title: 'Flutter Workshop - Clean Architecture + Provider',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: const PostsProviderPage(),
      ),
    );
  }
}
