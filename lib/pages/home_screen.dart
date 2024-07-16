import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app_getx/controllers/checkSerch.dart';
import 'package:student_app_getx/controllers/search_controller.dart';
import 'package:student_app_getx/controllers/student_controller.dart';
import 'package:student_app_getx/models/student.dart';
import 'package:student_app_getx/pages/add_student.dart';
import 'package:student_app_getx/pages/views%20_studnet.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final SearchFieldController searchFieldController =
      Get.put(SearchFieldController());
  final StudentController studentController = Get.put(StudentController());
  final CheckSearchController checkSearchController =
      Get.put(CheckSearchController());
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                checkSearchController.isSearch.value =
                    !checkSearchController.isSearch.value;
                searchController.text = '';
              },
              icon: const Icon(Icons.search))
        ],
        backgroundColor: Color.fromARGB(123, 15, 131, 102),
        title: const Center(
          child: Text("Student Information"),
        ),
      ),
      body: Obx(() {
        return Column(
          children: [
            !checkSearchController.isSearch.value
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      onChanged: (value) {
                        studentController.searchStudents(searchController.text);
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'SEARCH HERE',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
            Expanded(
              child: studentController.students.length == 0
                  ? Center(
                      child: Text('Student list is empty'),
                    )
                  : ListView.builder(
                      itemCount: checkSearchController.isSearch.value
                          ? studentController.filteredStudents.length
                          : studentController.students.length,
                      itemBuilder: (context, index) {
                        final student = checkSearchController.isSearch.value
                            ? studentController.filteredStudents[index]
                            : studentController.students[index];
                        final studentKey =
                            studentController.getStudentKey(index);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Color.fromARGB(64, 129, 252, 172),
                            child: ListTile(
                              onTap: () {
                                print('object');

                                Get.to(StudetsDetails(
                                  student: studentController.students[index],
                                ));
                                print(studentKey);
                              },
                              title: Text(
                                student.name ?? '',
                              ),
                              subtitle: Text(
                                student.gender ?? '',
                              ),
                              leading: CircleAvatar(
                                backgroundImage: student.imagePath != null
                                    ? FileImage(
                                        File(student.imagePath!),
                                      ) as ImageProvider
                                    : AssetImage('assets/AddStudent.jpg'),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.teal,
                                    ),
                                  ),

                                  //  delete button---------------------------------------
                                  IconButton(
                                    onPressed: () {
                                      studentController
                                          .deleteStudentByKey(studentKey);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
            )
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //
          Get.to(AddDataScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
