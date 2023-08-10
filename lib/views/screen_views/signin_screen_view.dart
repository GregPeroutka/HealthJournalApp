import 'package:flutter/material.dart';

import '../../color_palette.dart';
import '../../view_models/signin_screen_view_model.dart';

class SigninScreenView extends StatefulWidget {
  const SigninScreenView({super.key});

  @override
  State<SigninScreenView> createState() => _SigninScreenViewState();
}

final SigninScreenViewModel _vm = SigninScreenViewModel();

final TextEditingController _emailTextEditingController = TextEditingController();
final TextEditingController _passwordTextEditingController = TextEditingController();

class _SigninScreenViewState extends State<SigninScreenView> {

  @override
  Widget build(BuildContext context) {

    return Material(
      color: ColorPalette.lightColorPalette.primaryBackground,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          _EmailTextField(),
          _PasswordTextField(),
          _ButtonRow()

        ],
      ),
    );
  }
}

class _EmailTextField extends Material {

  @override
  Widget? get child => Container(
    margin: const EdgeInsets.fromLTRB(50, 0, 50, 15),

    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(1000)),
      color: ColorPalette.lightColorPalette.primaryBackground,
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(100, 0, 0, 0),
          blurRadius: 2,
          spreadRadius: 1,
        )
      ]
    ),

    child: Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _emailTextEditingController,
              decoration: const InputDecoration(
                hintText: 'Email',
                border: InputBorder.none
              ),
            )
          ),
          const Icon(Icons.email)
        ],
      ),
    )

  );
}

class _PasswordTextField extends Material {

  @override
  Widget? get child => Container(
    margin: const EdgeInsets.fromLTRB(50, 0, 50, 15),

    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(1000)),
      color: ColorPalette.lightColorPalette.primaryBackground,
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(100, 0, 0, 0),
          blurRadius: 2,
          spreadRadius: 1,
        )
      ]
    ),

    child: Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _passwordTextEditingController,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: InputBorder.none
              ),
              obscureText: true,
            )
          ),
          const Icon(Icons.lock)
        ],
      ),
    )

  );
}

class _ButtonRow extends Material {

  @override
  Widget? get child => Container(
    margin: const EdgeInsets.fromLTRB(50, 0, 50, 15),

    child: Row(
      children: [
        _LoginButton(),
        _CreateAccountButton()
      ],
    )
  );
}

class _LoginButton extends Material {

  @override
  Widget? get child => Container(

    margin: const EdgeInsets.only(right: 10),

    constraints: const BoxConstraints(
      minHeight: 50,
      minWidth: 100
    ),

    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(1000)),
      color: ColorPalette.currentColorPalette.contrastButton,
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(100, 0, 0, 0),
          blurRadius: 2,
          spreadRadius: 1,
        )
      ]
    ),

    child: TextButton(
      onPressed: () {
        _vm.signIn(
            _emailTextEditingController.text.toString(), 
            _passwordTextEditingController.text.toString()
          ).then((value) => {
          if(value) {
            
          }
        });
      },

      child: const Text(
        'Login',
        style: TextStyle(
          color: Colors.white
        ),
      )
    )
    
  );
}

class _CreateAccountButton extends Material {

  @override
  Widget? get child => Container(

    constraints: const BoxConstraints(
      minHeight: 50,
      minWidth: 130
    ),

    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(1000)),
      color: ColorPalette.currentColorPalette.primaryBackground,
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(100, 0, 0, 0),
          blurRadius: 2,
          spreadRadius: 1,
        )
      ]
    ),

    child: TextButton(
      onPressed: () {},
      child: const Text(
        'Create Account',
        style: TextStyle(
          color: Colors.black
        ),
      )
    )
    
  );
}