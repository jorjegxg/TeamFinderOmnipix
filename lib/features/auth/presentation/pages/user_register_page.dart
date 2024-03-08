import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RegisterScreenForAdmin extends StatelessWidget {
  const RegisterScreenForAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFEF7FF),
        body: Sizer(
          builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) {
            return ScreenTypeLayout.builder(
              mobile: (p0) => const MobileRegisterPage(),
            );
          },
        ),
      ),
    );
  }
}

class MobileRegisterPage extends StatelessWidget {
  const MobileRegisterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GetDetailsForm(),
        RegisterButton(),
        ChangeAuthPageText(),
        LogoWidget(),
      ],
    );
  }
}

///800 h
///360 w
class GetDetailsForm extends StatelessWidget {
  GetDetailsForm({
    super.key,
  });
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Center(
        child: SizedBox(
          width: 70.w,
          height: 46.h,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 70.w,
                  height: 46.h,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF7F2FA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          name: 'email',
                          decoration: InputDecoration(
                              labelText: 'Email',
                              fillColor: const Color(0xFFEAE4EF),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ]),
                        ),
                        const SizedBox(height: 10),
                        FormBuilderTextField(
                          name: 'password',
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                        ),
                        MaterialButton(
                          color: Theme.of(context).colorScheme.secondary,
                          onPressed: () {
                            // Validate and save the form values
                            _formKey.currentState?.saveAndValidate();
                            debugPrint(_formKey.currentState?.value.toString());

                            // On another side, can access all field values without saving form with instantValues
                            _formKey.currentState?.validate();
                            debugPrint(
                                _formKey.currentState?.instantValue.toString());
                          },
                          child: const Text('Login'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //   Positioned(
              //     left: 8,
              //     top: 28,
              //     child: SizedBox(
              //       width: 255,
              //       height: 45,
              //       child: Stack(
              //         children: [
              //           Positioned(
              //             left: 0,
              //             top: 0,
              //             child: Container(
              //               width: 255,
              //               height: 45,
              //               decoration: ShapeDecoration(
              //                 color: const Color(0xFFEAE4EF),
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(15),
              //                 ),
              //               ),
              //             ),
              //           ),
              //           const Positioned(
              //             left: 111,
              //             top: 18,
              //             child: SizedBox(
              //               width: 39,
              //               height: 15,
              //               child: Text(
              //                 'Name',
              //                 style: TextStyle(
              //                   color: Colors.black,
              //                   fontSize: 12,
              //                   fontFamily: 'Inter',
              //                   fontWeight: FontWeight.w400,
              //                   height: 0,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              //   Positioned(
              //     left: 8,
              //     top: 94,
              //     child: SizedBox(
              //       width: 255,
              //       height: 45,
              //       child: Stack(
              //         children: [
              //           Positioned(
              //             left: 0,
              //             top: 0,
              //             child: Container(
              //               width: 255,
              //               height: 45,
              //               decoration: ShapeDecoration(
              //                 color: const Color(0xFFEAE4EF),
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(15),
              //                 ),
              //               ),
              //             ),
              //           ),
              //           const Positioned(
              //             left: 111,
              //             top: 10,
              //             child: SizedBox(
              //               width: 33,
              //               height: 26,
              //               child: Text(
              //                 'Email',
              //                 style: TextStyle(
              //                   color: Colors.black,
              //                   fontSize: 12,
              //                   fontFamily: 'Inter',
              //                   fontWeight: FontWeight.w400,
              //                   height: 0,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              //   Positioned(
              //     left: 8,
              //     top: 161,
              //     child: SizedBox(
              //       width: 255,
              //       height: 45,
              //       child: Stack(
              //         children: [
              //           Positioned(
              //             left: 0,
              //             top: 0,
              //             child: Container(
              //               width: 255,
              //               height: 45,
              //               decoration: ShapeDecoration(
              //                 color: const Color(0xFFEAE4EF),
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(15),
              //                 ),
              //               ),
              //             ),
              //           ),
              //           const Positioned(
              //             left: 101,
              //             top: 14,
              //             child: SizedBox(
              //               width: 58,
              //               height: 18,
              //               child: Text(
              //                 'Password',
              //                 style: TextStyle(
              //                   color: Colors.black,
              //                   fontSize: 12,
              //                   fontFamily: 'Inter',
              //                   fontWeight: FontWeight.w400,
              //                   height: 0,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              //   Positioned(
              //     left: 8,
              //     top: 230,
              //     child: SizedBox(
              //       width: 255,
              //       height: 45,
              //       child: Stack(
              //         children: [
              //           Positioned(
              //             left: 0,
              //             top: 0,
              //             child: Container(
              //               width: 255,
              //               height: 45,
              //               decoration: ShapeDecoration(
              //                 color: const Color(0xFFEAE4EF),
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(15),
              //                 ),
              //               ),
              //             ),
              //           ),
              //           const Positioned(
              //             left: 69,
              //             top: 13,
              //             child: SizedBox(
              //               width: 117,
              //               height: 18,
              //               child: Text(
              //                 'Organization Name',
              //                 style: TextStyle(
              //                   color: Colors.black,
              //                   fontSize: 12,
              //                   fontFamily: 'Inter',
              //                   fontWeight: FontWeight.w400,
              //                   height: 0,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              //   Positioned(
              //     left: 8,
              //     top: 299,
              //     child: SizedBox(
              //       width: 255,
              //       height: 45,
              //       child: Stack(
              //         children: [
              //           Positioned(
              //             left: 0,
              //             top: 0,
              //             child: Container(
              //               width: 255,
              //               height: 45,
              //               decoration: ShapeDecoration(
              //                 color: const Color(0xFFEAE4EF),
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(15),
              //                 ),
              //               ),
              //             ),
              //           ),
              //           const Positioned(
              //             left: 67,
              //             top: 11,
              //             child: SizedBox(
              //               width: 126,
              //               height: 27,
              //               child: Text(
              //                 'Organization Address',
              //                 style: TextStyle(
              //                   color: Colors.black,
              //                   fontSize: 12,
              //                   fontFamily: 'Inter',
              //                   fontWeight: FontWeight.w400,
              //                   height: 0,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 25.w,
      top: 84.h,
      child: MaterialButton(
        height: 6.h,
        minWidth: 50.w,
        color: const Color(0xFF6750A4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Text(
          'Register',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
        onPressed: () {
          ///TODO: implement register administrator
        },
      ),
    );
  }
}

class ChangeAuthPageText extends StatelessWidget {
  const ChangeAuthPageText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 36.w,
      top: 90.h,
      child: TextButton(
        onPressed: () {
          ///TODO: implement change to login screen
        },
        child: const Text(
          'Want to log in?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 35.w,
      top: 9.625.h,
      child: SizedBox(
        width: 31.w,
        height: 14.h,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 31.w,
                height: 14.h,
                decoration: const ShapeDecoration(
                  color: Color(0xFF6750A4),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              top: 1.5.h,
              left: 1.5.h,
              child: Icon(
                size: 12.h,
                color: Colors.white,
                Icons.handshake,
              ),
            )
          ],
        ),
      ),
    );
  }
}
