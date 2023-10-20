import 'package:get/get.dart';
import 'package:getx_studentpage/model/model.dart';
import 'package:hive/hive.dart';

class Student extends GetxController{
List<StudentModel>students=<StudentModel>[].obs;
Future<void>Addstudents(StudentModel value) async{
  final studentDB=await Hive.openBox<StudentModel>('student_db');
  students.add(value);
  await studentDB.add(value);

}
Future<void> getAllStudent() async{
  final studentDB= await Hive.openBox<StudentModel>('student_db');
 students.clear();
  students.addAll(studentDB.values);

}
Future<void>deleteStudents(int index) async{
  final studentDB = await Hive.openBox<StudentModel>('student_db');
 await studentDB.deleteAt(index);
  getAllStudent();

}
Future<void>Update(int index,StudentModel student) async{
  final studentDB = await Hive.openBox<StudentModel>('student_db');
 await studentDB.putAt(index,student);
getAllStudent();
}

 
}