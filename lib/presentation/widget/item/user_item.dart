import 'package:flutter/material.dart';
import 'package:todo_chat/common/theme/app_colors.dart';
import 'package:todo_chat/domain/entity/user.dart';

class UserItem extends StatelessWidget {
  final User user;
  final bool selected;

  const UserItem({
    super.key,
    required this.user,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? AppColors.blue : Colors.transparent,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              const SizedBox(
                width: 16.0,
              ),
              Container(
                height: 54,
                width: 54,
                decoration: const BoxDecoration(
                  color: AppColors.black,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    user.initials,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white),
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.grey),
                  ),
                ],
              ),
            ],
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
