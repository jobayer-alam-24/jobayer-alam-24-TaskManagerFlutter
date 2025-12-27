import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:task_manager/ui/controllers/add_new_task_controller.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/show_snackbar.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});
  static const String name = '/AddNewTaskScreen';
  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  String? _userName = '';
  String? _userEmail = '';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descTEController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final AddNewTaskController _addNewTaskController = Get.find<AddNewTaskController>();
  bool _shouldRefershPreviousPage = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result){
          if(didPop)
            {
              return;
            }

          Get.back(result: _shouldRefershPreviousPage);
        },
        child: Scaffold(
          appBar: TMAppBar(userName: _userName, userEmail: _userEmail,),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 42,),
                    Text("Add New Task", style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600
                    ),),
                    const SizedBox(height: 24,),
                    TextFormField(
                      controller: _titleTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          hintText: "Title"
                      ),
                      validator: (String? value){
                        if(value!.trim().isEmpty ?? true)
                          {
                              return 'Enter a value.';
                          }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8,),
                    TextFormField(
                      controller: _descTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: "Description",
                      ),
                      validator: (String? value){
                        if(value!.trim().isEmpty ?? true)
                        {
                          return 'Enter a value.';
                        }
                        return null;
                      },
                      maxLines: 5,
                    ),
                    const SizedBox(height: 16,),
                    GetBuilder<AddNewTaskController>(
                      builder: (controller) {
                        return Visibility(
                            visible: !controller.inProgress,
                            replacement: CenterCircularProgressIndicator(),
                            child: ElevatedButton(onPressed: _onTapSubmitButton, child: Icon(Icons.arrow_circle_right_outlined)));
                      }
                    )
                  ],
                ),
              ),
            ),
          )
        ),
      );
  }

  void _onTapSubmitButton()
  {
    if(_key.currentState!.validate())
      {
        _addNewTask();
      }
  }
  Future<void> _loadUserInfo() async {
    _userName = await AuthController.getFullName();
    _userEmail = await AuthController.getEmail();
    setState(() {});
  }

  Future<void> _addNewTask() async
  {
    final bool result = await _addNewTaskController.addNewTask(_titleTEController.text.trim(), _descTEController.text.trim());
    if(result)
      {
        _shouldRefershPreviousPage = true;
        _clearTextFields();
        ShowSnackBarMessege(context, "New Task Added!");
      }
    else
      {
        ShowSnackBarMessege(context, "Something went wrong!", true);
      }
  }
  void _clearTextFields()
  {
    _titleTEController.clear();
    _descTEController.clear();
  }
}