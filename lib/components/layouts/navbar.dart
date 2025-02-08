import 'package:fluent_ui/fluent_ui.dart';
import 'package:window_manager/window_manager.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as fi;

import 'package:desktop_toolkit/pages/plugin_manager.dart';

class NavigationSidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const NavigationSidebar({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  Widget _title(BuildContext context) {
    return const DragToMoveArea(
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text("Desktop Toolkit", style: TextStyle(fontSize: 14))));
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        leading: null,
        automaticallyImplyLeading: false,
        title: _title(context),
        actions: WindowActions(),
      ),
      pane: NavigationPane(
        selected: selectedIndex,
        onChanged: onChanged,
        displayMode: PaneDisplayMode.compact,
        items: [
          PaneItem(
            icon: const Icon(fi.FluentIcons.puzzle_piece_32_regular),
            title: const Text('QQNT Plugin Manager'),
            body: const QQNTPluginManagerPage(),
          ),
        ],
      ),
    );
  }
}

class WindowActions extends StatelessWidget {
  const WindowActions({super.key});

  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      SizedBox(
        width: 138,
        height: 50,
        child: WindowCaption(
          brightness: theme.brightness,
          backgroundColor: Colors.transparent,
        ),
      ),
    ]);
  }
}
