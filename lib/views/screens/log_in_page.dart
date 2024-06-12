
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:online_shop/services/auth_http_services.dart';
import 'package:online_shop/views/screens/home_page.dart';
import 'package:online_shop/views/screens/register_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();
  AuthHttpServices authHttpServices = AuthHttpServices();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  String? email, password;

  void onSaved() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        isLoading = true;
      });
      try {
        await authHttpServices.login(email!, password!);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const HomePage(),
            ));
      } catch (e) {
        String message = e.toString();
        // if (e.toString().contains("EMAIL_EXISTS")) {
        //   message = "Email don't match";
        // }
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Info"),
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
        title: const Text("Log in"),
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
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
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
                const Gap(80),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RegisterPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Create account",
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
                          "Log in",
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
