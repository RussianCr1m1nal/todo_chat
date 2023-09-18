import 'package:flutter/material.dart';
import 'package:todo_chat/common/theme/app_colors.dart';
import 'package:todo_chat/domain/entity/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: todo.completed ? AppColors.green : Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              todo.title,
              style: Theme.of(context).textTheme.displayMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Divider(
            height: 1,
            color: AppColors.black.withOpacity(0.15),
          ),
        ],
      ),
    );
  }
}
