import 'package:flutter/material.dart';
import 'package:my_health_journal/app_style.dart';
import 'package:my_health_journal/view_models/signin_screen_view_model.dart';

class SigninScreenView extends StatefulWidget {
  const SigninScreenView({super.key});

  @override
  State<SigninScreenView> createState() => _SigninScreenViewState();
}

final SigninScreenViewModel _signinScreenViewModel = SigninScreenViewModel();

final TextEditingController _emailTextEditingController = TextEditingController();
final TextEditingController _passwordTextEditingController = TextEditingController();

class _SigninScreenViewState extends State<SigninScreenView> {

  @override
  Widget build(BuildContext context) {

    return Material(
      color: AppStyle.currentStyle.backgroundColor1,

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
  Color? get color => AppStyle.currentStyle.backgroundColor1;

  @override
  Widget? get child => Container(
    margin: const EdgeInsets.fromLTRB(50, 0, 50, 15),

    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(AppStyle.currentStyle.completelyRoundRadius)),
      color: AppStyle.currentStyle.backgroundColor2,
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(0, 37, 37, 37),
          blurRadius: 1.5,
          spreadRadius: 2.5,
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
              decoration: InputDecoration(
                hintText: 'Email',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: AppStyle.currentStyle.textColor2
                ),
              ),
              style: TextStyle(
                color: AppStyle.currentStyle.textColor1
              ),
            )
          ),

          Icon(
            Icons.email, 
            color: AppStyle.currentStyle.textColor1
          )

        ],
      ),
    )

  );
}

class _PasswordTextField extends Material {

  @override
  Color? get color => AppStyle.currentStyle.backgroundColor1;

  @override
  Widget? get child => Container(
    margin: const EdgeInsets.fromLTRB(50, 0, 50, 15),

    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(AppStyle.currentStyle.completelyRoundRadius)),
      color: AppStyle.currentStyle.backgroundColor2,
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(0, 37, 37, 37),
          blurRadius: 1.5,
          spreadRadius: 2.5,
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
              decoration: InputDecoration(
                hintText: 'Password',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: AppStyle.currentStyle.textColor2
                )
              ),
              style: TextStyle(
                color: AppStyle.currentStyle.textColor1
              ),
              obscureText: true,
            )
          ),
          Icon(
            Icons.lock, 
            color: AppStyle.currentStyle.textColor1
          )
        ],
      ),
    )

  );
}

class _ButtonRow extends Material {

  @override
  Color? get color => AppStyle.currentStyle.backgroundColor1;

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
  Color? get color => AppStyle.currentStyle.backgroundColor1;

  @override
  Widget? get child => Container(

    margin: const EdgeInsets.only(right: 10),

    constraints: const BoxConstraints(
      minHeight: 50,
      minWidth: 100
    ),

    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(AppStyle.currentStyle.completelyRoundRadius)),
      color: AppStyle.currentStyle.highlightColor1,
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(0, 37, 37, 37),
          blurRadius: 1.5,
          spreadRadius: 2.5,
        )
      ]
    ),

    child: TextButton(
      onPressed: () {
        _signinScreenViewModel.signIn(
          _emailTextEditingController.text.toString(), 
          _passwordTextEditingController.text.toString()
        );
      },

      child: Text(
        'Login',
        style: TextStyle(
          color: AppStyle.currentStyle.contrastTextColor1
        ),
      )
    )
    
  );
}

class _CreateAccountButton extends Material {

  @override
  Color? get color => AppStyle.currentStyle.backgroundColor1;

  @override
  Widget? get child => Container(

    constraints: const BoxConstraints(
      minHeight: 50,
      minWidth: 130
    ),

    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(AppStyle.currentStyle.completelyRoundRadius)),
      color: AppStyle.currentStyle.backgroundColor2,
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(0, 37, 37, 37),
          blurRadius: 1.5,
          spreadRadius: 2.5,
        )
      ]
    ),

    child: TextButton(
      onPressed: () {},
      child: Text(
        'Create Account',
        style: TextStyle(
          color: AppStyle.currentStyle.textColor1
        ),
      )
    )
    
  );
}