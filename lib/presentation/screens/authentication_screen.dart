import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../widgets/auth_form_field.dart';
import 'package:transparent_image/transparent_image.dart';

class AuthenticationScreen extends StatelessWidget {
  AuthenticationScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  void validateForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      print('done');
      Navigator.of(context).pushNamed(otpScreen);
    }
  }

  final _phoneNumberController = TextEditingController();

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
                      // TODO: controller need be set
                      AuthFormField(isReadOnly: true),
                      SizedBox(width: 10),
                      AuthFormField(
                        controller: _phoneNumberController,
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        validateForm(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkColor,
                        foregroundColor: AppColors.thirdColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Next'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
