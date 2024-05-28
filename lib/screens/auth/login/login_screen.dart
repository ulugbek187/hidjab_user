import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../data/form_status/form_status.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/constans/app_constans.dart';
import '../../../utils/formaters/formatters.dart';
import '../../../utils/image/appimage.dart';
import '../../../utils/styles/app_text_style.dart';
import '../../routes.dart';
import '../dialog/error_dialog.dart';
import '../widgets/global_passwordfield.dart';
import '../widgets/global_textbutton.dart';
import '../widgets/global_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKeyTwo = GlobalKey<FormState>();
  final _formKeyThree = GlobalKey<FormState>();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == FormsStatus.error) {
              debugPrint("Hello dialog");
              errorDialog(context: context, errorText: state.errorMessage);
            }
            if (state.status == FormsStatus.authenticated) {
              if (state.statusMessage == "registered") {
                // BlocProvider.of<ResumeBloc>(context).add(
                //   InsertResumeEvent(uid: state.userModel.authUid),
                // );
              }
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteNames.homeScreen,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 102.h, left: 29.w, right: 29.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "welcome_back",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 30),
                      ),
                    ),
                    SizedBox(height: 11.h),
                    Center(
                      child: Text(
                        "login_to_use_app",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 64.h),
                    Text(
                      "phone",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 10.h),
                    GlobalTextField(
                      onChanged: (v) {
                        if (v?.length == 17) {
                          FocusManager.instance.primaryFocus!.nextFocus();
                        }
                      },
                      type: TextInputType.phone,
                      inputFormatter: [AppInputFormatters.phoneFormatter],
                      title: '+998',
                      icon: const Icon(Icons.phone),
                      controller: phoneController,
                      validate: RegExp(''),
                      validateText: 'Invalid phone',
                      validateEmptyText: 'Enter phone number',
                      formKey: _formKeyTwo,
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      "password",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 10.h),
                    GlobalPasswordField(
                      title: '* * * * * *',
                      icon: const Icon(Icons.lock),
                      controller: passwordController,
                      validate: AppConstants.passwordRegExp,
                      formKey: _formKeyThree,
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(height: 24.h),
                    Padding(
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: GlobalTextButton(
                        isLoading: state.status == FormsStatus.loading,
                        onTap: () {
                          final isValidateTwo =
                              _formKeyTwo.currentState!.validate();
                          final isValidateThree =
                              _formKeyThree.currentState!.validate();
                          if (isValidateTwo && isValidateThree) {
                            String cleanedPhone = phoneController.text
                                .replaceAll(RegExp(r'\D+'), '');
                            context.read<AuthBloc>().add(
                                  LoginUserEvent(
                                    phoneNumber: cleanedPhone,
                                    password: passwordController.text,
                                  ),
                                );
                          }
                        },
                        text: "login",
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Padding(
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: SizedBox(
                        height: 50.h,
                        width: double.infinity,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.c1A72DD,
                          ),
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(SignInWithGoogleEvent());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AppImages.google, height: 20.h),
                              SizedBox(width: 10.w),
                              Text(
                                "sign_up_google",
                                style: AppTextStyle.width600.copyWith(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "have_an_account",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 12),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RouteNames.signup);
                          },
                          child: Text(
                            'Sign up',
                            style: AppTextStyle.width600.copyWith(
                                fontSize: 12, color: AppColors.c1A72DD),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
