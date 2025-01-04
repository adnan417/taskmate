import 'package:flutter/material.dart';
import 'package:taskmate/utils/cache_manager.dart';
import 'package:taskmate/widgets/custom_widgets.dart';

//Used stateful widget

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> completedTasks = [];
  List<String> incompletedTasks = [];

  final TextEditingController _taskController = TextEditingController();

  final GlobalKey<AnimatedListState> incompletedListKey =
      GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> completedListKey =
      GlobalKey<AnimatedListState>();

  bool isShowCompletedTasks = true;

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  Future<void> updateSharedPreferences() async {
    await SharedPrefs.setStringList('completedTasks', completedTasks);
    await SharedPrefs.setStringList('incompletedTasks', incompletedTasks);
  }

  Future<void> getTasks() async {
    await SharedPrefs.init();
    completedTasks = await SharedPrefs.getStringList('completedTasks') ?? [];
    incompletedTasks =
        await SharedPrefs.getStringList('incompletedTasks') ?? [];

    initializeCompletedTasks();
    initializeIncompletedTasks();
    setState(() {});
  }

  void initializeIncompletedTasks() {
    for (int i = 0; i < incompletedTasks.length; i++) {
      incompletedListKey.currentState?.insertItem(i);
    }
  }

  void initializeCompletedTasks() {
    for (int i = 0; i < completedTasks.length; i++) {
      completedListKey.currentState?.insertItem(i);
    }
  }

  void addTask() {
    if (_taskController.text.isNotEmpty) {
      incompletedListKey.currentState!.insertItem(0);
      incompletedTasks.add(_taskController.text.trim());

      updateSharedPreferences();
      _taskController.clear();
      Navigator.pop(context);
    }
  }

  void markAsCompleted(int index) {
    String task = incompletedTasks.removeAt(index);
    setState(() {
      incompletedListKey.currentState!.removeItem(
        index,
        (context, animation) => widgetListItem(task, false, index, animation),
      );
      completedTasks.insert(0, task);
      completedListKey.currentState!.insertItem(0);
    });

    updateSharedPreferences();
  }

  void markAsIncomplete(int index) {
    String task = completedTasks.removeAt(index);

    setState(() {
      completedListKey.currentState!.removeItem(
        index,
        (context, animation) => widgetListItem(task, true, index, animation),
      );
      incompletedTasks.insert(0, task);

      incompletedListKey.currentState!.insertItem(0);
    });
    updateSharedPreferences();
  }

  void deleteTask(int index, bool isCompleted) {
    setState(() {
      if (isCompleted) {
        completedListKey.currentState!.removeItem(
          index,
          (context, animation) => widgetListItem("", true, index, animation),
        );

        completedTasks.removeAt(index);
      } else {
        incompletedListKey.currentState!.removeItem(
          index,
          (context, animation) => widgetListItem("", false, index, animation),
        );

        incompletedTasks.removeAt(index);
      }
    });

    updateSharedPreferences();
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => widgetTaskBottomSheet(),
    );
  }

  void showDeleteTaskBottomSheet(
      BuildContext context, int index, bool isCompleted) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      builder: (context) {
        return widgetDeleteTaskBottomSheet(index, isCompleted);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TaskMate'),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/posts');
            },
            child: Icon(
              size: 32,
              Icons.keyboard_arrow_right_rounded,
            ),
          )
        ],
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          showBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
      body: widgetBody(),
    );
  }

  Widget widgetBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: AnimatedList.separated(
              key: incompletedListKey,
              initialItemCount: incompletedTasks.length,
              itemBuilder: (context, index, animation) => widgetListItem(
                  incompletedTasks[index], false, index, animation),
              separatorBuilder: (context, index, animation) =>
                  SizedBox(height: 12),
              removedSeparatorBuilder: (context, index, animation) =>
                  SizedBox(height: 12),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
          if (completedTasks.isNotEmpty)
            TextButton.icon(
              onPressed: () {
                setState(() {
                  isShowCompletedTasks = !isShowCompletedTasks;
                });
              },
              icon: Icon(isShowCompletedTasks
                  ? Icons.keyboard_arrow_down_rounded
                  : Icons.keyboard_arrow_up_rounded),
              label: Text('Completed'),
            ),
          if (isShowCompletedTasks)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: AnimatedList.separated(
                key: completedListKey,
                initialItemCount: completedTasks.length,
                itemBuilder: (context, index, animation) => widgetListItem(
                    completedTasks[index], true, index, animation),
                separatorBuilder: (context, index, animation) =>
                    SizedBox(height: 12),
                removedSeparatorBuilder: (context, index, animation) =>
                    SizedBox(height: 12),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),
        ],
      ),
    );
  }

  Widget widgetListItem(String content, bool isCompleted, int index,
      Animation<double> animation) {
    return GestureDetector(
      onLongPress: () {
        showDeleteTaskBottomSheet(context, index, isCompleted);
      },
      child: SizeTransition(
        sizeFactor: animation,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            title: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              style: isCompleted
                  ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      )
                  : Theme.of(context).textTheme.bodyMedium!,
              child: Text(content),
            ),
            leading: CustomCheckbox(
                value: isCompleted,
                onChanged: (value) {
                  if (isCompleted) {
                    markAsIncomplete(index);
                  } else {
                    markAsCompleted(index);
                  }
                }),
          ),
        ),
      ),
    );
  }

  Widget widgetTaskBottomSheet() {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomCheckbox(value: false, onChanged: (value) {}),
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your task',
                      hintStyle: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.5),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: CustomTextButton(text: "Done", onPressed: addTask),
            ),
          ],
        ),
      ),
    );
  }

  Widget widgetDeleteTaskBottomSheet(int index, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Delete completed tasks',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8.0),
          Text(
            'Delete 1 task?',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  text: "Cancel",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: CustomElevatedButton(
                  text: "Delete",
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                  onPressed: () {
                    deleteTask(index, isCompleted);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
