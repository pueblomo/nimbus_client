import 'package:nimbus_client/src/SharedKeys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watcher/watcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketService {
  late WebSocketChannel channel;

  WebsocketService() {
    initChannel();
  }

  void initChannel() async {
    final prefs = await SharedPreferences.getInstance();
    var url = prefs.getString(SharedKeys.serverUrl.name);

    channel = WebSocketChannel.connect(Uri.parse('ws://$url'));
  }

  void handleFileEvent(WatchEvent event) {
    switch (event.type) {
      case ChangeType.ADD:
    }
  }
}
