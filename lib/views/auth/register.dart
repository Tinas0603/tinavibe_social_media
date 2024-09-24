import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tinavibe/controllers/auth_controller.dart';
import 'package:flutter_tinavibe/widgets/auth_input.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:flutter_tinavibe/routes/route_names.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController nameController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  final TextEditingController cpasswordController =
      TextEditingController(text: "");
  final AuthController controller = Get.put(AuthController());
  // submit method
  void submit() => {
        if (_form.currentState!.validate())
          {
            controller.register(nameController.text, emailController.text,
                passwordController.text),
          }
      };
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    cpasswordController.dispose();
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
                          "Đăng ký",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text('Chào mừng đến với TinaVibe'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  AuthInput(
                    label: "Họ và tên",
                    hintText: "",
                    controller: nameController,
                    validatorCallback: ValidationBuilder()
                        .required()
                        .minLength(3)
                        .maxLength(50)
                        .build(),
                  ),
                  const SizedBox(height: 20),
                  AuthInput(
                    label: "Email",
                    hintText: "",
                    controller: emailController,
                    validatorCallback:
                        ValidationBuilder().required().email().build(),
                  ),
                  const SizedBox(height: 20),
                  AuthInput(
                    label: "Mật khẩu",
                    hintText: "",
                    isPasswordField: true,
                    controller: passwordController,
                    validatorCallback: ValidationBuilder()
                        .required()
                        .minLength(6)
                        .maxLength(50)
                        .build(),
                  ),
                  const SizedBox(height: 20),
                  AuthInput(
                      label: "Xác nhận mật khẩu",
                      hintText: "",
                      isPasswordField: true,
                      controller: cpasswordController,
                      validatorCallback: (arg) {
                        if (passwordController.text != arg) {
                          return "Xác nhận mật khẩu không trùng khớp.";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => ElevatedButton(
                      onPressed: submit,
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          const Size.fromHeight(40),
                        ),
                      ),
                      child: Text(controller.registerLoading.value
                          ? "Đang xử lý.."
                          : "Tiếp tục"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: " Đăng nhập",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.toNamed(RouteNames.login))
                  ], text: "Đã có tài khoản ?"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
