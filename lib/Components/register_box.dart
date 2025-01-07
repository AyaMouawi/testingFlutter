import 'package:flutter/material.dart';
import 'package:pushnotificationupdate1/Style/my_colors.dart';
import 'package:pushnotificationupdate1/Style/text_style.dart';

class RegisterBox extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final bool isLoading;
  final String responseMessage;
  final bool isRegistered;
  final String errorMessage;
  final Function registerUser;

  const RegisterBox({
    Key? key,
    required this.formKey,
    required this.phoneController,
    required this.isLoading,
    required this.responseMessage,
    required this.isRegistered,
    required this.errorMessage,
    required this.registerUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: MyColors.boxShadowColor,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: isRegistered
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  responseMessage,
                  style: responseMessage == 'Registered Successfully'
                      ? AppTextStyles.responseMessageSuccess
                      : AppTextStyles.responseMessageError,
                ),
              ],
            )
          : Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Register',
                    style: AppTextStyles.heading,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MyColors.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MyColors.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      } else if (!RegExp(r'^\+?[0-9]{10,13}$').hasMatch(value)) {
                        return 'Enter a valid phone number';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      registerUser();
                    },
                  ),
                  const SizedBox(height: 20),
                  if (isLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (!isLoading)
                    Center(
                      child: Column(
                        children: [
                          if (responseMessage.isNotEmpty)
                            Text(
                              responseMessage,
                              style: TextStyle(
                                color: responseMessage == 'Registered Successfully'
                                    ? MyColors.success
                                    : MyColors.error,
                              ),
                            ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 230,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: MyColors.white,
                                backgroundColor: MyColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () => registerUser(),
                              child: const Text('Register'),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
