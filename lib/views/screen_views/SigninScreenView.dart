import 'package:flutter/material.dart';

import '../../view_models/SigninScreenViewModel.dart';

class SigninScreenView extends StatefulWidget {
  const SigninScreenView({super.key});

  @override
  State<SigninScreenView> createState() => _SigninScreenViewState();
}

class _SigninScreenViewState extends State<SigninScreenView> {
  final SigninScreenViewModel _vm = SigninScreenViewModel();

  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();

  String _errorText = '';
  String _errorText2 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          const Text('Signin Screen'),

          TextField(controller: _emailTextEditingController),
          TextField(controller: _passwordTextEditingController),

          TextButton(
            onPressed: () => {
              _vm.createAccount(_emailTextEditingController.text, _passwordTextEditingController.text).then((value) => {
                setState(() => _errorText = value)
              })
            },
            child: const Text('Create Account'),
          ),
          Text(_errorText),

          TextButton(
            onPressed: () => {
              _vm.signIn(_emailTextEditingController.text, _passwordTextEditingController.text).then((value) => {
                setState(() => _errorText2 = value)
              })
            },
            child: const Text('Login'),
          ),
          Text(_errorText2)

        ],
      )
    );
  }
}
