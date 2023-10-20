
    import 'package:hive/hive.dart';

part 'model.g.dart';
@HiveType(typeId: 1)
class StudentModel{
    @HiveField(0)
  final DateTime id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int age;
  @HiveField(3)
  final String mail;
  @HiveField(4)
  final int contact;
    @HiveField(5)
  final String profile;
 

 StudentModel(
 {
required this.id, 
required this.name,
required this.age,
required this.contact,
required this.mail,
required this.profile, 
 });


  
}           