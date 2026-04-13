import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_providers.dart';
import '../../domain/entities/task.dart';
import 'task_list_screen.dart';

class TaskDetailScreen extends ConsumerStatefulWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  ConsumerState<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends ConsumerState<TaskDetailScreen> {
  late Task _currentTask;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _currentTask = widget.task;
    _titleController.text = _currentTask.title;
    _descriptionController.text = _currentTask.description;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _updateTask() async {
    if (!_isEditing) return;

    final updatedTask = _currentTask.copyWith(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
    );

    await ref.read(taskStateProvider.notifier).updateTask(updatedTask);
    
    setState(() {
      _isEditing = false;
    });
  }

  Future<void> _toggleCompletion() async {
    final updatedTask = _currentTask.copyWith(
      isCompleted: !_currentTask.isCompleted,
    );
    setState(() {
      _currentTask = updatedTask;
    });

    await ref.read(taskStateProvider.notifier).updateTask(updatedTask);
  }

  Future<void> _deleteTask() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete task?'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (!mounted) return;

    if (shouldDelete != true) return;

    await ref.read(taskStateProvider.notifier).deleteTask(_currentTask.id);
    if (!mounted) return;

    final error = ref.read(taskStateProvider).error;
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
      return;
    }

   Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<TaskState>(taskStateProvider, (previous, next) {
      if (!mounted) return;

      final updatedTask = next.tasks.cast<Task?>().firstWhere(
            (t) => t?.id == _currentTask.id,
            orElse: () => null,
          );

      if (updatedTask == null) return;
      if (updatedTask == _currentTask) return;

      setState(() {
        _currentTask = updatedTask;
        if (!_isEditing) {
          _titleController.text = _currentTask.title;
          _descriptionController.text = _currentTask.description;
        }
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Task' : 'Task Details'),
        actions: [
          if (_isEditing)
            TextButton(
              onPressed: _updateTask,
              child: const Text('Save'),
            )
          else
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _isEditing
                      ? TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a task title';
                            }
                            return null;
                          },
                        )
                      : Text(
                          _currentTask.title,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            decoration: _currentTask.isCompleted 
                                ? TextDecoration.lineThrough 
                                : null,
                          ),
                        ),
                ),
                const SizedBox(width: 12),
                Switch(
                  value: _currentTask.isCompleted,
                  onChanged: (value) => _toggleCompletion(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _isEditing
                ? TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                  )
                : Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _currentTask.description.isNotEmpty
                        ? Text(_currentTask.description)
                        : Text(
                            'No description',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                  ),
            const SizedBox(height: 24),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
                const SizedBox(width: 8),
                Text(
                  'Created: ${_formatDate(_currentTask.createdAt)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            if (_currentTask.updatedAt != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.update,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Updated: ${_formatDate(_currentTask.updatedAt!)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
            const Spacer(),
            if (!_isEditing)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _deleteTask,
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete Task'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
