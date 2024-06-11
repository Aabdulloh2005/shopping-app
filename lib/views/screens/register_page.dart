import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:online_shop/services/auth_http_services.dart';
import 'package:online_shop/views/screens/log_in_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  AuthHttpServices authHttpServices = AuthHttpServices();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  bool isLoading = false;
  String? email, password, confirmpassword;

  void onSaved() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        isLoading = true;
      });
      try {
        await authHttpServices.register(email!, password!);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LogInPage()));
      } catch (e) {
        String message = e.toString();
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Xatolik"),
              content: Text(message),
            );
          },
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        title: const Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (newValue) {
                    email = newValue;
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter email";
                    }
                    if (!value.contains("@") || !value.contains(".")) {
                      return "Wrong email";
                    }
                    return null;
                  },
                ),
                const Gap(20),
                TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (newValue) {
                    password = newValue;
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter password";
                    }

                    if (value.length < 6) {
                      return "Less than 6";
                    }
                    return null;
                  },
                ),
                const Gap(20),
                TextFormField(
                  controller: confirmController,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: "Confirm password",
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (newValue) {
                    confirmpassword = newValue;
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter password";
                    }
                    if (value.length < 6) {
                      return "Less than 6";
                    }

                    if (passwordController.text != confirmController.text) {
                      return "The password don't match";
                    }

                    return null;
                  },
                ),
                const Gap(80),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LogInPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Log in",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.purple,
                    ),
                  ),
                ),
                isLoading
                    ? const CircularProgressIndicator()
                    : FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.purple,
                        ),
                        onPressed: onSaved,
                        child: const Text(
                          "Create account",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
