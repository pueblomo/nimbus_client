import 'package:flutter/material.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nimbus_client/src/SharedKeys.dart';
import 'package:nimbus_client/src/widgets/toast.dart';
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
    clientNameController.text =
        prefs.getString(SharedKeys.clientName.name) ?? '';
    rootFolderController.text =
        prefs.getString(SharedKeys.rootFolder.name) ?? '';
    serverUrlController.text = prefs.getString(SharedKeys.serverUrl.name) ?? '';
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedKeys.clientName.name, clientNameController.text);
    prefs.setString(SharedKeys.rootFolder.name, rootFolderController.text);
    prefs.setString(SharedKeys.serverUrl.name, serverUrlController.text);
  }

  @override
  void dispose() {
    clientNameController.dispose();
    rootFolderController.dispose();
    serverUrlController.dispose();
    super.dispose();
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
                  child: const ToastWidget(
                    message: 'Successfully saved',
                    isSuccess: true,
                  ),
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
