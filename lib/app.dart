import 'package:desktop_toolkit/components/layout/navbar.dart';
import 'package:fluent_ui/fluent_ui.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Desktop Toolkit',
      theme: FluentThemeData(
        brightness: Brightness.light,
        accentColor: Colors.teal,
      ),
      home: NavigationSidebar(
        selectedIndex: 0,
        onChanged: (index) {},
      ),
    );
  }
}
