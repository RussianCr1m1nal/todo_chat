import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_chat/common/theme/app_colors.dart';
import 'package:todo_chat/di/di.dart';
import 'package:todo_chat/domain/entity/todo.dart';
import 'package:todo_chat/domain/entity/user.dart';
import 'package:todo_chat/presentation/bloc/home_screen_bloc.dart';
import 'package:todo_chat/presentation/screen/chat_screen.dart';
import 'package:todo_chat/presentation/widget/item/todo_item.dart';
import 'package:todo_chat/presentation/widget/item/user_item.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<HomeScreenBloc>(
      create: (context) => getIt<HomeScreenBloc>(),
      child: Consumer<HomeScreenBloc>(
        builder: (context, bloc, child) {
          final List<Widget> pages = [
            _UserList(bloc: bloc),
            _TodoList(bloc: bloc),
          ];

          return StreamBuilder<int>(
            stream: bloc.currentPageStream,
            builder: (context, snapshot) {
              final int currentPage = snapshot.data ?? 0;

              return Scaffold(
                appBar: AppBar(
                  title: const Text('Home'),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          context.push(ChatScreen.routeName, extra: bloc.selectedUsers);
                        },
                        child: const Icon(Icons.chat),
                      ),
                    )
                  ],
                ),
                body: pages[currentPage],
                bottomNavigationBar: BottomNavigationBar(
                  onTap: bloc.setCurrentPage,
                  currentIndex: currentPage,
                  backgroundColor: AppColors.black,
                  selectedItemColor: AppColors.blue,
                  unselectedItemColor: AppColors.white,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: "Users",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.check_box),
                      label: "Todos",
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _UserList extends StatelessWidget {
  final HomeScreenBloc bloc;

  const _UserList({
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: bloc.syncUserStatusStream,
      builder: (context, snapshot) {
        final bool syncing = snapshot.data ?? true;

        if (syncing) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return StreamBuilder<List<User>>(
          stream: bloc.userListStream,
          builder: (context, snapshot) {
            final List<User> users = snapshot.data ?? [];

            return StreamBuilder<List<User>>(
              stream: bloc.selectedUserListStream,
              builder: (context, snapshot) {
                return CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return GestureDetector(
                            onTap: () {
                              bloc.toggleUserSelect(users[index]);
                            },
                            child: UserItem(
                              user: users[index],
                              selected: bloc.isUserSelected(users[index]),
                            ),
                          );
                        },
                        childCount: users.length,
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}

class _TodoList extends StatelessWidget {
  final HomeScreenBloc bloc;

  const _TodoList({
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: bloc.syncTodosStatusStream,
      builder: (context, snapshot) {
        final bool syncing = snapshot.data ?? true;

        if (syncing) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return StreamBuilder<List<Todo>>(
          stream: bloc.todosListStream,
          builder: (context, snapshot) {
            final List<Todo> todos = snapshot.data ?? [];

            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => TodoItem(todo: todos[index]),
                    childCount: todos.length,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
