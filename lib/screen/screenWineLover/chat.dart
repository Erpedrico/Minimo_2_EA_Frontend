import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../models/userModel.dart'; 
import '../../providers/perfilProvider.dart'; 
import 'package:provider/provider.dart'; 

class chatPage extends StatefulWidget {
  @override
  _chatPageState createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  late IO.Socket socket;
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = []; // Lista para almacenar los mensajes

  @override
  void initState() {
    super.initState();

    // Conectarse al servidor WebSocket
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // Manejo de eventos
    socket.on('connect', (_) {
      print('Connected to server');
    });

    UserModel? currentUser = Provider.of<PerfilProvider>(context, listen: false).getUser();
    String? objectiveUser = Provider.of<PerfilProvider>(context, listen: false).getUsernameChat();
    List<String?> nombres = [currentUser?.username, objectiveUser];
    nombres.sort();
    String roomName = "${nombres[0]}_${nombres[1]}";
    socket.emit('joinRoom',roomName);

    socket.on('previousMessages', (data) {
      setState(() {
      for (var item in data) {
        _messages.add(item['content'].toString());
      }
      });
    });

    socket.on('message-receive', (data) {
      setState(() {
        _messages.add(data); // Agregar el mensaje recibido a la lista
      });
    });

    socket.connect(); // Conectar el socket
  }

  @override
  void dispose() {
    socket.disconnect();
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    UserModel? currentUser = Provider.of<PerfilProvider>(context, listen: false).getUser();
    String? objectiveUser = Provider.of<PerfilProvider>(context, listen: false).getUsernameChat();
    String? myname = currentUser?.username;
    List<String?> nombres = [currentUser?.username, objectiveUser];
    nombres.sort();
    String roomName = "${nombres[0]}_${nombres[1]}";
    print(roomName);

    final message = _messageController.text.trim();
    final messageUser = "$myname:$message"; 
    if (message.isNotEmpty) {
      socket.emit('sendMessage', {'roomName': roomName, 'message': messageUser});
      setState(() {
        _messages.add("You: $message"); // Agregar el mensaje enviado a la lista
      });
      _messageController.clear(); // Limpiar el campo de texto
    }
  }

  void goBack() {
    Get.offNamed('/main');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: goBack
      ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter a message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

