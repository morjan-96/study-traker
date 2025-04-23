// ignore_for_file: use_build_context_synchronously, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:study_traker/SQLite%20Helper/database_helper.dart';
import 'package:study_traker/model/subject_model.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  List<Subject> _subjects = [];

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  Future<void> _loadSubjects() async {
    final subjects = await DatabaseHelper.instance.getAllSubjects();
    setState(() => _subjects = subjects);
  }

  void _showSubjectDialog({Subject? subject}) {
    final controller = TextEditingController(text: subject?.name ?? "");

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(subject == null ? "إضافة مادة" : "تعديل المادة"),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: "اسم المادة"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("إلغاء"),
              ),
              ElevatedButton(
                onPressed: () async {
                  final name = controller.text.trim();
                  if (name.isEmpty) return;

                  if (subject == null) {
                    await DatabaseHelper.instance.insertSubject(
                      Subject(name: name),
                    );
                  } else {
                    await DatabaseHelper.instance.updateSubject(
                      Subject(
                        id: subject.id,
                        name: name,
                        totalHours: subject.totalHours,
                      ),
                    );
                  }

                  Navigator.pop(context);
                  _loadSubjects();
                },
                child: const Text("حفظ"),
              ),
            ],
          ),
    );
  }

  Future<void> _deleteSubject(int id) async {
    await DatabaseHelper.instance.deleteSubject(id);
    _loadSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("المواد الدراسية")),
      body:
          _subjects.isEmpty
              ? const Center(child: Text("لا توجد مواد حتى الآن."))
              : ListView.builder(
                itemCount: _subjects.length,
                itemBuilder: (context, index) {
                  final subject = _subjects[index];
                  return Card(
                    child: ListTile(
                      title: Text(subject.name),
                      subtitle: Text(
                        "الوقت الإجمالي: ${subject.totalHours.toStringAsFixed(1)} ساعة",
                      ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == "edit") {
                            _showSubjectDialog(subject: subject);
                          } else if (value == "delete") {
                            _deleteSubject(subject.id!);
                          }
                        },
                        itemBuilder:
                            (_) => [
                              const PopupMenuItem(
                                value: "edit",
                                child: Text("تعديل"),
                              ),
                              const PopupMenuItem(
                                value: "delete",
                                child: Text("حذف"),
                              ),
                            ],
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showSubjectDialog(),
        child: const Icon(Icons.add),
        tooltip: "إضافة مادة",
      ),
    );
  }
}
