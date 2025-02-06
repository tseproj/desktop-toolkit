import 'package:desktop_toolkit/pages/plugin_manager.dart';
import 'package:fluent_ui/fluent_ui.dart';

void main() {
  runApp(const DesktopToolkitApp());
}

class DesktopToolkitApp extends StatelessWidget {
  const DesktopToolkitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Li\'s Desktop Toolkit',
      theme: FluentThemeData(
        brightness: Brightness.light,
        accentColor: Colors.teal,
      ),
      home: const QQNTPluginManagerPage(),
    );
  }
}
