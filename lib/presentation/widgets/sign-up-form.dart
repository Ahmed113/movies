import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies/presentation/widgets/custom_text_form_feild.dart';
import '../cubits/signUpCubit/sign_up_cubit.dart';
import '../screens/Authentication/Sign_in_screen.dart';
import '../utils/show_snack_bar.dart';


class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  // var cubit;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String? name;

  String? email;

  String? password;

  // bool isLoading = false;
  @override
  Widget build(BuildContext context) {

        var cubit = BlocProvider.of<SignUpCubit>(context);
        print("reeeeeeeeeeeeeeeeeee");
        return Column(
          children: [
            Stack(alignment: Alignment.bottomRight, children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(100),
                ),
                child: BlocProvider.of<SignUpCubit>(context).image!=null?
                Image(image: FileImage(File(BlocProvider.of<SignUpCubit>(context).image!.path)),
                  width: 140.w,
                  height: 135.h,
                  fit: BoxFit.fill,):
                Image.asset(
                  "assets/person.jpg",
                  width: 140.w,
                  height: 135.h,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: 35.w,
                height: 33.h,
                margin: const EdgeInsets.all(5),
                // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.6),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: InkWell(
                  onTap: (){
                    showModalBottomSheet(context: context,
                        builder: (context){
                          return SafeArea(
                            child: Wrap(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.photo_library),
                                  title: Text('Choose from Gallery'),
                                  onTap: () {
                                    cubit.pickImage(ImageSource.gallery);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.camera_alt),
                                  title: Text('Take a Photo'),
                                  onTap: () {
                                    cubit.pickImage(ImageSource.camera);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: Color(0xffE76402),
                  ),
                ),
              )
            ]),
            const SizedBox(
              height: 30,
            ),
            Form(
                key: _formKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 9),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 15.h),
                        CustomTextFormField(
                          // controller: nameController,
                          obscureText: false,
                          obscuringCharacter: ' ',
                          prefixIcon: Icons.person_outline,
                          textType: TextInputType.text,
                          hint: "Enter your name",
                          aboveText: "Full Name",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter your name";
                            }
                            name = value;
                            return null;
                          },
                          filled: false,
                        ),
                        CustomTextFormField(
                          // controller: nameController,
                          obscureText: false,
                          obscuringCharacter: ' ',
                          prefixIcon: Icons.email_outlined,
                          textType: TextInputType.emailAddress,
                          hint: "example@website.com",
                          aboveText: "Email",
                          validator: (value) {
                            if (value!.isNotEmpty && value.isValidEmail()) {
                              email = value;
                              return null;
                            } else {
                              return "Enter valid email";
                            }
                          },
                          filled: false,
                        ),
                        CustomTextFormField(
                            // controller: nameController,
                            obscureText: cubit.obsecurePass,
                            obscuringCharacter: '*',
                            prefixIcon: Icons.lock_outline,
                            textType: TextInputType.visiblePassword,
                            hint: "Enter your password",
                            aboveText: "Password",
                            suffixIcon: Icons.visibility_off,
                            suffixIcon2: Icons.visibility,
                            onSuffixClickIcon: () {
                              cubit.changePasswordVisibility();
                            },
                            validator: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return 'Password should be at least 6 characters';
                              } else {
                                password = value;
                                return null;
                              }
                            },
                          filled: false,
                            ),
                        CustomTextFormField(
                          // controller: nameController,
                          obscureText: cubit.obsecureConfirmPass,
                          obscuringCharacter: '*',
                          prefixIcon: Icons.lock_outlined,
                          textType: TextInputType.visiblePassword,
                          hint: "Confirm your password",
                          aboveText: "Confirm Password",
                          suffixIcon: Icons.visibility_off,
                          suffixIcon2: Icons.visibility,
                          onSuffixClickIcon: () {
                            cubit.changeConfirmPasswordVisibility();
                          },
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'Password should be at least 6 characters';
                            } else if (value != password) {
                              return "Confirm password doesn't match password";
                            }
                          },
                          filled: false,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffE76402),
                            textStyle: const TextStyle(
                              color: Colors.deepOrangeAccent,
                            ),
                          ),
                          onPressed: () async{
                            if (_formKey.currentState!.validate()) {
                              // isLoading = true;
                              print("mmmmmmmmmmmmmmm${cubit.image?.path}");
                              cubit.submitForm(email: email!, password: password!, name: name!, imageFile: cubit.image );
                            } else {
                              // isLoading = false;
                              showSnackBar(context, "Enter valid data");
                            }
                          },
                          child: Text('Sign up'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "have an account?",
                              // style: TextStyle(color: Colors.white70),
                            ),
                            SizedBox(width: 3.w),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignInScreen()));
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    color: const Color(0xffE76402),
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        )
                      ],
                    ),
                  ),
                )),
          ],
        );
    //   },
    // );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
