import 'package:fichas_med_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fichas_med_app/services/auth_service.dart';
import 'package:fichas_med_app/utils/MLCommon.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fichas_med_app/components/MLSocialAccountComponent.dart';
// import 'package:fichas_med_app/screens/MLForgetPasswordScreen.dart';
// import 'package:fichas_med_app/screens/MLRegistrationScreen.dart';
import 'package:fichas_med_app/utils/MLColors.dart';
import 'package:fichas_med_app/utils/MLImage.dart';
import 'package:fichas_med_app/utils/MLString.dart';
import 'package:fichas_med_app/main.dart';

// import '../model/user.dart';

class MLLoginScreen extends StatefulWidget {
  static String tag = '/MLLoginScreen';

  @override
  _MLLoginScreenState createState() => _MLLoginScreenState();
}

class _MLLoginScreenState extends State<MLLoginScreen> {
  // Key Form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _loading = false;

  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    changeStatusColor(mlPrimaryColor);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> init() async {
    changeStatusColor(mlPrimaryColor);
  }

  void validateAndSave() async {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      try {
        setState(() {
          _loading = true;
        });
        Map<String, String> formData = {
          'email': emailController.text,
          'password': passwordController.text,
        };
        print('Formulario válido, guardando datos');
        print('Datos del formulario: $formData');
        // Aquí puedes guardar los datos o realizar otra acción
        await authService.login(
            email: emailController.text, password: passwordController.text);
        if (mounted) {
          setState(() {
            _loading = false;
            Navigator.pushReplacementNamed(context, '/dashboard');
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _loading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString()),
          ));
        }
      }
    } else {
      // El formulario no es válido o el estado del formulario es nulo
      print('Formulario no válido');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mlPrimaryColor,
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 250),
            height: context.height(),
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: radiusOnly(topRight: 32),
              backgroundColor: context.cardColor,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    60.height,
                    Text(mlLogin_title!, style: secondaryTextStyle(size: 16)),
                    16.height,
                    /* Row(
                      children: [
                        MLCountryPickerComponent(),
                        16.width,
                        AppTextField(
                          textFieldType: TextFieldType.PHONE,
                          decoration: InputDecoration(
                            labelText: mlPhoneNumber!,
                            labelStyle: secondaryTextStyle(size: 16),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mlColorLightGrey.withOpacity(0.2), width: 1),
                            ),
                          ),
                        ).expand(),
                      ],
                    ), */
                    AppTextField(
                      textFieldType: TextFieldType.OTHER,
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, introduce un email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: mlLogin_user!,
                        labelStyle: secondaryTextStyle(size: 16),
                        prefixIcon: Icon(Icons.email_outlined,
                            color: appStore.isDarkModeOn ? white : black),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: mlColorLightGrey.withOpacity(0.2)),
                        ),
                      ),
                    ),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.PASSWORD,
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, introduce una contraseña';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: mlPassword!,
                        labelStyle: secondaryTextStyle(size: 16),
                        prefixIcon: Icon(Icons.lock_outline,
                            color: appStore.isDarkModeOn ? white : black),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: mlColorLightGrey.withOpacity(0.2)),
                        ),
                      ),
                    ),
                    8.height,
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(mlForget_password!,
                              style: secondaryTextStyle(size: 16))
                          .onTap(
                        () {
                          // MLForgetPasswordScreen().launch(context);
                        },
                      ),
                    ),
                    24.height,
                    AppButton(
                      color: mlPrimaryColor,
                      width: double.infinity,
                      onTap: validateAndSave,
                      /* () {
                        /* finish(context); */
                        /* MLDashboardScreen().launch(context); */
                        print('Email: ${emailController.text}');
                        print('Password: ${passwordController.text}');
                      }, */
                      child: Text(mlLogin!, style: boldTextStyle(color: white)),
                    ),
                    22.height,
                    Text(mlLogin_with!, style: secondaryTextStyle(size: 16))
                        .center(),
                    22.height,
                    MLSocialAccountsComponent(),
                    22.height,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(mlDont_have_account!, style: primaryTextStyle()),
                    //     8.width,
                    //     Text(
                    //       mlRegister!,
                    //       style: boldTextStyle(
                    //           color: mlColorBlue,
                    //           decoration: TextDecoration.underline),
                    //     ).onTap(
                    //       () {
                    //         // MLRegistrationScreen().launch(context);
                    //       },
                    //     ),
                    //   ],
                    // ),
                    // 32.height,
                  ],
                ).paddingOnly(left: 16, right: 16),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 75),
            width: context.width(),
            child: commonCachedNetworkImage(ml_ic_register_indicator!,
                alignment: Alignment.center, width: 200, height: 200),
          ),
          if (_loading)
            Container(
              height: context.height(),
              width: context.width(),
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: SpinKitSquareCircle(
                  color: mlPrimaryColor,
                  size: 50.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
