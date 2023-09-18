import 'package:flutter/material.dart';
import 'package:todo_chat/domain/entity/user.dart';
import 'package:todo_chat/presentation/widget/item/user_item.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = "/chat";

  const ChatScreen({
    super.key,
    required this.users,
  });

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        leadingWidth: 24,
      ),
      body: CustomScrollView(
        slivers: [
          ...users.map((user) {
            return SliverToBoxAdapter(
              child: UserItem(
                user: user,
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
