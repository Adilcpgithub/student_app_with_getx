class StudentModel {
  String name;
  String age;
  String studentClass;
  String gender;
  String? imagePath;
  StudentModel(
      {required this.name,
      required this.age,
      required this.studentClass,
      required this.gender,
      this.imagePath});
}
