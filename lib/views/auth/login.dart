import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/controllers/auth_controller.dart';
import 'package:flutter_tinavibe/widgets/auth_input.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:flutter_tinavibe/routes/route_names.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  final AuthController controller = Get.put(AuthController());

  void submit() => {
        if (_form.currentState!.validate())
          {
            controller.login(emailController.text, passwordController.text),
          }
      };

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: 60,
                    height: 60,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Đăng nhập",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text('Chào mừng trở lại'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  AuthInput(
                    label: "Email",
                    hintText: "",
                    controller: emailController,
                    validatorCallback: ValidationBuilder().email().build(),
                  ),
                  const SizedBox(height: 20),
                  AuthInput(
                    label: "Mật khẩu",
                    hintText: "",
                    isPasswordField: true,
                    controller: passwordController,
                    validatorCallback: ValidationBuilder().required().build(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: submit,
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        const Size.fromHeight(40),
                      ),
                    ),
                    child: const Text("Tiếp tục"),
                  ),
                  const SizedBox(height: 20),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: " Đăng ký",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.toNamed(RouteNames.register))
                  ], text: "Chưa có tài khoản ?"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
