import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:student_app_getx/models/student.dart';

class StudentController extends GetxController {
  var students = <Student>[].obs;
  var filteredStudents = <Student>[].obs;
  @override
  void onInit() {
    loadStudents();

    super.onInit();
  }

  void loadStudents() {
    var box = Hive.box<Student>('students');
    students.value = box.values.toList();
  }

  dynamic getStudentKey(int index) {
    var box = Hive.box<Student>('students');
    return box.keyAt(index); // Return the key for the specific index
  }

  void addStudent(Student student) {
    var box = Hive.box<Student>('students');
    box.add(student);
    students.add(student);
  }

  void updateStudent(int index, Student student) {
    var box = Hive.box<Student>('students');
    box.putAt(index, student);
    students[index] = student;
  }

  void deleteStudentByKey(dynamic key) {
    var box = Hive.box<Student>('students');
    box.delete(key);
    loadStudents(); // Reload students to update the list
  }

  void searchStudents(String query) {
    if (query.isEmpty) {
      filteredStudents
          .assignAll(students); // Show all students if query is empty
    } else {
      var lowercaseQuery = query.toLowerCase();
      var result = students.where(
          (student) => student.name.toLowerCase().contains(lowercaseQuery));
      filteredStudents.assignAll(result.toList()); // Filter students by name
    }
  }
}
