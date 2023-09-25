
// ignore_for_file: library_private_types_in_public_api

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';

import 'Add_Latest_project.dart';
import 'project_list.dart';
import 'add_Project_controller.dart';




class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProjectListScreenState createState() =>
      _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  late Route routes;
  bool isApiCallProcessing = false;
  bool isDeleteProcessing = false;
  final getLatestProject = Get.find<AddProjectController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLatestProject.getProjectData();

  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (p0, p1){
          return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                title: const Text("Edit Project", style: TextStyle(fontSize: 20,color: Colors.black),),
                leading: IconButton(
                  onPressed: () => {Navigator.of(context).pop()},
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                ),
                elevation: 0.3,
                actions: [

                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>  const AddProjectsScreen())).whenComplete(() {    getLatestProject.getProjectData();});
                    },
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: AppColors.greyColor.withOpacity(0.5),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          children: const [
                            Icon(Icons.add),
                            SizedBox(width: 3),
                            Text("Add New App",style: TextStyle(color: AppColors.blackColor),)
                          ],
                        ),
                      ),
                    ),
                  ),

                ]

            ),
            backgroundColor: Colors.grey[200],
            body:  Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(top: 5),
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
              child: Obx(() {
                return getLatestProject.getProjectList.isEmpty?
                    const Center(child: Text("No Data")):
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: getLatestProject.getProjectList.length,
                  itemBuilder: (context, index) {
                    return ProjectList(
                      data:getLatestProject.getProjectList[index],
                      index: index,
                    );
                  },
                );
              },
              ),
            ),
          );
        }
    );
  }


}

