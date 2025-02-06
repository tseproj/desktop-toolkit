import 'package:desktop_toolkit/app.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  Size size = const Size(1200, 600);
  WindowOptions windowOptions = WindowOptions(
    title: "Desktop Toolkit",
    size: size,
    minimumSize: const Size(1000, 300),
    center: true,
    skipTaskbar: false,
    windowButtonVisibility: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const App());
}
