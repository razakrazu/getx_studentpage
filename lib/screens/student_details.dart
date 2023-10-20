import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_studentpage/core/color.dart';
import 'package:getx_studentpage/core/condent.dart';
import 'package:getx_studentpage/db/db.dart';
import 'package:getx_studentpage/screens/add_student.dart';

class STUDENTSDETAILS extends StatelessWidget {
  const STUDENTSDETAILS({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final studentDB = Get.put(Student());
    studentDB.getAllStudent();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: colorwhite,
              size: 30,
            )),
        title: const Text(
          'STUDENT DETAILS ',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, bottom: 90, top: 30),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 145, 139, 139),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                  border: Border.all(width: 0),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Center(
                      child: CircleAvatar(
                    backgroundImage:
                        FileImage(File(studentDB.students[index].profile)),
                    radius: 90,
                  )),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'NAME :${studentDB.students[index].name.toLowerCase()}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'AGE :  ${studentDB.students[index].age.toString()}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'CONTACT :${studentDB.students[index].contact.toString()}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'EMAIL:  ${studentDB.students[index].mail.toLowerCase()}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Kheight10,
                  ElevatedButton(
                      onPressed: () => Get.to(AddStudents(
                            isEdit: true,
                            index: index,
                          )),
                      child: const Text('Edit')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
