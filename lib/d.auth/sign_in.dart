import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:medi_fypp/d.auth/signup.dart';

import '../constants.dart';
import '../lib/hommmmpage.dart';
import '../screens/Doctor Screen/DoctorHomePage.dart';

class DoctorSignIn extends StatelessWidget {
  DoctorSignIn({Key? key}) : super(key: key);
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          SvgPicture.asset(
            "assets/icons/Sign_Up_bg.svg",
            fit: BoxFit.cover,
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: SafeArea(
                child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign In',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text("Don't have an account"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DocotrSignUp()));
                          },
                          child: Text(
                            'Sign Up!',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: defaultPadding * 2,
                  ),
                  SignInForm(
                    formkey: formkey,
                  ),
                ],
              ),
            )),
          )
        ]));
  }
}

class SignInForm extends StatelessWidget {
  TextEditingController txt = TextEditingController();
  TextEditingController pass = TextEditingController();

  SignInForm({
    Key? key,
    required this.formkey,
  }) : super(key: key);
  final GlobalKey formkey;
  late String _user, _email, _phone, _password;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextFeild(text: 'Email'),
            TextFormField(
              controller: txt,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'text@gmail.com'),
              validator: EmailValidator(errorText: 'Use Valid Email'),
              // onSaved: (email) => _email = email!,
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            const TextFeild(text: 'Password'),
            TextFormField(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              controller: pass,
              obscureText: true,
              decoration: InputDecoration(hintText: '******'),
              validator: passwordValidator,
              // onSaved: (passs) => _password = passs!,
              onChanged: (pass) => _password = pass,
            ),
            SizedBox(
              height: defaultPadding * 2,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      signInDoctor('doctor.${txt.text}', pass.text, context);
                    },
                    child: Text('Sign In')))
          ],
        ));
  }
}

// class TextFeilds extends StatelessWidget {
//   const TextFeilds({
//     Key? key,
//     required this.text,
//   }) : super(key: key);
//   final String text;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: defaultPadding / 3),
//       child: Text(
//         text,
//         style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),
//       ),
//     );
//   }
// }

void signInDoctor(email, pass, BuildContext context) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);
    Navigator.push(context, MaterialPageRoute(builder: (_) => HomePageeee()));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}
