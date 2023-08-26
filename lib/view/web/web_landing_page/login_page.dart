import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/app_colors.dart';
import 'package:grobiz_web_landing/config/constant.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/login_controller.dart';
import 'package:grobiz_web_landing/widget/common_button.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool _passwordVisible=true;
  LoginController loginController= Get.find<LoginController>();

  bool isEmailValid(String email) {
    if(email.isEmpty){
      return false;
    }
    else if(!emailValidatorRegExp.hasMatch(email)){
      return false;
    }
    return true;
  }

  bool isPasswordValid(String password) {
    if(password.isEmpty){
      return false;
    }
    return true;
  }

  bool checkValidations(){
    if(emailController.text.isEmpty){
      Fluttertoast.showToast(msg: "Please enter email id or mobile no.", backgroundColor: Colors.grey,);
      return false;
    }
    // else if(emailController.text.contains("@")) {
    //   if (!emailValidatorRegExp.hasMatch(emailController.text)) {
    //     Fluttertoast.showToast(
    //       msg: "Please enter valid email id", backgroundColor: Colors.grey,);
    //     return false;
    //   }
    // }
    else if(passwordController.text.isEmpty){
      Fluttertoast.showToast(msg: "Please enter password", backgroundColor: Colors.grey,);
      return false;
    }
    // else if(_passwordController.text.length<8){
    //   Fluttertoast.showToast(msg: "Password must be atleast 8 characters", backgroundColor: Colors.grey,);
    //   return false;
    // }
    return true;
  }

// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     html.window.onUnload.listen((event) async{
//       log("page refresh button pressed");
//       // do something
//     });
//   }
/*  html.EventListener? unloadListener;
  @override
  void initState() {
    super.initState();
    unloadListener = (html.Event event) async {
      // do something
      log("page refresh btn tapped");
    };
    html.window.addEventListener('beforeunload', unloadListener!);
  }

  @override
  void dispose() {
    super.dispose();
    html.window.removeEventListener('beforeunload', unloadListener!);
  }*/
  // @override
  // void dispose() {
  //   super.dispose();
  //   html.window.onBeforeUnload.cancel();
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
      return Scaffold(
        backgroundColor: AppColors.bgPink.withOpacity(0.3),
        body: Container(
          // height: Get.width > 1500 ?600 :Get.width > 900 ?600 : 500,
          width: Get.width,
          // decoration: BoxDecoration(color: AppColors.bgPink.withOpacity(0.3)),
          padding: const EdgeInsets.symmetric(vertical: 80),
          child: Get.width > 900
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10)),
                      child: SizedBox(
                        // height: Get.width > 1000 ?400: 300,
                        height: Get.width > 800 ? 400 : 400,
                        width: Get.width > 800 ? 400 : 350,
                        // width: Get.width>1500 ?350:Get.width>1000?350:Get.width>600 ?350:350,
                        child: Image.asset(
                          "assets/app_logo.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Sign In",
                    style:
                    TextStyle(fontWeight: FontWeight.w400, fontSize: 25,),
                  ),
                  const SizedBox(height: 30),

                  Column(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Email Id or Mobile No.", style: TextStyle(fontSize: 16, color: Colors.black)),
                          const SizedBox(height: 10,),
                          SizedBox(
                            height: 45,
                            width: Get.width > 700 ? 400 : 350,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child:
                              TextFormField(
                                controller: emailController,
                                validator: (email) {
                                  if (isEmailValid(email!)) {
                                    return null;
                                  } else {
                                    return 'Please enter valid email id or mobile no.';
                                  }
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                                    hintText: 'Please enter your email id or mobile no.',

                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    )

                                ),
                                // style: AppTheme.form_field_text,
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Password", style: TextStyle(fontSize: 16, color: Colors.black)),
                          const SizedBox(height: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 45,
                                child:
                                Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: Get.width > 700 ? 400 : 350,
                                  margin: const EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextFormField(
                                    controller: passwordController,
                                    validator: (password) {
                                      if (isPasswordValid(password!)) {
                                        return null;
                                      } else {
                                        return 'Please enter password';
                                      }
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    autocorrect: true,
                                    textAlign: TextAlign.left,
                                    obscureText: _passwordVisible,
                                    cursorColor: const Color(0xffF5591F),
                                    decoration: InputDecoration(
                                        suffixIcon:IconButton(
                                          icon: _passwordVisible==true?
                                          const Icon(Icons.visibility_off):
                                          const Icon(Icons.visibility),
                                          onPressed: ()=>{
                                            setState(() {
                                              _passwordVisible = !_passwordVisible;
                                            })
                                          },
                                        ),
                                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                        hintText: "Please enter password",
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.grey, width: 1),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.black, width: 1),
                                          borderRadius: BorderRadius.circular(10),
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),

                    ],
                  ),

                  // GestureDetector(
                  //   onTap:() async {
                  //     if(checkValidations()==true){
                  //       loginController.signInApi(emailController.text,passwordController.text);
                  //     }
                  //   },
                  //   child: FittedBox(
                  //     fit: BoxFit.scaleDown,
                  //     child: Container(
                  //       padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  //       decoration: BoxDecoration(
                  //           color: Colors.redAccent.withOpacity(0.7),
                  //           borderRadius:
                  //           const BorderRadius.all(Radius.circular(5))),
                  //       child: Center(
                  //         child: Text("Login",style: AppTextStyle.regularBold.copyWith(fontSize: 20,color: AppColors.whiteColor),),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Center(
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: commonButton(
                            onTap:() async {
                              if(checkValidations()==true){
                                loginController.signInApi(emailController.text,passwordController.text);
                              }
                            },
                            margin: EdgeInsets.zero,
                            width: Get.width > 1500
                                ? 180
                                : Get.width > 1000
                                ? 180
                                : Get.width > 800
                                ? 200
                                : 150,
                            //icon: Icons.phone_android,
                            title: "Login",
                            btnColor: Colors.redAccent.withOpacity(0.7),
                            txtColor: Colors.white)),
                  ),
                ],
              ),
            ],
          )
              : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: SizedBox(
                        height: 180,
                        width: Get.width > 1500
                            ? 150
                            : Get.width > 1000
                            ? 150
                            : Get.width > 600
                            ? 150
                            : 150,
                        child: Image.asset(
                          "assets/app_logo.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Sign Up",
                      style:
                      TextStyle(fontWeight: FontWeight.w300, fontSize: 25),
                    ),
                    const SizedBox(height: 30),
                    Column(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Email Id or Mobile No.", style: TextStyle(fontSize: 16, color: Colors.black)),
                            const SizedBox(height: 10,),
                            SizedBox(
                              height: 45,
                              width: Get.width > 800 ? 400 : 350,
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child:
                                TextFormField(
                                  controller: emailController,
                                  validator: (email) {
                                    if (isEmailValid(email!)) {
                                      return null;
                                    } else {
                                      return 'Please enter valid email id or mobile no.';
                                    }
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                                      hintText: 'Please enter your email id or mobile no.',

                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.black, width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      )

                                  ),
                                  // style: AppTheme.form_field_text,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Password", style: TextStyle(fontSize: 16, color: Colors.black)),
                            const SizedBox(height: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 45,
                                  child:
                                  Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: Get.width > 800 ? 400 : 350,
                                    margin: const EdgeInsets.only(right: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextFormField(
                                      controller: passwordController,
                                      validator: (password) {
                                        if (isPasswordValid(password!)) {
                                          return null;
                                        } else {
                                          return 'Please enter password';
                                        }
                                      },
                                      keyboardType: TextInputType.visiblePassword,
                                      autocorrect: true,
                                      textAlign: TextAlign.left,
                                      obscureText: _passwordVisible,
                                      cursorColor: const Color(0xffF5591F),
                                      decoration: InputDecoration(
                                          suffixIcon:IconButton(
                                            icon: _passwordVisible==true?
                                            const Icon(Icons.visibility_off):
                                            const Icon(Icons.visibility),
                                            onPressed: ()=>{
                                              setState(() {
                                                _passwordVisible = !_passwordVisible;
                                              })
                                            },
                                          ),
                                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                          hintText: "Please enter password",
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.grey, width: 1),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.black, width: 1),
                                            borderRadius: BorderRadius.circular(10),
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30.0),

                      ],
                    ),


                    // GestureDetector(
                    //   onTap:() async {
                    //     if(checkValidations()==true){
                    //       loginController.signInApi(emailController.text,passwordController.text);
                    //     }
                    //   },
                    //   child: FittedBox(
                    //     fit: BoxFit.scaleDown,
                    //     child: Container(
                    //       padding: const EdgeInsets.all(5),
                    //       margin: const EdgeInsets.only(right: 10),
                    //       decoration: BoxDecoration(
                    //           color: AppColors.greyColor.withOpacity(0.5),
                    //           borderRadius:
                    //           const BorderRadius.all(Radius.circular(5))),
                    //       child: const Center(
                    //         child: Text("Login"),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                   /* loginController.isApiProcessing.value==true?
                    Container(
                      height: 60,
                      alignment: Alignment.center,
                      width: 80,
                      child: const GFLoader(
                          type:GFLoaderType.circle
                      ),
                    )
                        :*/Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FittedBox(
                              fit: BoxFit.scaleDown,
                              child: commonButton(
                                  onTap:() async {
                                    if(checkValidations()==true){
                                      loginController.signInApi(emailController.text,passwordController.text);
                                    }
                                  },
                                  margin: EdgeInsets.zero,
                                  width: Get.width > 1500 ? 180 : Get.width > 1000 ? 180 : Get.width > 800 ? 200 : 150,
                                  title: "Login",
                                  btnColor: Colors.redAccent.withOpacity(0.7),
                                  txtColor: Colors.white)),

                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
      },

    );
  }
}
