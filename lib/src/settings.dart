import 'package:flutter/material.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsWidget> {
  final clientNameController = TextEditingController();
  final rootFolderController = TextEditingController();
  final serverUrlController = TextEditingController();
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    fToast = FToast();
    fToast.init(context);
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    //ToDo sharedpreferences keys as enum
    clientNameController.text = prefs.getString('client-name') ?? '';
    rootFolderController.text = prefs.getString('root-folder') ?? '';
    serverUrlController.text = prefs.getString('server-url') ?? '';
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('client-name', clientNameController.text);
    prefs.setString('root-folder', rootFolderController.text);
    prefs.setString('server-url', serverUrlController.text);
  }

  @override
  void dispose() {
    clientNameController.dispose();
    rootFolderController.dispose();
    serverUrlController.dispose();
    super.dispose();
  }

  //ToDo convert to own dart file with widget
  Widget createToast(String message) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check),
          const SizedBox(
            width: 12.0,
          ),
          Text(message),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: clientNameController,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Client name'),
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: rootFolderController,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Root folder'),
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: serverUrlController,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Server url'),
            ),
          ),
        ),
        SizedBox(
          width: 110,
          child: ElevatedButton(
            onPressed: () {
              _saveSettings();
              fToast.showToast(
                  child: createToast('Successfully saved'),
                  gravity: ToastGravity.BOTTOM_RIGHT,
                  toastDuration: const Duration(seconds: 2));
            },
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                children: const [Icon(Octicons.saved), Text('Save')],
              ),
            ),
          ),
        )
      ],
    );
  }
}
