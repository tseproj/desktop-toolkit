import 'package:fluent_ui/fluent_ui.dart';
import 'package:desktop_toolkit/models/config.dart';
import 'package:desktop_toolkit/services/config.dart';

class QQNTPluginManagerPage extends StatefulWidget {
  const QQNTPluginManagerPage({super.key});

  @override
  State<QQNTPluginManagerPage> createState() => _QQNTPluginManagerPageState();
}

class _QQNTPluginManagerPageState extends State<QQNTPluginManagerPage> {
  Config? _config;
  String? _versionPath;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    final config = await ConfigService.loadConfig();
    final versionPath = config.qqPath != null
        ? await ConfigService.autoDetectQQVersionPath(config.qqPath!)
        : null;

    setState(() {
      _config = config;
      _versionPath = versionPath;
      _config?.versionPath = versionPath;
      _loading = false;
    });

    if (_config != null) {
      await ConfigService.saveConfig(_config!);
    }
  }

  Future<void> _pickDirectory(bool isQQPath) async {
    final path = await ConfigService.pickDirectory();
    if (path == null) return;

    if (isQQPath) {
      final versionPath = await ConfigService.autoDetectQQVersionPath(path);
      setState(() {
        _config?.qqPath = path;
        _versionPath = versionPath;
        _config?.versionPath = versionPath;
      });
    } else {
      setState(() {
        _config?.pluginPath = path;
      });
    }

    if (_config != null) {
      await ConfigService.saveConfig(_config!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: ProgressRing());
    }

    return NavigationView(
      appBar: const NavigationAppBar(
        title: Text('QQNT Plugin Manager'),
      ),
      content: ScaffoldPage(
        header: const PageHeader(
          title: Text('QQNT Plugin Manager'),
        ),
        content: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ToggleSwitch(
                checked: _config?.isEnabled ?? false,
                onChanged:
                    (_config?.qqPath != null && _config?.pluginPath != null)
                        ? (value) => _updatePluginState(value)
                        : null,
                content: const Text('Enable Plugin'),
              ),
              const SizedBox(height: 20),
              InfoLabel(
                label: 'QQNT Path',
                child: Row(
                  children: [
                    Expanded(
                      child: TextBox(
                        placeholder: 'Select QQNT installation path',
                        controller:
                            TextEditingController(text: _config?.qqPath ?? ''),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Button(
                      child: const Text('Choose'),
                      onPressed: () => _pickDirectory(true),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InfoLabel(
                label: 'Plugin Path',
                child: Row(
                  children: [
                    Expanded(
                      child: TextBox(
                        placeholder: 'Select plugin path',
                        controller: TextEditingController(
                            text: _config?.pluginPath ?? ''),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Button(
                      child: const Text('Choose'),
                      onPressed: () => _pickDirectory(false),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              if (_versionPath != null) ...[
                InfoLabel(
                  label: 'Detected Version Path',
                  child: Row(
                    children: [
                      Expanded(
                        child: TextBox(
                          controller:
                              TextEditingController(text: _versionPath!),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Button(
                        child: const Text('Choose'),
                        onPressed: () => _pickDirectory(false),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updatePluginState(bool value) async {
    if (_config == null ||
        _versionPath == null ||
        _config!.pluginPath == null) {
      return;
    }

    await ConfigService.updatePluginState(
        _versionPath!, value, _config!.pluginPath!);
    setState(() {
      _config!.isEnabled = value;
    });
    await ConfigService.saveConfig(_config!);
  }
}
