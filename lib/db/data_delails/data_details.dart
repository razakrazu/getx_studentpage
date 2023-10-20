import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_studentpage/db/db.dart';
import 'package:getx_studentpage/model/model.dart';
import 'package:getx_studentpage/screens/add_student.dart';

class StudentDatas extends GetxController {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final mailController = TextEditingController();
  final contectController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> isUpdate(int index) async {
    final studentDB = Get.put(Student());
    await studentDB.getAllStudent();
    imageController.imgPath.value = studentDB.students[index].profile;
    nameController.text = studentDB.students[index].name;
    mailController.text = studentDB.students[index].mail;
    ageController.text = studentDB.students[index].age.toString();
    contectController.text = studentDB.students[index].contact.toString();
  }

  void notSuccess() {
    Get.snackbar('Image not added!!', 'Please add a image of student');
  }

  Future<void> submitData() async {
    final studentObject = StudentModel(
      id: DateTime.now(),
      name: nameController.text.trim(),
      mail: mailController.text.trim(),
      age: int.parse(ageController.text.trim()),
      contact: int.parse(contectController.text.trim()),
      profile: imageController.imgPath.value,
    );

    await Student().Addstudents(studentObject);
    reset();
    final studentDB = Get.put(Student());
    studentDB.getAllStudent();
    Get.back();
  }

  Future<void> updateData(int index) async {
    final studentObject = StudentModel(
      id: DateTime.now(),
      name: nameController.text.trim(),
      mail: mailController.text.trim(),
      age: int.parse(ageController.text.trim()),
      contact: int.parse(contectController.text.trim()),
      profile: imageController.imgPath.value,
    );
    await Student().Update(index, studentObject);
    final studentDB = Get.put(Student());
    studentDB.getAllStudent();
    Get.back();
  }

  reset() {
    imageController.imgPath.value = '';
    nameController.text = '';
    mailController.text = '';
    ageController.text = '';
    contectController.text = '';
  }
}
