import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/userModel.dart'; 
import '../providers/perfilProvider.dart'; 
import 'package:provider/provider.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({Key? key, required this.user, Row? child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final perfilProvider = Provider.of<PerfilProvider>(context, listen: false);
    void toChat(username) {
      perfilProvider.setUsernameChat(username);
      Get.offNamed('/chat');
    }
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(user.mail),
          const SizedBox(height: 8),
          Text(user.comment),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => toChat(user.username),
                icon: Icon(Icons.chat_bubble_outline),
                tooltip: 'Abrir chat', // Mensaje emergente al pasar el cursor
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

}