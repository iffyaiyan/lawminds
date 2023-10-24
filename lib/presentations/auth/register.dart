import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/primary_layout.dart';
import '../../providers/auth.dart';
import '../../utils/routes.dart';
import '../../utils/styles.dart';
import '../../utils/validators.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PrimaryLayout(
      body: Column(
        children: [
          const Text('Register Now!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: Styles.outlineTextField(
                    label: 'Email',
                    hint: 'Enter your email address',
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Email is required!';
                    }

                    if (!Validators.isValidEmail(val)) {
                      return 'Email is invalid!';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  obscureText: context.watch<AuthProvider>().obscureRegisterPass,
                  autocorrect: false,
                  decoration: Styles.outlineTextField(
                    label: 'Password',
                    hint: 'Enter your password',
                    suffixIcon: IconButton(
                      icon: Icon(context.watch<AuthProvider>().obscureRegisterPass ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => context.read<AuthProvider>().obscureRegisterPass = !context.read<AuthProvider>().obscureRegisterPass,
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Password is required!';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  obscureText: context.watch<AuthProvider>().obscureConfirmPass,
                  autocorrect: false,
                  decoration: Styles.outlineTextField(
                    label: 'Confirm Password',
                    hint: 'Confirm your password',
                    suffixIcon: IconButton(
                      icon: Icon(context.watch<AuthProvider>().obscureConfirmPass ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => context.read<AuthProvider>().obscureConfirmPass = !context.read<AuthProvider>().obscureConfirmPass,
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Confirm Password is required!';
                    }

                    if (val != _passwordController.text) {
                      return 'Passwords do not match!';
                    }

                    return null;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: Styles.primaryElevatedButton,
              onPressed: context.read<AuthProvider>().isRegisterProcess ? null : onSubmit,
              child: context.watch<AuthProvider>().isRegisterProcess
                  ? const SizedBox(height: 25, width: 25, child: CircularProgressIndicator(backgroundColor: Colors.indigo, color: Colors.white, strokeWidth: 3))
                  : const Text('Register'),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account?"),
              TextButton(
                child: const Text('Login'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //action functions
  Future<void> onSubmit() async {
    if (_formKey.currentState!.validate()) {
      context.read<AuthProvider>().register(_emailController.text, _passwordController.text).then((_) {
        Navigator.pushReplacementNamed(context, Routes.dashboard);
      }).catchError((_) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Signup failed'),
          backgroundColor: Colors.red,
        ));
      });
    }
  }
}
