import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../cubits/signUpCubit/sign_up_cubit.dart';
import '../../cubits/signUpCubit/sing_up_state.dart';
import '../../utils/show_snack_bar.dart';
import '../../widgets/sign-up-form.dart';
import 'email_verification_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (BuildContext context, SignUpState state) {
        if (state is SubmitLoading) {
          isLoading = true;
          print("11111111111111$isLoading $state");
        }else if (state is SubmitSuccess) {
          isLoading = true;
          print("22222222222222$isLoading $state");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const EmailVerificationScreen()));
        } else if (state is SubmitFailed) {
          isLoading = false;
          print("333333333333333$isLoading $state");
          showSnackBar(context, state.msg);
        }else{
          isLoading = false;
          print("444444444444444$isLoading $state");
        }
      },
      builder: (context, state)=> ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: LayoutBuilder(
            builder: (context, constraints){
              double screenWidth = constraints.maxWidth;
              double screenHeight = constraints.maxHeight;
              return Container(
                height: screenHeight,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/backgroundImg8.jpg"),
                        fit: BoxFit.cover)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 45.h,
                      ),
                      SignUpForm(),
                    ],
                  ),
                ),
              );
            },
            // child:
          ),
        ),
      ),
    );
  }
}
