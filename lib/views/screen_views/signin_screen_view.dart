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
      color: ColorPalette.currentColorPalette.primaryBackground,

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
  Color? get color => ColorPalette.currentColorPalette.primaryBackground;

  @override
  Widget? get child => Container(
    margin: const EdgeInsets.fromLTRB(50, 0, 50, 15),

    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(1000)),
      color: ColorPalette.currentColorPalette.secondaryBackground,
      boxShadow: [
        ColorPalette.currentColorPalette.primaryShadow
      ]
    ),

    child: Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
      child: Row(
        children: [
          
          Expanded(
            child: TextField(
              controller: _emailTextEditingController,
              decoration: InputDecoration(
                hintText: 'Email',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: ColorPalette.currentColorPalette.hintText
                ),
              ),
              style: TextStyle(
                color: ColorPalette.currentColorPalette.text
              ),
            )
          ),

          Icon(
            Icons.email, 
            color: ColorPalette.currentColorPalette.text
          )

        ],
      ),
    )

  );
}

class _PasswordTextField extends Material {

  @override
  Color? get color => ColorPalette.currentColorPalette.primaryBackground;

  @override
  Widget? get child => Container(
    margin: const EdgeInsets.fromLTRB(50, 0, 50, 15),

    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(1000)),
      color: ColorPalette.currentColorPalette.secondaryBackground,
      boxShadow: [
        ColorPalette.currentColorPalette.primaryShadow
      ]
    ),

    child: Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _passwordTextEditingController,
              decoration: InputDecoration(
                hintText: 'Password',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: ColorPalette.currentColorPalette.hintText
                )
              ),
              style: TextStyle(
                color: ColorPalette.currentColorPalette.text
              ),
              obscureText: true,
            )
          ),
          Icon(
            Icons.lock, 
            color: ColorPalette.currentColorPalette.text
          )
        ],
      ),
    )

  );
}

class _ButtonRow extends Material {

  @override
  Color? get color => ColorPalette.currentColorPalette.primaryBackground;

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
  Color? get color => ColorPalette.currentColorPalette.primaryBackground;

  @override
  Widget? get child => Container(

    margin: const EdgeInsets.only(right: 10),

    constraints: const BoxConstraints(
      minHeight: 50,
      minWidth: 100
    ),

    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(1000)),
      color: ColorPalette.currentColorPalette.primary,
      boxShadow: [
        ColorPalette.currentColorPalette.primaryShadow
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
  Color? get color => ColorPalette.currentColorPalette.primaryBackground;

  @override
  Widget? get child => Container(

    constraints: const BoxConstraints(
      minHeight: 50,
      minWidth: 130
    ),

    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(1000)),
      color: ColorPalette.currentColorPalette.secondaryBackground,
      boxShadow: [
        ColorPalette.currentColorPalette.primaryShadow
      ]
    ),

    child: TextButton(
      onPressed: () {},
      child: Text(
        'Create Account',
        style: TextStyle(
          color: ColorPalette.currentColorPalette.text
        ),
      )
    )
    
  );
}