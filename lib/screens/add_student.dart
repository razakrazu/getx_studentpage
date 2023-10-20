import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_studentpage/core/color.dart';
import 'package:getx_studentpage/db/data_delails/data_details.dart';
import 'package:getx_studentpage/db/data_delails/image_function.dart';

ImageFunction imageController = Get.put(ImageFunction());
StudentDatas studentFormController = Get.put(StudentDatas());

class AddStudents extends StatelessWidget {
  const AddStudents({
    super.key,
    required this.isEdit,
    required this.index,
  });
  final bool isEdit;
  final int index;

  @override
  Widget build(BuildContext context) {
    isEdit
        ? studentFormController.isUpdate(index)
        : studentFormController.reset();
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
          'ADD STUDENT',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 3, 3, 3),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Form(
            key: studentFormController.formKey,
            child: ListView(
              children: [
                Stack(
                  children: [
                    GestureDetector(
                        onTap: () => imageController.getImage(),
                        child: imageController.imgPath.value == ''
                            ? ClipOval(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 120,
                                  ),
                                  child: Container(
                                    width: 140,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            imageController.assetAvatar.value),
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : ClipOval(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 120,
                                  ),
                                  child: Container(
                                    width: 140,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: FileImage(File(
                                            imageController.imgPath.value)),
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                    const SizedBox(
                      child: Padding(
                        padding: EdgeInsets.only(top: 150, left: 180),
                        child: Icon(
                          Icons.add_a_photo,
                          color: Color.fromARGB(255, 156, 149, 149),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                  child: TextFormField(
                    controller: studentFormController.nameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: colorblack,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      hintText: 'Name',
                    ),
                    validator: (value) =>
                        studentFormController.nameController.text.isEmpty
                            ? 'Name field is empty'
                            : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: TextFormField(
                    controller: studentFormController.mailController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: colorblack,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      hintText: 'Email',
                    ),
                    validator: (value) =>
                        studentFormController.mailController.text.isEmpty
                            ? 'Email field is empty'
                            : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: TextFormField(
                    controller: studentFormController.ageController,
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: colorblack,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      hintText: 'Age',
                    ),
                    validator: (value) =>
                        studentFormController.ageController.text.isEmpty
                            ? 'Age field is empty'
                            : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: TextFormField(
                    controller: studentFormController.contectController,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: colorblack,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      hintText: 'Number',
                    ),
                    validator: (value) =>
                        studentFormController.contectController.text.isEmpty
                            ? 'Contact field is empty'
                            : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 100, right: 90, top: 20),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (studentFormController.formKey.currentState!
                            .validate()) {
                          if (imageController.imgPath.value != '') {
                            if (isEdit) {
                              await studentFormController.updateData(index);
                            } else {
                              await studentFormController.submitData();
                            }
                            Get.snackbar(
                              'Success',
                              isEdit
                                  ? 'Data Updated Successfully'
                                  : 'Data Submitted Successfully',
                              backgroundColor: Colors.green.withOpacity(0.5),
                            );
                          } else {
                            studentFormController.notSuccess();
                            Get.snackbar(
                              'Error',
                              'Image path is empty',
                              backgroundColor: Colors.red.withOpacity(0.5),
                            );
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 7, 7, 7), // Background Color
                      ),
                      child: Text(isEdit ? 'Update' : 'ADD',
                          style: const TextStyle(
                              fontSize: 15, color: colorwhite))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
