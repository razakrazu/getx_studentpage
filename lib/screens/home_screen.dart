import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_studentpage/db/db.dart';
import 'add_student.dart';
import 'package:getx_studentpage/screens/student_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentDB = Get.put(Student());
    studentDB.getAllStudent();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HOME SCREEN',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 3, 3, 3),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddStudents(
            isEdit: false,
            index: 0,
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(
        () {
          return ListView.builder(
            itemCount: studentDB.students.length,
            itemBuilder: (context, index) {
              final student = studentDB.students[index];
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                child: SizedBox(
                  height: 70,
                  child: Card(
                    elevation: 10,
                    child: ListTile(
                      onTap: () {
                        Get.to(STUDENTSDETAILS(
                          index: index,
                        ));
                      },
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(student.profile)),
                        radius: 30,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            student.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () => alertDialog(index, studentDB),
                              icon: const Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

void alertDialog(int index, Student studentDB) {
  Get.defaultDialog(
    title: 'Delete Student',
    middleText: 'you want to delete ',
    textConfirm: 'Delete',
    textCancel: 'Cancel',
    onConfirm: () {
      Student().deleteStudents(index);
      studentDB.getAllStudent();
      Get.back();
    },
    onCancel: () {
      Get.back();
    },
  );
}
