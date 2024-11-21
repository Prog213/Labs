import 'package:flutter/material.dart';

class ProfileInfoRow extends StatelessWidget {
  final String title;
  final String content;
  final Function(String) onEdit; // Додано функцію для редагування
  final bool isEditing; // Додано параметр для редагування

  const ProfileInfoRow({
    required this.title,
    required this.content,
    required this.onEdit,
    this.isEditing = false, // Значення за замовчуванням
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: isEditing
              ? TextField(
                  onSubmitted: onEdit,
                  decoration: InputDecoration(
                    hintText: content,
                    border: const OutlineInputBorder(),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        final TextEditingController controller = TextEditingController(text: content);
                        return AlertDialog(
                          title: Text('Edit $title'),
                          content: TextField(
                            controller: controller,
                            decoration: const InputDecoration(hintText: 'Enter new value'),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                onEdit(controller.text);
                                Navigator.of(context).pop();
                              },
                              child: const Text('Save'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          content,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue), // Іконка редагування
                      onPressed: () {
                        // Запускаємо редагування при натисканні на іконку
                        showDialog(
                          context: context,
                          builder: (context) {
                            final TextEditingController controller = TextEditingController(text: content);
                            return AlertDialog(
                              title: Text('Edit $title'),
                              content: TextField(
                                controller: controller,
                                decoration: const InputDecoration(hintText: 'Enter new value'),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // Закриваємо діалог і передаємо нове значення
                                    onEdit(controller.text);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Save'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
