import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movies/presentation/screens/Authentication/sign_up_screen.dart';
import '../../cubits/signInCubit/sign_in_cubit.dart';
import '../../cubits/signInCubit/sign_in-state.dart';
import '../../cubits/signUpCubit/sign_up_cubit.dart';
import '../../utils/show_snack_bar.dart';
import '../../widgets/custom-button.dart';
import '../../widgets/custom_text_form_feild.dart';
import '../bottomNavBar/bottom_nav_bar.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // GoogleAuth googleAuth = GoogleAuth();
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email',"https://www.googleapis.com/auth/userinfo.profile"]);
  late FirebaseAuth _auth;
  bool isUserSignedIn = false;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<SocialSignInCubit, SocialSignInState>(
        listener: (BuildContext context, SocialSignInState state) {
          switch(state.runtimeType) {
            case SignInWithEmailAndPasswordLoading:
              isLoading = true;
              break;
            case SignInWithEmailAndPasswordSuccess:
              isLoading = false;
              // print("qqqqqqqqqqqqq${(state as SignInWithEmailAndPasswordSuccess).user.displayName}");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavBar(
                    user: (state as SignInWithEmailAndPasswordSuccess).user,
                  ),
                ),
              );
              break;
            case SignInWithEmailAndPasswordFailed:
              isLoading = false;
              showSnackBar(context, (state as SignInWithEmailAndPasswordFailed).msg);
              break;
            case GoogleSignInLoading:
              isLoading = true;
              break;
            case GoogleSignInSuccess:
              isLoading = false;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavBar(
                    user: (state as GoogleSignInSuccess).user,
                  ),
                ),
              );
              break;
            case GoogleSignInFailed:
              isLoading = false;
              showSnackBar(context, (state as GoogleSignInFailed).msg);
              break;
            case FBSignInLoading:
              isLoading = true;
              break;
            case FBSignInSuccess:
              isLoading = false;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavBar(
                    fbUser: (state as FBSignInSuccess).user,
                  ),
                ),
              );
              break;
            case FBSignInFailed:
              isLoading = false;
              showSnackBar(context, (state as FBSignInFailed).msg);
              break;
            default:
          }

        },
        builder:(context, state)=> ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Container(
            padding: const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 8),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/backgroundImg8.jpg"),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Welcome Back, Sign In!",
                    style: TextStyle(color: Colors.white, fontSize: 25.sp),
                  ),
                ),
                SizedBox(
                  height: 40.h,
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
                              controller: _emailController,
                              obscureText: false,
                              obscuringCharacter: ' ',
                              prefixIcon: Icons.email_outlined,
                              textType: TextInputType.emailAddress,
                              hint: "example@website.com",
                              aboveText: "Email",
                              filled: true,
                            ),
                            CustomTextFormField(
                              controller: _passwordController,
                              obscureText: BlocProvider.of<SocialSignInCubit>(context).obsecurePass,
                              obscuringCharacter: '*',
                              prefixIcon: Icons.lock_outline,
                              textType: TextInputType.visiblePassword,
                              hint: "Enter your password",
                              aboveText: "Password",
                              suffixIcon: Icons.visibility_off,
                              suffixIcon2: Icons.visibility,
                              onSuffixClickIcon: () {
                                BlocProvider.of<SocialSignInCubit>(context).changePasswordVisibility();
                              },
                              filled: true,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Remember Me",
                                    style: TextStyle(color: Colors.black, fontSize: 12.sp)),
                                Checkbox(
                                  value: false,
                                  onChanged: (value) {},
                                  fillColor: MaterialStateColor.resolveWith(
                                        (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.disabled)) {
                                        return Colors.grey;
                                      }
                                      return Colors.white70;
                                    },
                                  ),
                                  checkColor: const Color(0xffE76402),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),
                                SizedBox(
                                  width: 30.w,
                                ),
                                const Text(
                                  "Forgot password?",
                                  style: TextStyle(
                                    color: Color(0xff5A4AAE),
                                    // fontSize: 10.sp
                                  ),
                                )
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffE76402),
                                textStyle: const TextStyle(
                                  color: Colors.deepOrangeAccent,
                                ),
                              ),
                              onPressed: () async{
                                BlocProvider.of<SocialSignInCubit>(context).emailPasswordSignIn(email: _emailController.text, password: _passwordController.text);
                              },
                              child: const Text('Sign in'),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                  height: 25.h,
                ),
                CustomButton(
                    btnText: "Continue with Google",
                    side: BorderSide(
                        color: const Color(0xff5A4AAE).withOpacity(.5), width: 2),
                    image: const AssetImage("assets/google.png"),
                onPressed: (){
                  BlocProvider.of<SocialSignInCubit>(context)
                      .logInWithGoogle();
                },
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomButton(
                    btnText: "Continue with Facebook",
                    side: BorderSide(
                        color: const Color(0xff5A4AAE).withOpacity(.5), width: 2),
                    image: const AssetImage("assets/facebook.png"),
                  onPressed: (){
                    BlocProvider.of<SocialSignInCubit>(context).loginWithFB();
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(width: 3.w),
                    InkWell(
                      onTap: (){
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                            (route)=> true
                        );
                        context.read<SignUpCubit>().dispose();
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: const Color(0xff5A4AAE),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
