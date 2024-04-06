import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../cubits/emailVerificationCubit/email_verification_cubit.dart';
import '../../cubits/emailVerificationCubit/email_verification_state.dart';
import '../../utils/show_snack_bar.dart';
import 'Sign_in_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // BlocProvider.of<EmailVerificationCubit>(context).checkAndDeleteUserOnStart();
    BlocProvider.of<EmailVerificationCubit>(context).sendEmail();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // BlocProvider.of<EmailVerificationCubit>(context).dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<EmailVerificationCubit, EmailVerificationState>(
        listener: (BuildContext context, EmailVerificationState state) {
          if (state is SuccessEmailVerificationState) {
            print("sssssssssssssss $state");
            // if (state.isVerified == true) {
              print("iiiiiiiiiiiiiiii ${state.isVerified}");
              showSnackBar(context, "Email Successfully Verified");
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignInScreen()));
            // }

          }else if (state is FailedEmailVerificationState) {
            showSnackBar(context, "${state.msg}");
          }
        },
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/backgroundImg8.jpg"),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              SizedBox(height: 45.h,),
              const Text("Check your email", style: TextStyle(
                color: Colors.white70
              ),),
              const Text("We have sent you an email", style: TextStyle(
                  color: Colors.white70
              )),
              SizedBox(height: 15.h,),
              Center(child: SizedBox(
                height: 20.h,
                  width: 20.w,
                  child: CircularProgressIndicator())),
              SizedBox(height: 5.h,),
              const Text(
                'Verifying email....',
                textAlign: TextAlign.center,style: TextStyle(
                  color: Colors.white70
              )
              ),
              SizedBox(height: 15.h,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffE76402),
                  textStyle: const TextStyle(
                    color: Colors.deepOrangeAccent,
                  ),
                ),
                onPressed: (){
                  BlocProvider.of<EmailVerificationCubit>(context).sendEmail();
                },
                child: const Text('Resend'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
