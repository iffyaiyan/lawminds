import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/primary_layout.dart';
import '../../providers/auth.dart';
import '../../utils/routes.dart';
import '../../utils/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PrimaryLayout(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Welcome Back!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  obscureText: context.watch<AuthProvider>().obscureLoginPass,
                  autocorrect: false,
                  decoration: Styles.outlineTextField(
                    label: 'Password',
                    hint: 'Enter your password',
                    suffixIcon: IconButton(
                      icon: Icon(context.watch<AuthProvider>().obscureLoginPass ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => context.read<AuthProvider>().obscureLoginPass = !context.read<AuthProvider>().obscureLoginPass,
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Password is required!';
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
              onPressed: context.read<AuthProvider>().isLoginProcess ? null : onSubmit,
              child: context.watch<AuthProvider>().isLoginProcess
                  ? const SizedBox(height: 25, width: 25, child: CircularProgressIndicator(backgroundColor: Colors.indigo, color: Colors.white, strokeWidth: 3))
                  : const Text('Login'),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              TextButton(
                child: const Text('Register'),
                onPressed: () => Navigator.pushNamed(context, Routes.register),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //action functions
  void onSubmit() {
    if (_formKey.currentState!.validate()) {

    }
  }
}
