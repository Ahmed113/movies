import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../cubits/profilCubit/profile_cubit.dart';
import '../cubits/profilCubit/profile_state.dart';
import '../widgets/custom_profile_row.dart';
import 'Authentication/Sign_in_screen.dart';


class Profile extends StatelessWidget {
  Profile({super.key, this.user, this.fbUser});

  User? user;
  Map? fbUser;
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    // String? photoUrl = user?.photoURL;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
                padding: const EdgeInsets.only(top: 70),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:AssetImage("assets/backgroundImg8.jpg"),
                        fit: BoxFit.cover
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                              decoration: const BoxDecoration(
                                color: CupertinoColors.white,
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(100),),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(100),),
                              child: BlocBuilder<ProfileCubit, ProfileState>(
                                builder: (BuildContext context, ProfileState state) {
                                  if (state is ChangePicLoading) {
                                    isLoading = true;
                                    return SizedBox(
                                        height: 150.h,
                                        width: 145.w,
                                        child: const CircularProgressIndicator());
                                  }else if(state is ChangePicSuccess){
                                    isLoading = false;
                                    String photoUrl = state.imgUrl;
                                    print("object");
                                    return Image.network(
                                          user!=null? photoUrl:
                                          "${fbUser?["picture"]["data"]["url"]}",
                                          width: 150.w,
                                          height: 145.h,
                                          fit: BoxFit.fill,
                                    );
                                  }
                                  else if(state is ChangePicFailed){
                                    return Text(state.msg);
                                  }else{
                                    return user?.photoURL!=null || fbUser?["picture"]["data"]["url"] != null? Image.network(
                                          user!=null? "${user?.photoURL}":
                                          "${fbUser?["picture"]["data"]["url"]}",
                                          width: 140.w,
                                          height: 135.h,
                                          fit: BoxFit.fill,
                                    ):Image.asset(
                                      "assets/person.jpg",
                                      width: 140.w,
                                      height: 135.h,
                                      fit: BoxFit.fill,
                                    );
                                  }
                                }
                              ),
                            ),
                          ),
                          ),


                          Container(
                            width: 35.w,
                            height: 33.h,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.6),
                                borderRadius: BorderRadius.all(Radius.circular(50))
                            ),
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
                                                BlocProvider.of<ProfileCubit>(context).handleImagePick(ImageSource.gallery);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.camera_alt),
                                              title: Text('Take a Photo'),
                                              onTap: () {
                                                BlocProvider.of<ProfileCubit>(context).handleImagePick(ImageSource.camera);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: const Icon(Icons.camera_alt_outlined,
                                color: Color(0xffE76402),),
                            ),
                          )
                        ]
                    ),
                    SizedBox(height: 18.h,),
                    Text(user!= null? "${user?.displayName}":"${fbUser?["name"]}", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        fontFamily: "Poppins",
                        color: Colors.white
                    ),),
                    Text(user!= null? "${user?.email}":"${fbUser?["email"]}", style: TextStyle(
                      // fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        fontFamily: "Poppins",
                        color: Colors.white.withOpacity(.5)
                    ),),
                    SizedBox(height: 15.h,),
                    Container(
                      padding: EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          CustomProfileRow(
                            containerColor: Color(0xffFFF3E1),
                            icon: Icons.person,
                            iconColor: Color(0xffFFC200),
                            text: "Information",
                          ),
                          CustomProfileRow(
                            containerColor: Color(0xffEEE8FF),
                            icon: Icons.payment_outlined,
                            iconColor: Color(0xff9A00FF),
                            text: "Payment method",
                          ),
                          CustomProfileRow(
                            containerColor: Color(0xffFEEBDD),
                            icon: Icons.settings,
                            iconColor: Color(0xffDE7A00),
                            text: "Settings",
                          ),
                          CustomProfileRow(
                            containerColor: const Color(0xffCFDCFE),
                            icon: Icons.lock,
                            iconColor: const Color(0xff5687F0),
                            text: "Privacy Policy",
                          ),
                          CustomProfileRow(
                            containerColor: const Color(0xffE0FAD5),
                            icon: Icons.contact_support_rounded,
                            iconColor: const Color(0xff59C457),
                            text: "Support",
                          ),
                          SizedBox(height: 8.h,),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff30343F),
                              textStyle: const TextStyle(
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInScreen(),
                                ),
                                    (route)=>false,
                              );
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Sign out', style: TextStyle(
                                    color: Colors.white
                                ),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
      )
    );
  }
}
//Row(
//                     children: [
//                       Icon(Icons.logout, color: Colors.red, ),
//                       SizedBox(width: 4.w,),
//                       Text("Log Out", style: TextStyle(
//                         color: Colors.red,
//
//                       ),),
//                       Spacer(flex: 1,),
//                       Text("Delete account", style: TextStyle(
//                         color: Colors.red,
//                         fontWeight: FontWeight.bold
//                       ),),
//                     ],
//                   ),

