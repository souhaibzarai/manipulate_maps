import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manipulate_maps/business_logic/cubit/phone_auth_cubit.dart';
import 'package:manipulate_maps/presentation/widgets/auth_drop_down.dart';
import 'package:manipulate_maps/presentation/widgets/auth_feature_button.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../widgets/auth_form_field.dart';
import 'package:transparent_image/transparent_image.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _formKey = GlobalKey<FormState>();
  late String phoneNumber;
  final _phoneNumberController = TextEditingController();
  bool isCountrySelected = false;
  String? countryCode;

  Future<void> _authenticate(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      Navigator.pop(context);
      return;
    } else if (countryCode == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a country code.'),
          backgroundColor: AppColors.errorColor,
        ),
      );
      return;
    } else {
      Navigator.pop(context);
      _formKey.currentState!.save();
      phoneNumber = '${countryCode!} ${_phoneNumberController.text}';
      BlocProvider.of<PhoneAuthCubit>(context).submitPhoneNumber(phoneNumber);
    }
  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: AppColors.transparentColor,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(AppColors.darkColor),
        ),
      ),
    );

    showDialog(
      barrierColor: AppColors.thirdColor,
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  Widget _phoneNumberSubmitedBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }

        if (state is PhoneNumberSubmitted) {
          Navigator.pop(context);
          Navigator.pushNamed(context, otpScreen, arguments: phoneNumber);
        }

        if (state is ErrorOccurred) {
          String errorMessage = state.errorMsg;

          Navigator.pop(context);
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(errorMessage),
            dismissDirection: DismissDirection.horizontal,
            duration: Duration(seconds: 8),
            backgroundColor: AppColors.headerColor,
          ));
          context.read<PhoneAuthCubit>().reset();
        }
      },
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Login With Phone Number',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: AppColors.headerColor,
                    ),
                  ),
                  SizedBox(height: 40),
                  FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Google_Maps_Logo_2020.svg/2275px-Google_Maps_Logo_2020.svg.png',
                    ),
                    width: double.infinity,
                    height: 250,
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AuthDropDown(
                        setValue: (country) {
                          final phonePrefix = country.phonePrefix;
                          setState(() {
                            countryCode = phonePrefix.startsWith('+')
                                ? phonePrefix
                                : '+$phonePrefix';
                            isCountrySelected = true;
                          });
                        },
                      ),
                      SizedBox(width: 10),
                      AuthFormField(
                        controller: _phoneNumberController,
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  AuthFeatureButton(
                    onClickEvent: () {
                      showProgressIndicator(context);
                      _authenticate(context);
                    },
                    isEnabled: isCountrySelected,
                    text: 'Next',
                  ),
                  _phoneNumberSubmitedBloc(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
